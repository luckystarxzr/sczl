<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录页面</title>
    <link rel="stylesheet" href="resources/css/style.css">
</head>
<body>
<form action="login" method="post">
    <h2>用户登录</h2>
    <label>用户名:</label>
    <input type="text" name="username" required><br>
    <label>密码:</label>
    <input type="password" name="password" required><br>
    <input type="submit" value="登录">
    <p>没有账号？</p>
    <a href="register.jsp">注册新用户</a>
    <%
        String message = (String) request.getAttribute("message");
        if (message != null && !message.trim().isEmpty()) {
    %>
    <p><%= message %></p>
    <%
        }
    %>
</form>
</body>
</html>

