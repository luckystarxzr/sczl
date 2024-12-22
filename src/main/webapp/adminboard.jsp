<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/sczl?useSSL=false&serverTimezone=UTC";
    String dbUser = "root";
    String dbPass = "123456";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(url, dbUser, dbPass)) {
            String sql = "SELECT username,password,role, status FROM users";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理系统</title>
    <link rel="stylesheet" href="resources/css/admin.css">
    <script>
        // 控制弹窗的显示与隐藏
        function togglePopup(popupId) {
            var popup = document.getElementById(popupId);
            var overlay = document.getElementById('popupOverlay');
            if (popup.style.display === 'block') {
                popup.style.display = 'none';
                overlay.style.display = 'none';
            } else {
                popup.style.display = 'block';
                overlay.style.display = 'block';
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h2>欢迎,管理员 <%= session.getAttribute("username") %></h2>
    <h1>用户管理</h1>
    <!-- 添加新用户弹窗 -->
    <div id="addUser" class="popup">
        <h3>添加用户</h3>
        <form action="addUser" method="post">
            <label for="newUser">用户名:</label>
            <input type="text" id="newUser" name="newUser" required><br><br>
            <label for="newRole">角色:</label>
            <select id="newRole" name="newRole" required>
                <option value="user">普通用户</option>
                <option value="admin">管理员</option>
            </select><br><br>
            <label for="newPassword">密码:</label>
            <input type="password" id="newPassword" name="newPassword" required><br><br>
            <input type="submit" value="提交">
            <button type="button" onclick="togglePopup('addUser')">关闭</button>
        </form>
    </div>
    <!-- 封禁确认弹窗 -->
    <div id="ban" class="popup">
        <form action="BanUnban" method="post">
            <label>用户名:</label>
            <input type="text"  name="username" required>
            <p>你确定要封禁此用户吗？</p>
            <button type="submit" name="action" value="ban">封禁</button>
            <button type="button" onclick="togglePopup('ban')">取消</button>
        </form>
    </div>
    <!-- 激活确认弹窗 -->
    <div id="activate" class="popup">
        <h3>确认激活用户</h3>
        <form action="BanUnban" method="post">
            <label>用户名:</label>
            <input type="text" name="username" required>
            <p>你确定要激活此用户吗？</p>
            <button type="submit" name="action" value="unban">解封</button>
            <button type="button" onclick="togglePopup('activate')">取消</button>
        </form>
    </div>
    <!-- 更新密码弹窗 -->
    <div id="updatePassword" class="popup">
        <h3>更新密码</h3>
        <form action="updatePassword" method="post" onsubmit="return validateForm()">
            <label for="username">用户名:</label>
            <input type="text" id="username" name="username" required><br><br>
            <label for="newpass">新密码:</label>
            <input type="password" id="newpass" name="newpass" required><br><br>
            <label for="confirmPassword">确认密码:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required><br><br>
            <input type="submit" value="更新密码">
            <button type="button" onclick="togglePopup('updatePassword')">关闭</button>
        </form>
    </div>

    <!-- 用户列表 -->
    <table>
        <tr>
            <th>用户名</th>
            <th>密码</th>
            <th>角色</th>
            <th>状态</th>
        </tr>
        <%
            while (rs.next()) {
                String role = rs.getString("role");
                String status = rs.getString("status");
        %>
        <tr>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("password") %></td>
            <td class="<%= role.equals("USER") ? "role-user" : "role-admin" %>">
                <%= role %>
            </td>
            <td class="<%= status.equals("ACTIVE") ? "status-active" : "status-banned" %>">
                <%= status %>
            </td>
        </tr>
        <%
            }
        %>
    </table>

    <div class="button-container">
        <button onclick="togglePopup('ban')">封禁</button>
        <button onclick="togglePopup('activate')">激活</button>
        <button onclick="togglePopup('addUser')">添加新用户</button>
        <button onclick="togglePopup('updatePassword')">更新密码</button>

        <a href="login.jsp" class="button-link">退出</a>
        <a href="index.jsp" class="button-link">进入首页</a>
        <a href="adminnew.jsp" class="button-link">进入资讯管理</a>
        <a href="hotelManagement" class="button-link">进入酒店管理</a>
        <a href="adminreport.jsp" class="button-link">进入举报管理</a>
    </div>

</div>
<!-- 弹窗遮罩 -->
<div id="popupOverlay" class="popup-overlay"></div>
</body>
</html>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
