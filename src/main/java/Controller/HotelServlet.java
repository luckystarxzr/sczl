package Controller;

import Model.Hotel;
import jakarta.servlet.annotation.WebServlet;
import java.sql.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/hotel")
public class HotelServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/sczl";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        String city = request.getParameter("city");
        System.out.println("City parameter received: " + city);  // 输出获取的城市参数
        if (city == null || city.trim().isEmpty()) {
            request.setAttribute("error", "城市名称不能为空！");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        List<Hotel> hotels = new ArrayList<>();
        // 加载 MySQL JDBC 驱动
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT name, description, location, price_per_night, contact_phone, email, image_url FROM hotels WHERE location = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, city);
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    Hotel hotel = new Hotel();
                    hotel.setName(rs.getString("name"));
                    hotel.setDescription(rs.getString("description"));
                    hotel.setLocation(rs.getString("location"));
                    hotel.setPricePerNight(rs.getBigDecimal("price_per_night"));
                    hotel.setContactPhone(rs.getString("contact_phone"));
                    hotel.setEmail(rs.getString("email"));
                    hotel.setImageUrl(rs.getString("image_url"));
                    hotels.add(hotel);
                }

                if (hotels.isEmpty()) {
                    request.setAttribute("message", "未找到符合条件的酒店！");
                }

                request.setAttribute("hotels", hotels);
                request.getRequestDispatcher("hotel.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            // 打印详细错误信息
            e.printStackTrace();
            request.setAttribute("error", "数据库连接失败: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            // 捕获其他类型的异常
            e.printStackTrace();
            request.setAttribute("error", "发生了未知错误: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
