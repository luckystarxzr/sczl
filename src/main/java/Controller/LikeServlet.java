package Controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;


@WebServlet("/like")
public class LikeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idParam = request.getParameter("id");
        String isLikedParam = request.getParameter("isLiked");

        if (idParam != null && isLikedParam != null) {
            int id = Integer.parseInt(idParam);
            boolean isLiked = Boolean.parseBoolean(isLikedParam);

            Connection connection = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                String jdbcUrl = "jdbc:mysql://localhost:3306/sczl";
                String dbUser = "root";
                String dbPassword = "123456";
                connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // 获取当前点赞数
                String selectSql = "SELECT likes FROM attractions WHERE id = ?";
                ps = connection.prepareStatement(selectSql);
                ps.setInt(1, id);
                rs = ps.executeQuery();

                int currentLikes = 0;
                if (rs.next()) {
                    currentLikes = rs.getInt("likes");
                }

                // 更新点赞数
                int updatedLikes = isLiked ? currentLikes - 1 : currentLikes + 1;
                String updateSql = "UPDATE attractions SET likes = ? WHERE id = ?";
                try (PreparedStatement updatePs = connection.prepareStatement(updateSql)) {
                    updatePs.setInt(1, updatedLikes);
                    updatePs.setInt(2, id);
                    updatePs.executeUpdate();
                }

                // 返回 JSON 响应
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true}");

            } catch (SQLException e) {
                e.printStackTrace();
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false}");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

