package Controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/comment")
public class CommentServlet extends HttpServlet {

    // 数据库连接参数
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/sczl";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置字符编码
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 获取会话中的用户名
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // 获取ID和评论内容
        String attractionId = request.getParameter("id");
        String comment = request.getParameter("comment");
        String message = "";

        // 验证用户登录状态和评论内容
        if (username == null || comment == null || comment.trim().isEmpty()) {
            response.sendRedirect("error.jsp?message=请先登录并输入评论内容");
            return;
        }

        Connection connection = null;
        PreparedStatement ps = null;

        try {
            // 加载数据库驱动
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 创建数据库连接
            connection = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);

            // 开始事务
            connection.setAutoCommit(false);

            // 准备插入评论的 SQL 语句
            String sql = "INSERT INTO comments (attraction_id, username, comment, comment_time) VALUES (?, ?, ?, NOW())";
            ps = connection.prepareStatement(sql);

            // 设置参数
            ps.setInt(1, Integer.parseInt(attractionId));  // 将 attraction_id 转为整数
            ps.setString(2, username);               // 设置用户名
            ps.setString(3, comment);                // 设置评论内容

            // 执行插入操作
            int rows = ps.executeUpdate();

            if (rows > 0) {
                // 提交事务
                connection.commit();
                message = "评论提交成功！";
            } else {
                // 提交事务
                connection.commit();
                message = "评论提交失败！";
            }
        } catch (SQLException | ClassNotFoundException e) {
            // 如果发生异常，回滚事务
            try {
                if (connection != null) connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            message="数据库错误!";
        } finally {
            // 关闭数据库连接和 PreparedStatement
            if (ps != null) {
                try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (connection != null) {
                try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        // 显示消息并跳转回密码修改页面
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write("<script type='text/javascript'>"
                + "alert('" + message + "');"
                + "window.location.href = 'attractionDetail.jsp?id=" + attractionId + "';"
                + "</script>");
    }
}

