<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="Model.Report" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // 数据库连接相关信息
    String jdbcUrl = "jdbc:mysql://localhost:3306/sczl";
    String dbUser = "root";
    String dbPassword = "123456";

    List<Report> reportList = new ArrayList<>();
    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // 处理删除评论请求
    String deleteCommentId = request.getParameter("deleteCommentId");
    if (deleteCommentId != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // 删除评论
            String deleteQuery = "DELETE FROM comments WHERE id = ?";
            ps = connection.prepareStatement(deleteQuery);
            ps.setInt(1, Integer.parseInt(deleteCommentId));
            ps.executeUpdate();

            // 删除成功后跳转，避免重复提交
            response.sendRedirect("adminreport.jsp");
        } catch (Exception e) {
            out.println("<p style='color: red;'>删除评论时出现错误: " + e.getMessage() + "</p>");
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignored) {}
        }
    }

    // 处理封号请求
    String banUsername = request.getParameter("banUsername");
    if (banUsername != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // 封号操作
            String banQuery = "UPDATE users SET status = 'BANNED' WHERE username = ?";
            ps = connection.prepareStatement(banQuery);
            ps.setString(1, banUsername);
            ps.executeUpdate();

            response.sendRedirect("adminreport.jsp"); // 避免重复提交
        } catch (Exception e) {
            out.println("<p style='color: red;'>封号时出现错误: " + e.getMessage() + "</p>");
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignored) {}
        }
    }

    // 查询举报记录
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // 根据 reports 表的结构调整字段
        String query = "SELECT id AS report_id, attraction_id, comment_id, username, reason, report_time, status " +
                "FROM reports ORDER BY report_time DESC";
        ps = connection.prepareStatement(query);
        rs = ps.executeQuery();

        // 填充举报记录列表
        while (rs.next()) {
            int reportId = rs.getInt("report_id");
            int attractionId = rs.getInt("attraction_id");
            int commentId = rs.getInt("comment_id");
            String username = rs.getString("username");
            String reason = rs.getString("reason");
            Timestamp reportTime = rs.getTimestamp("report_time");
            String status = rs.getString("status");
            reportList.add(new Report(reportId, attractionId, commentId, username, reason, reportTime, status));
        }
    } catch (SQLException e) {
        out.println("<p>加载举报信息时出现错误: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignored) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>举报管理</title>
    <link rel="stylesheet" href="resources/css/report.css">
</head>
<body>
<h1>
    举报列表
    <a href="adminboard.jsp" style="margin-left: 20px; text-decoration: none;">
        <button style="float: right; background-color: #4CAF50; color: white; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px;">返回管理页面</button>
    </a>
</h1>

<table>
    <thead>
    <tr>
        <th>举报ID</th>
        <th>景点ID</th>
        <th>评论ID</th>
        <th>举报用户名</th>
        <th>举报原因</th>
        <th>举报时间</th>
        <th>状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (reportList.isEmpty()) {
            out.println("<tr><td colspan='8'>暂无举报记录。</td></tr>");
        } else {
            for (Report report : reportList) {
                out.println("<tr>");
                out.println("<td>" + report.getReportId() + "</td>");
                out.println("<td>" + report.getAttractionId() + "</td>");
                out.println("<td>" + report.getCommentId() + "</td>");
                out.println("<td>" + report.getUsername() + "</td>");
                out.println("<td>" + report.getReason() + "</td>");
                out.println("<td>" + report.getReportTime() + "</td>");
                out.println("<td>" + report.getStatus() + "</td>");

                // 删除评论按钮
                out.println("<td>");
                out.println("<form action='adminreport.jsp' method='get'>");
                out.println("<input type='hidden' name='deleteCommentId' value='" + report.getCommentId() + "'>");
                out.println("<button type='submit' onclick=\"return confirm('确认删除评论吗?');\">删除评论</button>");
                out.println("</form>");

                // 封号按钮
                out.println("<form action='adminreport.jsp' method='get'>");
                out.println("<input type='hidden' name='banUsername' value='" + report.getUsername() + "'>");
                out.println("<button type='submit' onclick=\"return confirm('确认封号该用户吗?');\">封号</button>");
                out.println("</form>");
                out.println("</td>");

                out.println("</tr>");
            }
        }
    %>
    </tbody>
</table>
</body>
</html>