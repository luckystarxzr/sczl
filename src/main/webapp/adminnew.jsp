<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>资讯管理页面</title>
    <link rel="stylesheet" href="resources/css/news.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="resources/js/new.js"></script>
</head>
<body>
<!-- 背景遮罩层 -->
<div class="overlay"></div>

<!-- 添加资讯弹窗 -->
<div id="addNewsModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>添加资讯</h2>
        <form id="news-form" action="newupload" method="post" enctype="multipart/form-data">
            <label for="title">标题:</label>
            <input type="text" id="title" name="title" required>

            <label for="author">作者:</label>
            <input type="text" id="author" name="author" required>

            <label for="content">内容:</label>
            <textarea id="content" name="content" rows="4" required></textarea>

            <label for="fileName">图片/视频:</label>
            <input type="file" id="fileName" name="fileName" required>

            <button type="submit">添加资讯</button>
            <button type="button" id="closeBtn">关闭</button>
        </form>
    </div>
</div>
<!-- 更新资讯弹窗 -->
<div id="updateNewsModal" class="modal">
    <div class="modal-content">
        <span class="close" id="closeUpdateModal">&times;</span>
        <h2>更新资讯</h2>
        <form id="updateNewsForm" action="updateNews" method="post" enctype="multipart/form-data">
            <label for="title">标题:</label>
            <input type="text" id="updateTitle" name="title" required>

            <label for="author">作者:</label>
            <input type="text" id="updateAuthor" name="author" required>

            <label for="content">内容:</label>
            <textarea id="updateContent" name="content" rows="4" required></textarea>

            <label for="fileName">图片/视频:</label>
            <input type="file" id="updateFileName" name="fileName">

            <input type="hidden" id="newsId" name="newsId">

            <button type="submit">更新资讯</button>
            <button type="button" id="closeUpdateBtn">关闭</button>
        </form>
    </div>
</div>


<!-- 遮罩层 -->
<div id="modalOverlay" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0, 0, 0, 0.5); z-index:999;"></div>

<!-- 资讯列表 -->
<div class="news-list">
    <h2>资讯列表
        <button class="add-news-btn"; style="float: right; background-color: #4CAF50; color: white; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px;">添加资讯</button>
    <a href="adminboard.jsp" style="margin-left: 20px; text-decoration: none;">
        <button style="float: right; background-color: #4CAF50; color: white; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px;">返回管理页面</button>
    </a>
    </h2>
    <%
        int pages = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        int pageSize = 10; // 每页显示10条
        int start = (pages - 1) * pageSize; // 计算分页的起始位置

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sczl", "root", "123456");

            // 查询总记录数
            stmt = conn.prepareStatement("SELECT COUNT(*) FROM news");
            rs = stmt.executeQuery();
            rs.next();
            int totalRecords = rs.getInt(1);
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize); // 总页数

            // 查询当前页的数据
            stmt = conn.prepareStatement("SELECT * FROM news ORDER BY id LIMIT ? OFFSET ?");
            stmt.setInt(1, pageSize);
            stmt.setInt(2, start);
            rs = stmt.executeQuery();
    %>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>标题</th>
            <th>作者</th>
            <th>内容</th>
            <th>URL</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            while (rs.next()) {
                int newsId = rs.getInt("id");
                String title = rs.getString("title");
                String author = rs.getString("author");
                String content = rs.getString("content");
                String file_path = rs.getString("file_path");
        %>
        <tr>
            <td><%= newsId %></td>
            <td><%= title %></td>
            <td><%= author %></td>
            <td><%= content.length() > 50 ? content.substring(0, 50) + "..." : content %></td>
            <td><%= file_path %></td>
            <td>
                <button class="delete-btn" data-id="<%= newsId %>">删除</button>
<%--                <!-- 更新按钮 -->--%>
<%--                <button id="updateButton" onclick="openUpdateModal(1)">更新</button>--%>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <div class="pagination">
        <% if (pages > 1) { %>
        <a href="adminnew.jsp?page=<%= pages - 1 %>">上一页</a>
        <% } %>
        <% for (int i = 1; i <= totalPages; i++) { %>
        <a href="adminnew.jsp?page=<%= i %>" class="<%= (i == pages) ? "active" : "" %>"><%= i %></a>
        <% } %>
        <% if (pages < totalPages) { %>
        <a href="adminnew.jsp?page=<%= pages + 1 %>">下一页</a>
        <% } %>
    </div>


    <%
        } catch (SQLException | ClassNotFoundException e) {
            out.println("<p style='color: red;'>加载资讯列表时出错: " + e.getMessage() + "</p>");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    %>
</div>
<script>
    $(document).ready(function () {
        const modal = $('#updateNewsModal');
        const overlay = $('.overlay');

        // 显示弹窗
        $('.up-news-btn').on('click', function () {
            modal.fadeIn();
            overlay.fadeIn();
        });

        // 关闭弹窗
        $('.close, .overlay').on('click', function () {
            modal.fadeOut();
            overlay.fadeOut();
        });
    });
    $(document).ready(function () {
        const modal = $('#addNewsModal');
        const overlay = $('.overlay');

        // 显示弹窗
        $('.add-news-btn').on('click', function () {
            modal.fadeIn();
            overlay.fadeIn();
        });

        // 关闭弹窗
        $('.close, .overlay').on('click', function () {
            modal.fadeOut();
            overlay.fadeOut();
        });
    });
</script>
</body>
</html>
