package Controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/getNewsById")
public class GetNewsByIdServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int newsId = Integer.parseInt(request.getParameter("id"));
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sczl", "root", "123456");

            String sql = "SELECT * FROM news WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, newsId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // 获取新闻数据
                String title = rs.getString("title");
                String author = rs.getString("author");
                String content = rs.getString("content");
                String filePath = rs.getString("file_path");

                // 构造 JSON 响应
                String jsonResponse = String.format(
                        "{\"title\": \"%s\", \"author\": \"%s\", \"content\": \"%s\", \"file_path\": \"%s\"}",
                        title, author, content, filePath
                );

                response.setContentType("application/json");
                response.getWriter().write(jsonResponse);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"message\": \"新闻未找到\"}");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"message\": \"服务器错误\"}");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }
}
