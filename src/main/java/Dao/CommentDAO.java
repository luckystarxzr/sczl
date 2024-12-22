package Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Model.Attractions;
import Model.Comment;

public class CommentDAO {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/sczl";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456";

    // 获取数据库连接
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }

    // 获取新闻详情
    public static Attractions getAttractionsDetail(int AttractionsId) throws SQLException {
        String sql = "SELECT * FROM attractions WHERE id = ?";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, AttractionsId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Attractions(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("location"),
                        rs.getString("image_url"),
                        rs.getInt("likes"),
                        rs.getDouble("ticket_price")
                );
            }
        }
        return null;
    }

    // 获取评论总数
    public int getTotalComments(int AttractionsId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM comments WHERE Attractions_id = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, AttractionsId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // 获取分页评论
    public List<Comment> getCommentsByPage(int AttractionsId, int page, int pageSize) throws SQLException {
        List<Comment> commentList = new ArrayList<>();
        String sql = "SELECT * FROM comments WHERE Attractions_id = ? ORDER BY comment_time DESC LIMIT ?, ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, AttractionsId);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Comment comment = new Comment();
                comment.setId(rs.getInt("id"));
                comment.setUsername(rs.getString("username"));
                comment.setComment(rs.getString("comment"));
                comment.setCommentTime(rs.getTimestamp("comment_time"));
                commentList.add(comment);
            }
        }
        return commentList;
    }

    // 添加评论
    public void addComment(int AttractionsId, String username, String commentContent) throws SQLException {
        String sql = "INSERT INTO comments(Attractions_id, username, comment, comment_time) VALUES(?, ?, ?, NOW())";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, AttractionsId);
            ps.setString(2, username);
            ps.setString(3, commentContent);
            ps.executeUpdate();
        }
    }
}

