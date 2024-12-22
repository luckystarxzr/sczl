<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>敦煌壁画画廊</title>
    <link rel="stylesheet" href="resources/css/styles.css">
    <audio id="background-music" autoplay loop>
        <source src="resources/silkroad.mp3" type="audio/mpeg">
    </audio>
</head>
<body>
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

<main>
    <section class="gallery">
        <h1>景点长廊</h1>
        <h2>一起探索美丽的丝绸之路景点吧！</h2>
        <div class="gallery-grid">
            <div class="gallery-item">
                <a href="attractionDetail.jsp?id=1">
                    <img src="resources/attractions/mogao.jpg" alt="敦煌莫高窟">
                    <div class="overlay">敦煌莫高窟</div>
                </a>
            </div>
            <div class="gallery-item">
                <a href="attractionDetail.jsp?id=2">
                    <img src="resources/attractions/danxia.jpg" alt="张掖丹霞地貌">
                    <div class="overlay">张掖丹霞地貌</div>
                </a>
            </div>
            <div class="gallery-item">
                <a href="attractionDetail.jsp?id=3">
                    <img src="resources/attractions/dayanta.jpg" alt="西安大雁塔">
                    <div class="overlay">西安大雁塔</div>
                </a>
            </div>
            <div class="gallery-item">
                <a href="attractionDetail.jsp?id=4">
                    <img src="resources/attractions/huoyanshan.jpg" alt="吐鲁番火焰山">
                    <div class="overlay">吐鲁番火焰山</div>
                </a>
            </div>
            <div class="gallery-item">
                <a href="attractionDetail.jsp?id=5">
                    <img src="resources/attractions/kashgar.jpg" alt="喀什老城">
                    <div class="overlay">喀什老城</div>
                </a>
            </div>
            <div class="gallery-item">
                <a href="attractionDetail.jsp?id=6">
                    <img src="resources/attractions/cappadocia.jpg" alt="卡帕多奇亚">
                    <div class="overlay">卡帕多奇亚</div>
                </a>
            </div>
            <div class="gallery-item">
                <a href="attractionDetail.jsp?id=7">
                    <img src="resources/attractions/samarkand.jpg" alt="撒马尔罕">
                    <div class="overlay">撒马尔罕</div>
                </a>
            </div>
            <div class="gallery-item">
                <a href="attractionDetail.jsp?id=8">
                    <img src="resources/attractions/bukhara.jpg" alt="布哈拉">
                    <div class="overlay">布哈拉</div>
                </a>
            </div>
            <div class="gallery-item">
                <a href="attractionDetail.jsp?id=9">
                    <img src="resources/attractions/isfahan.jpg" alt="伊斯法罕">
                    <div class="overlay">伊斯法罕</div>
                </a>
            </div>
            <div class="gallery-item">
                <a href="attractionDetail.jsp?id=10">
                    <img src="resources/attractions/almaty.jpg" alt="阿拉木图">
                    <div class="overlay">阿拉木图</div>
                </a>
            </div>
            <div class="gallery-item">
                <a href="attractionDetail.jsp?id=11">
                    <img src="resources/attractions/baghdad.jpg" alt="巴格达">
                    <div class="overlay">巴格达</div>
                </a>
            </div>
            <div class="gallery-item">
                <a href="attractionDetail.jsp?id=12">
                    <img src="resources/attractions/damascus.jpg" alt="大马士革">
                    <div class="overlay">大马士革</div>
                </a>
            </div>
        </div>
    </section>

    <div id="modal" class="modal">
        <span class="close" onclick="closeModal()">&times;</span>
        <img id="modal-image" class="modal-content" alt="">
        <div id="modal-caption" class="caption"></div>
    </div>
</main>

<footer>
    <p>&copy; 2024 敦煌壁画 & xzr</p>
</footer>

<script src="resources/js/scripts.js"></script>
</body>
</html>
