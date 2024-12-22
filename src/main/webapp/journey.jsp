<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>丝绸之路路线</title>
    <script type="text/javascript" src="https://webapi.amap.com/maps?v=2.0&key=dd03f93c63d2400bbbd43018165e6905"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }

        header, footer {
            background: url('resources/images/bg2.png') no-repeat center center/cover;
            background-color: rgba(51, 51, 51, 0.9);
            padding: 10px 20px;
        }

        .map-container {
            position: relative;
            padding: 20px;
        }

        #map {
            width: 100%;
            height: 500px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .info-cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            padding: 20px;
            margin-top: 20px;
        }

        .card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 250px;
            margin: 10px;
            overflow: hidden;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        }

        .card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-bottom: 1px solid #ddd;
        }

        .card-content {
            padding: 15px;
        }

        .card-content h3 {
            font-size: 1.2rem;
            margin: 10px 0;
        }

        .card-content p {
            font-size: 1rem;
            color: #555;
        }

        footer {
            background-color: #2c3e50;
            color: white;
            text-align: center;
            padding: 10px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        nav {
            display: flex;
            align-items: center;
        }

        nav img {
            width: 50px;
            height: 50px;
            margin-right: 10px;
        }

        nav h1 {
            display: inline-block;
            color: white;
            font-size: 28px;
            margin-right: auto;
        }

        nav ul {
            list-style-type: none;
            display: inline-block;
            float: right;
            margin: 0;
            padding: 0;
        }

        nav ul li {
            display: inline;
            margin-left: 28px;
            font-size: 22px;
            line-height: 80px;
        }

        nav ul li a {
            color: red;
            text-decoration: none;
            font-family: 'KaiTi', serif;
        }
    </style>
</head>
<body>
    <header>
        <nav style="display: flex; align-items: center;">
            <img src="resources/images/logo.png" alt="Logo" style="width: 50px; height: 50px; margin-right: 10px;">
            <h1>丝绸之路路线</h1>
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
<div class="map-container">
    <div id="map"></div>
</div>

<div class="info-cards">
    <!-- 城市信息卡片 -->
    <div class="card">
        <img src="resources/citys/xian.jpg" alt="长安 (西安)">
        <div class="card-content">
            <h3>长安 (西安)</h3>
            <p>丝绸之路的起点，古代长安城是世界著名的文化和贸易中心。</p>
        </div>
    </div>
    <div class="card">
        <img src="resources/citys/zhangye.jpg" alt="张掖">
        <div class="card-content">
            <h3>张掖</h3>
            <p>位于河西走廊，古代丝绸之路的重要节点。</p>
        </div>
    </div>
    <div class="card">
        <img src="resources/citys/dunhuang.jpg" alt="敦煌">
        <div class="card-content">
            <h3>敦煌</h3>
            <p>丝绸之路的重要文化交汇点，拥有著名的莫高窟和古代文化遗产。</p>
        </div>
    </div>
    <div class="card">
        <img src="resources/citys/tulufan.jpg" alt="吐鲁番">
        <div class="card-content">
            <h3>吐鲁番</h3>
            <p>位于中国新疆，连接中亚的关键节点，气候极端干燥。</p>
        </div>
    </div>
    <div class="card">
        <img src="resources/citys/kashgar.jpg" alt="喀什">
        <div class="card-content">
            <h3>喀什</h3>
            <p>新疆南部的古老城市，是丝绸之路通往中亚的枢纽。</p>
        </div>
    </div>
    <div class="card">
        <img src="resources/citys/samarkand.jpg" alt="撒马尔罕">
        <div class="card-content">
            <h3>撒马尔罕</h3>
            <p>古代丝绸之路重镇，历史文化悠久。</p>
        </div>
    </div>
    <div class="card">
        <img src="resources/citys/bukhara.jpg" alt="布哈拉">
        <div class="card-content">
            <h3>布哈拉</h3>
            <p>古代丝绸之路商贸中心，具有深厚的文化背景。</p>
        </div>
    </div>
    <div class="card">
        <img src="resources/citys/kabul.jpg" alt="喀布尔">
        <div class="card-content">
            <h3>喀布尔</h3>
            <p>连接南亚与中亚的枢纽城市，历史悠久。</p>
        </div>
    </div>
    <div class="card">
        <img src="resources/citys/antioch.jpg" alt="安塔基亚">
        <div class="card-content">
            <h3>安塔基亚</h3>
            <p>古代丝绸之路的港口城市，是东西方文化的交汇点。</p>
        </div>
    </div>
    <div class="card">
        <img src="resources/citys/baghdad.jpg" alt="巴格达">
        <div class="card-content">
            <h3>巴格达</h3>
            <p>历史文化名城，是伊斯兰文明的发源地之一。</p>
        </div>
    </div>
    <div class="card">
        <img src="resources/citys/constantinople.jpg" alt="君士坦丁堡">
        <div class="card-content">
            <h3>君士坦丁堡</h3>
            <p>东西方文化交汇点，曾是拜占庭帝国的首都。</p>
        </div>
    </div>
    <div class="card">
        <img src="resources/citys/rome.jpg" alt="罗马">
        <div class="card-content">
            <h3>罗马</h3>
            <p>丝绸之路的重要终点，古罗马帝国的文化中心。</p>
        </div>
    </div>
</div>


<footer>
    <p>&copy; 2024 丝绸之路路线</p>
</footer>

<script>
    var map = new AMap.Map('map', {
        center: [103.8574, 35.2220],  // 设置地图中心坐标
        zoom: 4,                      // 设置缩放级别
        mapStyle: 'amap://styles/whitesmoke',  // 设置地图样式
        keyboardEnable: true,         // 启用键盘控制地图
        scrollWheel: true             // 启用鼠标滚轮缩放
    });

    var silkroadCities = [
        {name: "长安 (西安)", location: [108.9383, 34.3416], info: "丝绸之路的起点"},
        {name: "张掖", location: [100.4539, 38.9256], info: "河西走廊的重要节点"},
        {name: "敦煌", location: [94.6618, 40.1392], info: "丝绸之路的重要文化交汇点"},
        {name: "吐鲁番", location: [89.1896, 42.9474], info: "连接中亚的关键节点"},
        {name: "喀什", location: [75.9920, 39.4700], info: "通往中亚的新疆重要城市"},
        {name: "撒马尔罕", location: [66.9770, 39.6542], info: "古代丝绸之路重镇"},
        {name: "布哈拉", location: [64.4210, 39.7735], info: "古代丝绸之路商贸中心"},
        {name: "喀布尔", location: [69.1824, 34.5553], info: "连接南亚与中亚的枢纽"},
        {name: "安塔基亚", location: [36.2020, 36.2063], info: "重要港口城市"},
        {name: "巴格达", location: [44.3650, 33.3150], info: "历史文化名城"},
        {name: "君士坦丁堡", location: [28.9784, 41.0082], info: "东西方文化交汇点"},
        {name: "罗马", location: [12.4964, 41.9028], info: "丝绸之路的重要终点"}
    ];

    var markers = [];
    var polylinePath = [];

    // 添加标记
    silkroadCities.forEach(function(city) {
        var marker = new AMap.Marker({
            position: city.location,  // 使用location字段作为标记位置
            title: city.name
        });
        marker.setMap(map);
        markers.push(marker);

        // 添加到连线路径
        polylinePath.push(city.location);

        // 为每个标记添加点击事件
        marker.on('click', function() {
            var content = '<h4>' + city.name + '</h4>';
            var infoWindow = new AMap.InfoWindow({
                content: content,
                offset: new AMap.Pixel(0, -30)
            });
            infoWindow.open(map, city.location);  // 使用location字段
        });
    });

    // 绘制连线，并加上箭头
    var polyline = new AMap.Polyline({
        path: polylinePath,
        strokeColor: '#FF0000',  // 红色
        strokeWeight: 4,
        strokeOpacity: 1,
        strokeStyle: 'solid',
        isOutline: true,
        outlineColor: '#FFFFFF', // 白色边框
        lineJoin: 'round',
        lineCap: 'round'
    });
    polyline.setMap(map);
</script>
</body>
</html>
