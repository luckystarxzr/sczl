package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/sczl";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 获取请求参数
        String commentIdParam = request.getParameter("commentId");
        String attractionIdParam = request.getParameter("attractionId");
        String reason = request.getParameter("reason");

        // 获取评论者名字
        String commentAuthor = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        try (Connection connection = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            // 获取评论者名字
            String commentQuery = "SELECT username FROM comments WHERE id = ?";
            try (PreparedStatement commentStatement = connection.prepareStatement(commentQuery)) {
                commentStatement.setInt(1, Integer.parseInt(commentIdParam));
                try (ResultSet rs = commentStatement.executeQuery()) {
                    if (rs.next()) {
                        commentAuthor = rs.getString("username");
                    }
                }
            }
            System.out.println("Reporter Username: " + commentAuthor);

            // 插入举报记录到数据库
            String sql = "INSERT INTO reports (username , comment_id, attraction_id, reason, report_time) VALUES (?, ?, ?, ?, NOW())";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, commentAuthor);
                ps.setInt(2, Integer.parseInt(commentIdParam));
                ps.setInt(3, Integer.parseInt(attractionIdParam));
                ps.setString(4, reason);

                int rowsInserted = ps.executeUpdate();
                if (rowsInserted > 0) {
                    request.setAttribute("message", "举报提交成功！");
                    request.setAttribute("commentAuthor", commentAuthor);  // 设置评论者名字
                } else {
                    request.setAttribute("message", "举报提交失败，请重试。");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "数据库错误：" + e.getMessage());
        }

        // 转发回景点详情页面并携带消息
        String redirectUrl = "attractionDetail.jsp?id=" + attractionIdParam;
        request.getRequestDispatcher(redirectUrl).forward(request, response);
    }
}



