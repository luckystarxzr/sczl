package Controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
@WebServlet("/updateNews")
public class UpdateNewsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int newsId = Integer.parseInt(request.getParameter("newsId"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String content = request.getParameter("content");
        String fileUrl = request.getParameter("url");
        String newsIdParam = request.getParameter("newsId");
        if (newsIdParam == null || newsIdParam.isEmpty()) {
            // 处理错误，返回400 Bad Request
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "newsId cannot be null or empty");
            return;
        }
        try {
            newsId = Integer.parseInt(newsIdParam);  // 尝试将 newsId 转换为数字
        } catch (NumberFormatException e) {
            // 处理数字解析失败的情况
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid newsId format");
            return;
        }
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sczl", "root", "123456");

            // SQL query to update the news record
            String updateSQL = "UPDATE news SET title = ?, author = ?, content = ?, file_path = ? WHERE id = ?";
            stmt = conn.prepareStatement(updateSQL);
            stmt.setString(1, title);
            stmt.setString(2, author);
            stmt.setString(3, content);
            stmt.setString(4, fileUrl);
            stmt.setInt(5, newsId);

            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.setContentType("application/json");
                response.getWriter().write("{\"message\": \"News updated successfully!\"}");
            } else {
                response.getWriter().write("{\"message\": \"Failed to update news.\"}");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"message\": \"Error occurred while updating news.\"}");
        } finally {
            try { if (stmt != null) stmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }
}

