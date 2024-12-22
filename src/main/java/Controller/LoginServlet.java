package Controller;

import java.io.*;
import java.sql.*;
import javax.crypto.*;
import javax.crypto.spec.PBEKeySpec;
import java.util.Arrays;
import java.util.Base64;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // 导入 HttpSession

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // 验证密码的方法
    public static boolean verifyPassword(String inputPassword, String storedPassword) throws Exception {
        // 从存储的密码中分离盐值和加密后的密码
        String[] parts = storedPassword.split("\\$");
        byte[] salt = Base64.getDecoder().decode(parts[0]);
        byte[] storedHash = Base64.getDecoder().decode(parts[1]);

        // 使用相同的盐值和输入的密码生成哈希值
        PBEKeySpec spec = new PBEKeySpec(inputPassword.toCharArray(), salt, 10000, 256); // 10000次迭代
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        byte[] inputHash = factory.generateSecret(spec).getEncoded();

        // 比较哈希值
        return Arrays.equals(storedHash, inputHash);
    }

    // 处理登录请求
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String message = "";

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
                // 查询用户
                String query = "SELECT * FROM users WHERE username = ?";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, username);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    // 获取存储的加密密码
                    String storedPassword = rs.getString("password");

                    // 验证密码是否匹配
                    if (verifyPassword(password, storedPassword)) {
                        // 获取用户角色
                        String role = rs.getString("role");

                        // 获取 HttpSession 对象
                        HttpSession session = request.getSession();

                        // 将用户信息保存在 Session 中
                        session.setAttribute("username", username);
                        session.setAttribute("role", role);

                        // 根据角色重定向
                        if ("ADMIN".equals(role)) {
                            response.sendRedirect("adminboard.jsp");
                            return;
                        } else {
                            // 普通用户重定向到 index.jsp
                            response.sendRedirect("index.jsp");
                            return;
                        }
                    } else {
                        message = "密码错误！";
                    }
                } else {
                    message = "用户名不存在！";
                }
            } catch (Exception e) {
                message = "登录失败: " + e.getMessage();
            }
        }

        // 如果没有重定向，就继续处理，转发到登录页面，并显示消息
        request.setAttribute("message", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }
}
