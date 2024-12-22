package Controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/deleteNews")
public class DeleteNewsServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/sczl";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应内容类型为JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String newsId = request.getParameter("newsId");
        if (newsId == null || newsId.trim().isEmpty()) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"无效的新闻ID\"}");
            return;
        }

        try {
            int newsIdInt = Integer.parseInt(newsId); // 确保是整数
            try (Connection connection = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String sql = "DELETE FROM news WHERE id = ?";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setInt(1, newsIdInt);
                    int rowsAffected = preparedStatement.executeUpdate();

                    PrintWriter out = response.getWriter();
                    if (rowsAffected > 0) {
                        out.write("{\"status\":\"success\", \"message\":\"删除成功\"}");
                    } else {
                        out.write("{\"status\":\"error\", \"message\":\"未找到对应新闻\"}");
                    }
                }
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"无效的新闻ID\"}");
        } catch (SQLException e) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"数据库错误: " + e.getMessage() + "\"}");
        }
    }
}
