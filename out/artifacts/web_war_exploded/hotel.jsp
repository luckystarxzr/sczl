<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>酒店推荐</title>
    <link rel="stylesheet" href="resources/css/styles.css">
    <style>
        /* 酒店卡片样式 */
        .hotel-card {
            border: 1px solid #ccc;
            padding: 10px;
            width: 300px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            background-color: white;
            transition: transform 0.3s ease;
        }

        .hotel-card:hover {
            transform: translateY(-10px);
        }

        .hotel-card img {
            width: 100%;
            height: auto;
            border-bottom: 1px solid #eee;
            margin-bottom: 10px;
        }

        .hotel-card h2 {
            font-size: 22px;
            margin-bottom: 10px;
            color: #333;
        }

        .hotel-card p {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .hotel-card a {
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        .hotel-card a:hover {
            color: #45a049;
        }

        /* 表单区域样式 */
        .container {
            margin-top: 40px;
            text-align: center;
        }

        h2 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #333;
        }

        form {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 0 auto;
        }

        form label {
            font-size: 18px;
            margin-bottom: 10px;
            display: block;
        }

        form select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
            margin-bottom: 20px;
        }

        form button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        form button:hover {
            background-color: #45a049;
        }

        /* 返回链接样式 */
        a {
            display: inline-block;
            margin-top: 20px;
            color: #4CAF50;
            font-weight: bold;
            text-decoration: none;
            font-size: 18px;
        }

        a:hover {
            color: #45a049;
        }
    </style>
</head>
<body>
<!-- 背景音乐 -->
<audio id="background-music" autoplay loop>
    <source src="resources/silkroad.mp3" type="audio/mpeg">
</audio>

<header>
    <nav style="display: flex; align-items: center;">
        <img src="resources/images/logo.png" alt="Logo" style="width: 50px; height: 50px; margin-right: 10px;">
        <h1>敦煌壁画</h1>
        <ul>
            <li><a href="login.jsp">登录</a></li>
            <li><a href="register.jsp">注册</a></li>
            <li><a href="index.jsp">首页</a></li>
            <li><a href="hotel.jsp">酒店</a></li>
            <li><a href="attraction.jsp">景点</a></li>
            <li><a href="journey.jsp">路线</a></li>
            <li><a href="history.jsp">历史</a></li>
            <li><a href="about.jsp">关于</a></li>
        </ul>
    </nav>
</header>

<div class="container">
    <h2>请选择您感兴趣的城市</h2>
    <form action="hotel" method="get">
        <label for="city">选择城市</label>
        <select id="city" name="city" required>
            <!-- 中国城市 -->
            <optgroup label="中国">
                <option value="陕西省西安市">陕西省西安市</option>
                <option value="甘肃省张掖市">甘肃省张掖市</option>
                <option value="甘肃省敦煌市">甘肃省敦煌市</option>
                <option value="新疆吐鲁番市">新疆吐鲁番市</option>
                <option value="新疆喀什地区喀什市">新疆喀什地区喀什市</option>
            </optgroup>

            <!-- 中亚城市 -->
            <optgroup label="中亚">
                <option value="乌兹别克斯坦撒马尔罕">乌兹别克斯坦撒马尔罕</option>
                <option value="乌兹别克斯坦布哈拉">乌兹别克斯坦布哈拉</option>
                <option value="阿富汗喀布尔">阿富汗喀布尔</option>
            </optgroup>

            <!-- 中东城市 -->
            <optgroup label="中东">
                <option value="伊拉克巴格达">伊拉克巴格达</option>
            </optgroup>

            <!-- 欧洲城市 -->
            <optgroup label="欧洲">
                <option value="土耳其伊斯坦布尔">土耳其伊斯坦布尔</option>
                <option value="君士坦丁堡">君士坦丁堡</option>
                <option value="意大利罗马">意大利罗马</option>
            </optgroup>
        </select>
        <button type="submit">获取推荐酒店</button>
    </form>
</div>

<h1>推荐酒店列表</h1>
<div style="display: flex; flex-wrap: wrap; gap: 20px;">
    <c:choose>
        <c:when test="${not empty hotels}">
            <c:forEach var="hotel" items="${hotels}">
                <div class="hotel-card">
                    <c:if test="${not empty hotel.imageUrl}">
                        <img src="${hotel.imageUrl}" alt="${hotel.name}">
                    </c:if>
                    <h2>${hotel.name}</h2>
                    <p>${hotel.description}</p>
                    <p><strong>位置：</strong>${hotel.location}</p>
                    <p><strong>每晚价格：</strong>${hotel.pricePerNight}元</p>
                    <c:if test="${not empty hotel.contactPhone}">
                        <p><strong>联系电话：</strong>${hotel.contactPhone}</p>
                    </c:if>
                    <c:if test="${not empty hotel.email}">
                        <p><strong>电子邮件：</strong><a href="mailto:${hotel.email}">${hotel.email}</a></p>
                    </c:if>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>未找到符合条件的酒店。</p>
        </c:otherwise>
    </c:choose>
</div>

<a href="hotel.jsp">返回</a>
</body>
</html>
