<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册页面</title>
    <link rel="stylesheet" href="resources/css/style.css">
    <script>
        // 用于验证密码和确认密码是否一致
        function validatePasswords() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;

            // 检查密码和确认密码是否一致
            if (password !== confirmPassword) {
                alert("密码和确认密码不一致，请重新输入！");
                return false;  // 阻止表单提交
            }

            return true;  // 密码一致，允许提交
        }
    </script>
</head>
<body>
<form action="register" method="post" onsubmit="return validatePasswords()">
    <h2>用户注册</h2>

    <label>用户名:</label>
    <input type="text" name="username" required><br>

    <label>密码:</label>
    <input type="password" id="password" name="password" required><br>

    <label>确认密码:</label>
    <input type="password" id="confirmPassword" name="confirmPassword" required><br>

    <input type="submit" value="注册">

    <p>已有账号？</p>
    <a href="login.jsp">直接登录</a>

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
