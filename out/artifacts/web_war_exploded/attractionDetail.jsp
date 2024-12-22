<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.ArrayList, java.util.List" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="Model.Comment" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>景点详情</title>
    <style>
        /* 通用样式 */
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

        p {
            line-height: 1.6;
            color: #555;
        }

        img {
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin: 15px 0;
            max-width: 600px; /* 增大图片的最大宽度 */
            height: auto; /* 保持图片的比例 */
            float: left;
            margin-right: 40px;
        }

        .details-card {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            max-width: 600px;
            margin: 0 auto;
        }

        .details-card p {
            font-size: 16px;
            margin-bottom: 10px;
        }

        #commentsSection, form {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }

        textarea {
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 10px;
            resize: vertical;
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 10px 15px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        a {
            color: #007BFF;
            text-decoration: none;
            margin-right: 15px;
        }

        a:hover {
            text-decoration: underline;
        }

        .pagination {
            margin-top: 20px;
        }

        .pagination a {
            margin: 0 5px;
        }

        .pagination strong {
            color: #333;
        }

        /* 举报框样式 */
        #reportForm {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
        }

        .like-btn {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
        }

        .like-btn.liked {
            background-color: #d9534f;
        }
    </style>
</head>
<body>

<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/sczl";
    String dbUser = "root";
    String dbPassword = "123456";
    String idParam = request.getParameter("id");

    HttpSession userSession = request.getSession();
    String username = (String) userSession.getAttribute("username");

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    int pageSize = 5; // 每页显示的评论数量
    int currentPage = 1; // 当前页数
    String pageParam = request.getParameter("page");
    if (pageParam != null) {
        currentPage = Integer.parseInt(pageParam);
    }

    int totalComments = 0;
    List<Comment> commentList = new ArrayList<>();
    int totalPages = 0;
    int likes = 0;
    boolean isLiked = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        // 查询景点详情
        if (idParam != null) {
            connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            String sql = "SELECT * FROM attractions WHERE id = ?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(idParam));
            rs = ps.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String description = rs.getString("description");
                String location = rs.getString("location");
                String image_url = rs.getString("image_url");
                likes = rs.getInt("likes");
                double ticket_price = rs.getDouble("ticket_price");

                out.println("<h1>" + name + "</h1>");
                if (image_url != null && !image_url.isEmpty()) {
                    out.println("<img src=\"" + request.getContextPath() + "/resources/attractions/" + image_url + "\" alt=\"Image\"/>");
                }
                out.println("<div class='details-card'>");
                out.println("<p><strong>描述：</strong>" + description + "</p>");
                out.println("<p><strong>位置：</strong>" + location + "</p>");
                out.println("<p><strong>点赞数：</strong> <span id='likeCount'>" + likes + "</span> " +
                        "<button class='like-btn' id='likeBtn'>" + (isLiked ? "取消点赞" : "点赞") + "</button>" + "</p>");
                out.println("<p><strong>门票价格：</strong>" + String.format("%.2f", ticket_price) + " 元 " +
                        "<button onclick=\"window.location.href='https://www.fliggy.com/piao/'\">购买门票</button>" +
                        "</p>");
                out.println("</div>");
            } else {
                out.println("<p>未找到该景点。</p>");
            }
        }

        // 获取评论总数
        String countSql = "SELECT COUNT(*) FROM comments WHERE attraction_id = ?";
        try (PreparedStatement countStmt = connection.prepareStatement(countSql)) {
            countStmt.setInt(1, Integer.parseInt(idParam));
            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalComments = countRs.getInt(1);
            }
        }

        // 获取当前页的评论
        String commentSql = "SELECT * FROM comments WHERE attraction_id = ? ORDER BY comment_time DESC LIMIT ?, ?";
        try (PreparedStatement commentStmt = connection.prepareStatement(commentSql)) {
            commentStmt.setInt(1, Integer.parseInt(idParam));
            commentStmt.setInt(2, (currentPage - 1) * pageSize);
            commentStmt.setInt(3, pageSize);
            ResultSet commentRs = commentStmt.executeQuery();
            while (commentRs.next()) {
                Comment comment = new Comment();
                comment.setId(commentRs.getInt("id"));
                comment.setUsername(commentRs.getString("username"));
                comment.setComment(commentRs.getString("comment"));
                comment.setCommentTime(commentRs.getTimestamp("comment_time"));
                commentList.add(comment);
            }
        }

        // 计算总页数
        totalPages = (int) Math.ceil((double) totalComments / pageSize);

    } catch (SQLException | ClassNotFoundException e) {
        out.println("<p>数据库错误: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

%>

<!-- 评论区 -->
<h2>评论区</h2>
<div id="commentsSection">
    <%
        for (Comment comment : commentList) {
            out.println("<div class='comment'>");
            out.println("<p><strong>" + comment.getUsername() + "</strong> (时间: " + comment.getCommentTime() + "):</p>");
            out.println("<p>" + comment.getComment());
            // 检查用户是否已登录
            if (username != null) {
                out.println("<a href='#' onclick='showReportForm(" + comment.getId() + ", " + idParam + ")'>举报</a>");
            }
            out.println("</p>");
            out.println("</div>");
        }
    %>
</div>

<!-- 添加评论 -->
<h2>添加评论</h2>
<% if (username != null) { %>
<form action="comment" method="post">
    <!-- 使用隐藏字段传递景点ID -->
    <input type="hidden" name="id" value="<%= idParam %>" />

    <p>评论：</p>
    <textarea name="comment" rows="5"></textarea><br>
    <input type="submit" value="提交评论" />
</form>
<% } else { %>
<p>请先 <a href="login.jsp">登录</a> 后发表评论。</p>
<% } %>

<!-- 分页 -->
<div class="pagination">
    <% for (int i = 1; i <= totalPages; i++) { %>
    <a href="?id=<%= idParam %>&page=<%= i %>"><%= i %></a>
    <% } %>
</div>

<!-- 举报框 -->
<div id="reportForm">
    <h3>举报评论</h3>
    <form action="report" method="post">
        <input type="hidden" name="commentId" id="commentId">
        <input type="hidden" name="attractionId" value="<%= idParam %>">
        <p>请选择举报理由：</p>
        <select name="reason">
            <option value="不良语言">不良语言</option>
            <option value="不当内容">不当内容</option>
            <option value="其他">其他</option>
        </select><br><br>
        <input type="submit" value="提交举报">
        <button type="button" onclick="hideReportForm()">取消</button>
    </form>
</div>
<script>
    function showReportForm(commentId, attractionId) {
        document.getElementById('reportForm').style.display = 'block';
        document.getElementById('commentId').value = commentId;
    }

    function hideReportForm() {
        document.getElementById('reportForm').style.display = 'none';
    }

    document.addEventListener('DOMContentLoaded', function() {
        const likeBtn = document.getElementById('likeBtn');
        const likeCount = document.getElementById('likeCount');
        let isLiked = <%= isLiked ? "true" : "false" %>;

        likeBtn.addEventListener('click', function() {
            // 发送AJAX请求
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'like', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);
                    if (response.success) {
                        if (isLiked) {
                            likeBtn.textContent = '点赞';
                            likeCount.textContent = parseInt(likeCount.textContent) - 1;
                        } else {
                            likeBtn.textContent = '取消点赞';
                            likeCount.textContent = parseInt(likeCount.textContent) + 1;
                        }
                        isLiked = !isLiked;
                    }
                }
            };
            xhr.send('id=<%= idParam %>&isLiked=' + isLiked);
        });
    });
</script>

</body>
</html>
