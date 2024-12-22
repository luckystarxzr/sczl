package Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.security.*;
import javax.crypto.*;
import javax.crypto.spec.PBEKeySpec;
import java.sql.*;
import java.util.Base64;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    // PBKDF2 加密方法
    public static String encryptPassword(String password) throws Exception {
        // 盐值的生成
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16]; // 16字节盐值
        random.nextBytes(salt);

        // PBKDF2 加密
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 10000, 256); // 10000次迭代
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        byte[] hashedPassword = factory.generateSecret(spec).getEncoded();

        // 返回盐值和加密密码（盐值 + 加密后的密码，使用 $ 分隔）
        return Base64.getEncoder().encodeToString(salt) + "$" + Base64.getEncoder().encodeToString(hashedPassword);
    }

    // 处理注册请求
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String message;

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            message = "用户名和密码不能为空！";
        } else {
            // 使用数据库连接信息
            String DB_URL = "jdbc:mysql://localhost:3306/sczl";
            String DB_USER = "root";
            String DB_PASSWORD = "123456";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            }
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // 检查用户名是否已存在
                String checkUserQuery = "SELECT * FROM users WHERE username = ?";
                PreparedStatement pstmt = conn.prepareStatement(checkUserQuery);
                pstmt.setString(1, username);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    message = "用户名已存在，请选择其他用户名！";
                } else {
                    // 对密码进行加密
                    String encryptedPassword = encryptPassword(password);

                    // 插入新用户到数据库
                    String insertQuery = "INSERT INTO users (username, password, role, status) VALUES (?, ?, ?, 'active')";
                    pstmt = conn.prepareStatement(insertQuery);
                    pstmt.setString(1, username);
                    pstmt.setString(2, encryptedPassword);
                    pstmt.setString(3, "user"); // 角色为普通用户
                    pstmt.executeUpdate();

                    message = "注册成功！";
                }
            } catch (Exception e) {
                message = "注册失败: " + e.getMessage();
            }
        }

        // 将消息发送到注册页面
        request.setAttribute("message", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
        dispatcher.forward(request, response);
    }
}
