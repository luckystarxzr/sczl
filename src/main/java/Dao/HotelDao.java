package Dao;

import java.sql.*;
import java.util.*;
import Model.Hotel;

public class HotelDao {
    private final Connection connection;

    public HotelDao(Connection connection) {
        this.connection = connection;
    }

    // 获取所有酒店，支持分页
    public List<Hotel> getHotelsByPage(int pageNumber, int pageSize) throws SQLException {
        String sql = "SELECT * FROM hotels ORDER BY id DESC LIMIT ? OFFSET ?";
        // 加载 MySQL JDBC 驱动
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        // 计算 OFFSET 值
        int offset = (pageNumber - 1) * pageSize;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, pageSize);
            ps.setInt(2, offset);

            try (ResultSet rs = ps.executeQuery()) {
                List<Hotel> hotels = new ArrayList<>();
                while (rs.next()) {
                    Hotel hotel = new Hotel(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getString("location"),
                            rs.getString("contact_phone"),
                            rs.getString("email"),
                            rs.getString("image_url"),
                            rs.getBigDecimal("price_per_night"),
                            rs.getTimestamp("created_at"),
                            rs.getTimestamp("updated_at")
                    );
                    hotels.add(hotel);
                }
                return hotels;
            }
        }
    }

    // 获取酒店的总数
    public int getHotelCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM hotels";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }

    // 添加新酒店
    public boolean addHotel(Hotel hotel) throws SQLException {
        String sql = "INSERT INTO hotels (name, description, location, price_per_night, contact_phone, email, image_url) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, hotel.getName());
            ps.setString(2, hotel.getDescription());
            ps.setString(3, hotel.getLocation());
            ps.setBigDecimal(4, hotel.getPricePerNight());
            ps.setString(5, hotel.getContactPhone());
            ps.setString(6, hotel.getEmail());
            ps.setString(7, hotel.getImageUrl());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteHotel(int hotelId) throws SQLException {
        // 检查酒店是否存在
        String checkSql = "SELECT COUNT(*) FROM hotels WHERE id = ?";
        try (PreparedStatement checkPs = connection.prepareStatement(checkSql)) {
            checkPs.setInt(1, hotelId);
            try (ResultSet rs = checkPs.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    // 酒店存在，执行删除操作
                    String sql = "DELETE FROM hotels WHERE id = ?";
                    try (PreparedStatement ps = connection.prepareStatement(sql)) {
                        ps.setInt(1, hotelId);
                        return ps.executeUpdate() > 0;
                    }
                } else {
                    return false;  // 酒店不存在
                }
            }
        }
    }


    // 修改酒店信息
    public boolean updateHotel(Hotel hotel) throws SQLException {
        String sql = "UPDATE hotels SET name = ?, description = ?, location = ?, price_per_night = ?, contact_phone = ?, email = ?, image_url = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, hotel.getName());
            ps.setString(2, hotel.getDescription());
            ps.setString(3, hotel.getLocation());
            ps.setBigDecimal(4, hotel.getPricePerNight());
            ps.setString(5, hotel.getContactPhone());
            ps.setString(6, hotel.getEmail());
            ps.setString(7, hotel.getImageUrl());
            ps.setInt(8, hotel.getId());
            return ps.executeUpdate() > 0;
        }
    }
}

