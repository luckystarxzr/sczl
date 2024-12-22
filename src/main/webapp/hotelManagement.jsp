<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>酒店管理</title>
  <link rel="stylesheet" href="resources/css/styles.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 0;
    }
    h2 {
      text-align: center;
      color: #333;
      margin-top: 20px;
    }
    table {
      width: 80%;
      margin: 20px auto;
      border-collapse: collapse;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    th, td {
      padding: 10px;
      text-align: center;
      border-bottom: 1px solid #ddd;
    }
    th {
      background-color: #007BFF;
      color: white;
    }
    tr:hover {
      background-color: #f1f1f1;
    }
    button {
      display: block;
      margin: 0 auto;
      background-color: #007BFF;
      color: white;
      border: none;
      padding: 10px 20px;
      cursor: pointer;
      border-radius: 5px;
      font-size: 16px;
      transition: background-color 0.3s ease;
    }
    button:hover {
      background-color: #0056b3;
    }
    #addHotelModal, #updateHotelModal {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      display: none;
      justify-content: center;
      align-items: center;
      z-index: 9999;
    }
    .modal-content {
      background-color: white;
      padding: 20px;
      width: 400px;
      max-width: 90%;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      text-align: left;
    }
    .modal-content button {
      background-color: #dc3545;
    }
    .modal-content button:hover {
      background-color: #c82333;
    }
    .modal-content input {
      width: 100%;
      padding: 8px;
      margin: 8px 0;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    .pagination-container {
      display: flex;
      justify-content: center;
      align-items: center;
      margin: 20px 0;
      gap: 10px;
    }
    .pagination-container button {
      background-color: #007BFF;
      color: white;
      border: none;
      padding: 10px 15px;
      cursor: pointer;
      border-radius: 5px;
      font-size: 14px;
      transition: background-color 0.3s ease;
    }
    .pagination-container button:hover {
      background-color: #0056b3;
    }
    .pagination-container span {
      font-size: 14px;
      color: #333;
    }
  </style>
</head>
<body>
<%--<%--%>
<%--  // 从 Session 获取用户角色--%>
<%--  String userRole = (String) session.getAttribute("userRole");--%>

<%--  // 检查用户角色是否为管理员--%>
<%--  if (userRole == null || !userRole.equals("admin")) {--%>
<%--    // 如果不是管理员，重定向到无权限页面--%>
<%--    response.sendRedirect("login.jsp");--%>
<%--    return; // 终止后续页面渲染--%>
<%--  }--%>
<%--%>--%>
<button class="back-button" onclick="window.location.href='<%= request.getContextPath() + "/adminboard.jsp" %>'">返回</button>
<h2>酒店管理</h2>
<!-- 返回首页按钮 -->
<button onclick="openAddHotelForm()">添加酒店</button>

<!-- 添加酒店弹窗 -->
<div id="addHotelModal">
  <div class="modal-content">
    <h3>添加酒店</h3>
    <form id="addHotelForm" method="POST" action="hotelManagement">
      <input type="hidden" name="action" value="add">
      <label for="addName">酒店名称</label>
      <input type="text" name="name" id="addName" required>
      <label for="addLocation">位置</label>
      <input type="text" name="location" id="addLocation" required>
      <label for="addDescription">描述</label>
      <input type="text" name="description" id="addDescription" required>
      <label for="addPricePerNight">价格</label>
      <input type="number" name="price_per_night" id="addPricePerNight" required>
      <label for="addContactPhone">联系电话</label>
      <input type="text" name="contact_phone" id="addContactPhone">
      <label for="addEmail">电子邮件</label>
      <input type="email" name="email" id="addEmail">
      <label for="addImageUrl">图片URL</label>
      <input type="text" name="image_url" id="addImageUrl">
      <button type="submit">保存</button>
      <button type="button" onclick="closeAddHotelForm()">关闭</button>
    </form>
  </div>
</div>

<table>
  <thead>
  <tr>
    <th>酒店名称</th>
    <th>位置</th>
    <th>描述</th>
    <th>价格</th>
    <th>电话</th>
    <th>邮箱</th>
    <th>操作</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="hotel" items="${hotels}">
    <tr id="hotel-${hotel.id}">
      <td>${hotel.name}</td>
      <td>${hotel.location}</td>
      <td>${hotel.description}</td>
      <td>${hotel.pricePerNight}</td>
      <td>${hotel.contactPhone}</td>
      <td>${hotel.email}</td>
      <td>
        <button class="updateButton" onclick="openUpdateForm(${hotel.id}, '${hotel.name}', '${hotel.location}', '${hotel.description}', ${hotel.pricePerNight}, '${hotel.contactPhone}', '${hotel.email}')">修改</button>
        <button class="deleteButton" onclick="deleteHotel(${hotel.id})">删除</button>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

<div class="pagination-container">
  <c:choose>
    <c:when test="${currentPage > 1}">
      <button onclick="location.href='hotelManagement?page=${currentPage - 1}'">上一页</button>
    </c:when>
    <c:otherwise>
      <span class="placeholder"></span>
    </c:otherwise>
  </c:choose>
  <span>第 ${currentPage} / ${totalPages} 页</span>
  <c:choose>
    <c:when test="${currentPage < totalPages}">
      <button onclick="location.href='hotelManagement?page=${currentPage + 1}'">下一页</button>
    </c:when>
    <c:otherwise>
      <span class="placeholder"></span>
    </c:otherwise>
  </c:choose>
</div>

<!-- 更新酒店弹窗 -->
<div id="updateHotelModal">
  <div class="modal-content">
    <h3>修改酒店</h3>
    <form id="updateHotelForm" method="POST" action="hotelManagement">
      <input type="hidden" name="action" value="update">
      <input type="hidden" name="hotel_id" id="updateHotelId">
      <label for="updateName">酒店名称</label>
      <input type="text" name="name" id="updateName" required>
      <label for="updateLocation">位置</label>
      <input type="text" name="location" id="updateLocation" required>
      <label for="updateDescription">描述</label>
      <input type="text" name="description" id="updateDescription" required>
      <label for="updatePricePerNight">价格</label>
      <input type="number" name="price_per_night" id="updatePricePerNight" required>
      <label for="updateContactPhone">联系电话</label>
      <input type="text" name="contact_phone" id="updateContactPhone">
      <label for="updateEmail">电子邮件</label>
      <input type="email" name="email" id="updateEmail">
      <label for="updateImageUrl">图片URL</label>
      <input type="text" name="image_url" id="updateImageUrl">
      <button type="submit">保存</button>
      <button type="button" onclick="closeUpdateForm()">关闭</button>
    </form>
  </div>
</div>

<script>
  function openAddHotelForm() {
    document.getElementById('addHotelModal').style.display = 'flex';
  }

  function closeAddHotelForm() {
    document.getElementById('addHotelModal').style.display = 'none';
  }

  function openUpdateForm(id, name, location, description, pricePerNight, phone, email) {
    document.getElementById('updateHotelId').value = id;
    document.getElementById('updateName').value = name;
    document.getElementById('updateLocation').value = location;
    document.getElementById('updateDescription').value = description;
    document.getElementById('updatePricePerNight').value = pricePerNight;
    document.getElementById('updateContactPhone').value = phone;
    document.getElementById('updateEmail').value = email;
    document.getElementById('updateImageUrl').value = '';
    document.getElementById('updateHotelModal').style.display = 'flex';
  }

  function closeUpdateForm() {
    document.getElementById('updateHotelModal').style.display = 'none';
  }

  function deleteHotel(id) {
    if (confirm('确定要删除该酒店吗？')) {
      location.href = 'deletehotel?action=delete&id=' + id;
    }
  }
</script>

</body>
</html>
