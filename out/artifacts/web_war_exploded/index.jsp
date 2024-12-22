<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>丝绸之路 - 探索与交流</title>
    <link rel="stylesheet" href="resources/css/styles.css">
    <audio id="background-music" autoplay loop>
        <source src="resources/silkroad.mp3" type="audio/mpeg">
    </audio>
    <style>
        .hero {
            padding: 100px 20px; /* 为 hero 区域添加较大的上下内边距 */
            color: #fff; /* 确保文字颜色为白色 */
            text-align: center; /* 文字居中对齐 */
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.7); /* 添加文字阴影，增强可读性 */
            background: url('resources/images/bg.jpg') no-repeat center center/cover; /* 设置背景图片为1.jpg */
            background-size: cover; /* 确保背景图片覆盖整个区域 */
        }
    </style>
</head>
<body>
<header>
    <nav style="display: flex; align-items: center;">
        <img src="resources/images/logo.png" alt="Logo" style="width: 50px; height: 50px; margin-right: 10px;">
        <h1>丝绸之路</h1>
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

<main>
    <section class="hero">
        <h2>穿越丝绸之路</h2>
        <p>跟随古代商旅的脚步，探索这条连结东西方的文化之路。</p>
        <button onclick="window.location.href='journey.jsp'">开始探索</button>
    </section>

    <section class="features">
        <div class="feature">
            <a href="history.jsp" target="_blank">
                <img src="resources/images/lo1.png" alt="历史洞察">
            </a>
            <h3>历史洞察</h3>
            <meta name="description" content="了解丝绸之路的历史背景及其文化交流的深远影响。">
        </div>
        <div class="feature">
            <a href="attraction.jsp" target="_blank">
                <img src="resources/images/lo2.png" alt="丝绸之路景点">
            </a>
            <h3>景点长廊</h3>
            <meta name="description" content="欣赏丝绸之路沿线地区的独特艺术与文化遗产。">
        </div>
        <div class="feature">
            <a href="hotel.jsp" target="_blank">
                <img src="resources/images/lo3.png" alt="酒店预订">
            </a>
            <h3>酒店预订</h3>
            <meta name="description" content="提前预订旅途酒店，加入我们探索丝绸之路的旅程。">
        </div>
    </section>
    <jsp:include page="news.jsp" />
</main>
</body>
</html>
