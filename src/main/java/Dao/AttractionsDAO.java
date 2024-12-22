package Dao;

import Model.Attractions;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttractionsDAO {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/sczl";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456";

    // 获取数据库连接
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }

    // 获取所有景点
    public List<Attractions> getAllAttractions() throws SQLException {
        List<Attractions> attractionsList = new ArrayList<>();
        String sql = "SELECT * FROM attractions";
        try (Connection connection = getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Attractions attraction = new Attractions(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("location"),
                        rs.getString("image_url"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at"),
                        rs.getInt("likes"),
                        rs.getDouble("ticket_price")
                );
                attractionsList.add(attraction);
            }
        }
        return attractionsList;
    }

    // 根据ID获取单个景点
    public Attractions getAttractionById(int id) throws SQLException {
        String sql = "SELECT * FROM attractions WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Attractions(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("location"),
                        rs.getString("image_url"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at"),
                        rs.getInt("likes"),
                        rs.getDouble("ticket_price")
                );
            }
        }
        return null;
    }

    // 插入新的景点
    public void addAttraction(Attractions attraction) throws SQLException {
        String sql = "INSERT INTO attractions (name, description, location, image_url, likes, ticket_price) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, attraction.getName());
            ps.setString(2, attraction.getDescription());
            ps.setString(3, attraction.getLocation());
            ps.setString(4, attraction.getImageUrl());
            ps.setInt(5, attraction.getLikes());
            ps.setDouble(6, attraction.getTicketPrice());
            ps.executeUpdate();
        }
    }

    // 更新景点信息
    public void updateAttraction(Attractions attraction) throws SQLException {
        String sql = "UPDATE attractions SET name = ?, description = ?, location = ?, image_url = ?, likes = ?, ticket_price = ?, updated_at = NOW() WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, attraction.getName());
            ps.setString(2, attraction.getDescription());
            ps.setString(3, attraction.getLocation());
            ps.setString(4, attraction.getImageUrl());
            ps.setInt(5, attraction.getLikes());
            ps.setDouble(6, attraction.getTicketPrice());
            ps.setInt(7, attraction.getId());
            ps.executeUpdate();
        }
    }

    // 删除景点
    public void deleteAttraction(int id) throws SQLException {
        String sql = "DELETE FROM attractions WHERE id = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
