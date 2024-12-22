package Controller;

import java.io.*;
import java.sql.*;
import javax.crypto.*;
import javax.crypto.spec.PBEKeySpec;
import java.util.Arrays;
import java.util.Base64;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/updatePassword")
public class UpdatePasswordServlet extends HttpServlet {
    // 密码加密方法
    public static String encryptPassword(String password) throws Exception {
        // 生成盐
        byte[] salt = new byte[16]; // 固定长度盐
        new java.security.SecureRandom().nextBytes(salt);

        // 使用PBKDF2加密算法生成密码哈希
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 10000, 256);
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        byte[] hash = factory.generateSecret(spec).getEncoded();

        // 将盐和加密后的密码编码为 Base64 并返回
        return Base64.getEncoder().encodeToString(salt) + "$" + Base64.getEncoder().encodeToString(hash);
    }

    // 处理密码更新请求
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String newPassword = request.getParameter("newpass");
        String message = "";

        if (username == null || username.trim().isEmpty() || newPassword == null || newPassword.trim().isEmpty()) {
            message = "用户名和新密码不能为空！";
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
                // 获取新的加密密码
                String encryptedPassword = encryptPassword(newPassword);

                // 更新密码的 SQL 语句
                String updateQuery = "UPDATE users SET password = ? WHERE username = ?";
                PreparedStatement pstmt = conn.prepareStatement(updateQuery);
                pstmt.setString(1, encryptedPassword);
                pstmt.setString(2, username);

                int rowsUpdated = pstmt.executeUpdate();

                if (rowsUpdated > 0) {
                    message = "密码更新成功！";
                } else {
                    message = "用户名不存在！";
                }
            } catch (Exception e) {
                e.printStackTrace();
                message = "更新密码失败: " + e.getMessage();
            }
        }

        // 显示消息并跳转回密码修改页面
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write("<script type='text/javascript'>"
                + "alert('" + message + "');"
                + "window.location.href = 'adminboard.jsp';"
                + "</script>");
    }
}
