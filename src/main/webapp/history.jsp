<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>丝绸之路的历史</title>
    <link rel="stylesheet" href="resources/css/styles.css">
</head>
<body>
<!-- 背景音乐 -->
<audio id="background-music" autoplay loop>
    <source src="resources/silkroad.mp3" type="audio/mpeg">
</audio>

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
    <section class="history">
        <h2>丝绸之路的历史</h2>
        <h4>丝绸之路是一条跨越亚欧大陆的古老商贸路线，不仅促进了东西方的经济和文化交流，还对全球历史产生了深远影响。</h4>
        <div class="timeline">
            <div class="timeline-item" data-aos="fade-up">
                <h3>公元前2世纪</h3>
                <p>丝绸之路的开端，汉朝的张骞出使西域，开辟了连接中国与中亚、欧洲的贸易通道。</p>
            </div>
            <div class="timeline-item" data-aos="fade-up">
                <h3>公元1-3世纪</h3>
                <p>丝绸之路的黄金时期，商队穿越沙漠和山脉，将中国的丝绸、瓷器、茶叶等商品传递到西方，同时也引入了西方的文化、宗教和技术。</p>
            </div>
            <div class="timeline-item" data-aos="fade-up">
                <h3>7-9世纪</h3>
                <p>唐朝时期，丝绸之路达到了其繁荣的顶峰。中亚和中国的经济文化交流频繁，佛教、伊斯兰教等宗教的传播也通过这条路线发生。</p>
            </div>
            <div class="timeline-item" data-aos="fade-up">
                <h3>13世纪</h3>
                <p>元朝的建立使得丝绸之路再次成为重要的东西方交流渠道。蒙古帝国的统一为贸易和文化交流提供了更广泛的保障。</p>
            </div>
            <div class="timeline-item" data-aos="fade-up">
                <h3>15世纪-17世纪</h3>
                <p>随着大航海时代的到来，传统的陆路丝绸之路逐渐被海上航线取代，但丝绸之路的历史遗产仍然深刻影响着东西方的交流。</p>
            </div>
            <div class="timeline-item" data-aos="fade-up">
                <h3>21世纪</h3>
                <p>现代“一带一路”倡议的提出，丝绸之路的影响力被重新认识。新时期的丝绸之路不仅是经济发展的纽带，也成为各国文化互鉴的重要平台。</p>
            </div>
        </div>
    </section>
</main>

<footer>
    <p>&copy; 2024 丝绸之路历史 & xzr</p>
</footer>

<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init(); // 初始化AOS动画
</script>
</body>
</html>
