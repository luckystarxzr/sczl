package Controller;

import Dao.HotelDao;
import Model.Hotel;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;

@WebServlet("/hotelManagement")
public class HotelManagementServlet extends HttpServlet {
    private HotelDao hotelDao;
    @Override
    public void init() throws ServletException {
        // 加载 MySQL JDBC 驱动
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        try {
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sczl", "root", "123456");
            hotelDao = new HotelDao(connection);
        } catch (SQLException e) {
            throw new ServletException("Database connection error", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 获取分页参数
            int pageNumber = 1;
            int pageSize = 10;  // 每页显示 10 条酒店记录

            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                pageNumber = Integer.parseInt(pageParam);
            }

            // 获取酒店数据
            List<Hotel> hotels = hotelDao.getHotelsByPage(pageNumber, pageSize);

            // 获取酒店总数并计算总页数
            int totalHotels = hotelDao.getHotelCount();
            int totalPages = (int) Math.ceil((double) totalHotels / pageSize);

            // 将数据传递给 JSP 页面
            request.setAttribute("hotels", hotels);
            request.setAttribute("currentPage", pageNumber);
            request.setAttribute("totalPages", totalPages);

            // 转发到酒店管理页面
            RequestDispatcher dispatcher = request.getRequestDispatcher("hotelManagement.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving hotel data", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                // 从请求中获取数据并创建新酒店
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                String location = request.getParameter("location");
                BigDecimal pricePerNight = new BigDecimal(request.getParameter("price_per_night"));
                String contactPhone = request.getParameter("contact_phone");
                String email = request.getParameter("email");
                String imageUrl = request.getParameter("image_url");

                Hotel hotel = new Hotel(0, name, description, location, contactPhone, email, imageUrl, pricePerNight, null, null);
                hotelDao.addHotel(hotel);
            } else if ("delete".equals(action)) {
                int hotelId = Integer.parseInt(request.getParameter("hotel_id"));
                boolean deleted = hotelDao.deleteHotel(hotelId);
                if (!deleted) {
                    request.setAttribute("error", "酒店删除失败，未找到该酒店！");
                }
            } else if ("update".equals(action)) {
                int hotelId = Integer.parseInt(request.getParameter("hotel_id"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                String location = request.getParameter("location");
                BigDecimal pricePerNight = new BigDecimal(request.getParameter("price_per_night"));
                String contactPhone = request.getParameter("contact_phone");
                String email = request.getParameter("email");
                String imageUrl = request.getParameter("image_url");
                Hotel hotel = new Hotel(hotelId, name, description, location, contactPhone, email, imageUrl, pricePerNight, null, null);
                hotelDao.updateHotel(hotel);
            }
        } catch (SQLException e) {
            throw new ServletException("Error processing hotel action", e);
        }
        response.sendRedirect("hotelManagement");
    }
}
