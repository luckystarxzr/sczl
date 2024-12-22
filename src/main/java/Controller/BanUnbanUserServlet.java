package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/BanUnban")
public class BanUnbanUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取用户名和操作类型
        String username = request.getParameter("username");
        String action = request.getParameter("action");
        String resultMessage = "";

        // 检查用户名和操作是否为空
        if (username != null && action != null) {
            // 数据库连接参数
            String url = "jdbc:mysql://localhost:3306/sczl?useSSL=false&serverTimezone=UTC";
            String dbUser = "root";
            String dbPass = "123456";

            try {
                // 加载 MySQL JDBC 驱动
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }

                // 建立数据库连接
                try (Connection conn = DriverManager.getConnection(url, dbUser, dbPass)) {
                    String sql = "";
                    // 根据操作类型确定 SQL 语句
                    if ("ban".equalsIgnoreCase(action)) {
                        sql = "UPDATE users SET status = 'BANNED' WHERE username = ?";
                    } else if ("unban".equalsIgnoreCase(action)) {
                        sql = "UPDATE users SET status = 'ACTIVE' WHERE username = ?";
                    } else {
                        resultMessage = "无效的操作!";
                        response.setContentType("text/plain");
                        response.getWriter().print(resultMessage);
                        return;
                    }

                    // 使用 PreparedStatement 执行 SQL 更新
                    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                        pstmt.setString(1, username);
                        int rowsUpdated = pstmt.executeUpdate();

                        // 根据更新的行数判断操作结果
                        if (rowsUpdated > 0) {
                            if ("ban".equalsIgnoreCase(action)) {
                                resultMessage = "用户 " + username + " 已成功封禁!";
                            } else {
                                resultMessage = "用户 " + username + " 已成功解封!";
                            }
                        } else {
                            resultMessage = "未找到用户名 " + username + "!";
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                resultMessage = "数据库操作失败，请稍后重试。具体错误: " + e.getMessage();
            } catch (Exception e) {
                e.printStackTrace();
                resultMessage = "操作失败，请稍后重试。具体错误: " + e.getMessage();
            }
        } else {
            resultMessage = "用户名或操作类型不能为空！";
        }

        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().write("<script type='text/javascript'>"
                + "alert('" + resultMessage + "');"
                + "window.location.href = 'adminboard.jsp';"
                + "</script>");
    }
}
