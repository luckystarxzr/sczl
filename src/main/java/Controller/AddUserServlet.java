package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

@WebServlet("/addUser")
public class AddUserServlet extends HttpServlet {

    // 生成加密密码的方法
    private static String generateEncryptedPassword(String password) throws Exception {
        // 创建一个盐值
        byte[] salt = new byte[16];
        // 使用系统时间或随机数生成盐值
        for (int i = 0; i < salt.length; i++) {
            salt[i] = (byte) (Math.random() * 256);
        }

        // 使用PBKDF2算法生成密码哈希
        PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), salt, 10000, 256); // 10000次迭代
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        byte[] hash = factory.generateSecret(spec).getEncoded();

        // 将盐值和哈希值一起编码并返回
        String saltBase64 = Base64.getEncoder().encodeToString(salt);
        String hashBase64 = Base64.getEncoder().encodeToString(hash);

        // 调试输出加密过程
        System.out.println("Salt: " + saltBase64);
        System.out.println("Hash: " + hashBase64);

        return saltBase64 + "$" + hashBase64;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取请求参数
        String newUser = request.getParameter("newUser");
        String newRole = request.getParameter("newRole");
        String newPassword = request.getParameter("newPassword");
        String resultMessage = "";

        // 检查参数是否有效
        if (newUser == null || newRole == null || newPassword == null ||
                newUser.isEmpty() || newRole.isEmpty() || newPassword.isEmpty()) {
            // 参数为空或无效
            resultMessage = "{\"error\": \"输入无效，请填写所有字段\"}";
        } else {
            String url = "jdbc:mysql://localhost:3306/sczl?useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPass = "123456";

            try {
                // 加载 JDBC 驱动
                Class.forName("com.mysql.cj.jdbc.Driver");

                // 连接数据库
                try (Connection conn = DriverManager.getConnection(url, dbUser, dbPass)) {
                    // 对密码进行加密处理
                    String encryptedPassword = generateEncryptedPassword(newPassword);
                    System.out.println("Encrypted Password: " + encryptedPassword);

                    // 插入新用户的 SQL 语句
                    String sql = "INSERT INTO users (username, role, password, status) VALUES (?, ?, ?, 'active')";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, newUser);
                    pstmt.setString(2, newRole);
                    pstmt.setString(3, encryptedPassword);

                    // 执行插入操作
                    pstmt.executeUpdate();
                    resultMessage = "{\"success\": \"用户 " + newUser + " 已成功添加!\"}";
                }
            } catch (Exception e) {
                e.printStackTrace();
                resultMessage = "{\"error\": \"添加用户失败！请检查信息是否正确。\"}";
            }
        }

        // 返回消息并跳转
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write("<script type='text/javascript'>"
                + "alert('" + resultMessage + "');"
                + "window.location.href = 'adminboard.jsp';"
                + "</script>");
    }
}
