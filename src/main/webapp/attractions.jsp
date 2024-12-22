<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <style>
        /* 页面整体布局 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        h2 {
            text-align: center;
            color: #333;
            font-size: 36px;
        }
        /* 搜索框样式 */
        .search-container {
            padding: 20px;
            text-align: center;
        }

        .search-container input[type="text"] {
            padding: 10px;
            width: 300px;
            font-size: 16px;
            border: 2px solid #ddd;
            border-radius: 5px;
        }

        .search-container input[type="submit"] {
            padding: 10px 20px;
            background-color: #fff;
            border: 2px solid #ddd;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .search-container input[type="submit"]:hover {
            background-color: #ddd;
        }

        /* 景点展示容器 */
        .attractions-container {
            display: grid;
            grid-template-columns: repeat(5, 1fr); /* 每行5个景点 */
            gap: 20px; /* 景点项之间的间距 */
            padding: 20px;
            color: white;
        }

        .attractions-item {
            border: 1px solid #ccc;
            padding: 10px;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center; /* 内容居中 */
            width: 100%; /* 确保占满格子宽度 */
            max-width: 300px; /* 设置固定最大宽度 */
            height: 300px; /* 固定高度 */
            overflow: hidden; /* 避免内容溢出 */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            color: white;
        }

        .attractions-item img, .attractions-item video {
            width: 100%; /* 让图片或视频占满宽度 */
            height: 200px; /* 固定图片或视频的高度 */
            object-fit: cover; /* 确保图片/视频裁剪且填满容器 */
            margin-bottom: 5px; /* 图片和文字之间的间距 */
        }

        .attractions-item h3 {
            font-size: 16px;
            font-weight: bold;
            margin: 0 0 10px;
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden; /* 防止标题溢出 */
        }

        .attractions-item p {
            font-size: 12px;
            color: darkred;
            margin: 0;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap; /* 防止长文本溢出 */
        }

        /* 分页导航样式 */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            color: white;
        }

        .pagination a {
            color: #333;
            padding: 8px 16px;
            text-decoration: none;
            border: 1px solid #ddd;
            margin: 0 4px;
        }

        .pagination a.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
    </style>
</head>
<body>
<!-- 搜索框放置位置 -->
<div class="search-container">
    <form method="get" action="">
        <input type="text" name="keyword" placeholder="搜索景点" value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
        <input type="submit" value="搜索">
    </form>
</div>

<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/sczl";
    String dbUser = "root";
    String dbPassword = "123456";
    String keyword = request.getParameter("keyword");

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        int currentPage = 1;
        try {
            currentPage = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException ignored) {}

        int pageSize = 5; // 每页显示5个景点
        int startRow = (currentPage - 1) * pageSize; // 计算起始行

        // 修改SQL查询，按点赞倒序排序
        String sql = "SELECT * FROM attractions WHERE name LIKE ? ORDER BY likes DESC LIMIT ? OFFSET ?";
        ps = connection.prepareStatement(sql);
        ps.setString(1, "%" + (keyword != null ? keyword : "") + "%"); // 添加搜索条件
        ps.setInt(2, pageSize);
        ps.setInt(3, startRow);
        rs = ps.executeQuery();

        out.println("<h2>景点列表</h2>");
        out.println("<div class='attractions-container'>");
        while (rs.next()) {
            String attractionsId = rs.getString("id");
            String attractionsName = rs.getString("name");
            String attractionsLocation = rs.getString("location");
            String likes = rs.getString("likes");
            String image_url = rs.getString("image_url");
            out.println("<div class='attractions-item'>"); // 容器
            out.println("<h3><a href=\"attractionsDetail.jsp?id=" + attractionsId + "\">" + attractionsName + "</a></h3>");
            out.println("<p>位置: " + attractionsLocation + "</p>");
            out.println("<p>点赞数: " + likes + "</p>");
            if (image_url.endsWith(".jpg") || image_url.endsWith(".png")) {
                out.println("<img src=\"" + request.getContextPath() + "/resources/attractions/" + image_url + "\" alt=\"Image\"/>");
            } else {
                out.println("<p>不支持的文件格式</p>"); // 显示不支持的文件格式信息
            }
            out.println("</div>"); // 结束
        }
        out.println("</div>");

        // 分页导航
        int totalRows = 0;
        sql = "SELECT COUNT(*) FROM attractions WHERE name LIKE ?";
        ps = connection.prepareStatement(sql);
        ps.setString(1, "%" + (keyword != null ? keyword : "") + "%"); // 搜索条件
        rs = ps.executeQuery();
        if (rs.next()) {
            totalRows = rs.getInt(1);
        }
        int totalPages = (int) Math.ceil((double) totalRows / pageSize);

        out.println("<div class='pagination'>");
        for (int i = 1; i <= totalPages; i++) {
            if (i == currentPage) {
                // 如果keyword不为空，则在链接中加入keyword参数
                if (keyword != null && !keyword.isEmpty()) {
                    out.println("<a href='index.jsp?page=" + i + "&keyword=" + keyword + "' class='active'>" + i + "</a>");
                } else {
                    out.println("<a href='index.jsp?page=" + i + "' class='active'>" + i + "</a>");
                }
            } else {
                // 如果keyword不为空，则在链接中加入keyword参数
                if (keyword != null && !keyword.isEmpty()) {
                    out.println("<a href='index.jsp?page=" + i + "&keyword=" + keyword + "'>" + i + "</a>");
                } else {
                    out.println("<a href='index.jsp?page=" + i + "'>" + i + "</a>");
                }
            }
        }
        out.println("</div>");
    } catch (SQLException e) {
        out.println("<p>数据库访问错误: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignored) {}
    }
%>
</body>
</html>
