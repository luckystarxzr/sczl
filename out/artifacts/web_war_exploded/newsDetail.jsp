<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>资讯详情</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            background-image: url('resources/images/background.jpg');
            background-size: cover;
            color: #333;
            background-position: center;
            background-attachment: fixed;
        }

        h1 {
            color: #333;
            border-bottom: 2px solid #007BFF;
            padding-bottom: 10px;
            text-align: center;
        }

        .content-box {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        p {
            line-height: 1.6;
            color: #555;
            text-align: center;
        }

        img {
            display: block;
            margin: 20px auto;
            width: 60%;  /* 强制图片宽度适应容器 */
            height: auto; /* 保持图片的纵横比 */
            max-width: 60%; /* 限制图片的最大宽度为容器的宽度 */
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        video {
            display: block;
            margin: 20px auto;
            max-width: 100%;
            border-radius: 8px;
        }

        .pagination {
            margin-top: 20px;
            text-align: center;
        }

        .pagination a {
            margin: 0 5px;
            padding: 10px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .pagination a:hover {
            background-color: #0056b3;
        }

        /* 返回首页按钮样式 */
        .back-button {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .back-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<!-- 返回首页按钮 -->
<button class="back-button" onclick="window.location.href='<%= request.getContextPath() + "/index.jsp" %>'">返回首页</button>

<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/sczl";
    String dbUser = "root";
    String dbPassword = "123456";
    String idParam = request.getParameter("id");
    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        if (idParam != null) {
            connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            String sql = "SELECT * FROM news WHERE id = ?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(idParam));
            rs = ps.executeQuery();

            if (rs.next()) {
                String title = rs.getString("title");
                String content = rs.getString("content");
                String file_path = rs.getString("file_path");
                int currentId = rs.getInt("id");

                // 查询上一条新闻
                String prevSql = "SELECT id FROM news WHERE id < ? ORDER BY id DESC LIMIT 1";
                ps = connection.prepareStatement(prevSql);
                ps.setInt(1, currentId);
                ResultSet prevRs = ps.executeQuery();
                int prevId = prevRs.next() ? prevRs.getInt("id") : -1;

                // 查询下一条新闻
                String nextSql = "SELECT id FROM news WHERE id > ? ORDER BY id ASC LIMIT 1";
                ps = connection.prepareStatement(nextSql);
                ps.setInt(1, currentId);
                ResultSet nextRs = ps.executeQuery();
                int nextId = nextRs.next() ? nextRs.getInt("id") : -1;
%>

<div class="content-box">
    <h1><%= title %></h1>
    <p><%= content %></p>

    <%
        // 根据文件扩展名判断是显示图片还是视频
        if (file_path.endsWith(".jpg") || file_path.endsWith(".png") || file_path.endsWith(".gif")) {
    %>
    <img src="<%= request.getContextPath() + "/resources/news/" + file_path %>" alt="Image"/>
    <%
    } else if (file_path.endsWith(".mp4")) {
    %>
    <video controls><source src="<%= request.getContextPath() + "/resources/news/" + file_path %>" type="video/mp4">您的浏览器不支持视频播放。</video>
    <%
    } else {
    %>
    <p>不支持的文件格式</p>
    <%
        }
    %>

    <div class="pagination">
        <%
            if (prevId != -1) {
        %>
        <a href="<%= request.getContextPath() + "/newsDetail.jsp?id=" + prevId %>">上一条</a>
        <%
            }
            if (nextId != -1) {
        %>
        <a href="<%= request.getContextPath() + "/newsDetail.jsp?id=" + nextId %>">下一条</a>
        <%
            }
        %>
    </div>

</div>

<%
            } else {
                out.println("<p>未找到该新闻。</p>");
            }
        } else {
            out.println("<p>未指定新闻ID。</p>");
            return;
        }

    } catch (SQLException e) {
        out.println("<p>数据库错误: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

</body>
</html>
