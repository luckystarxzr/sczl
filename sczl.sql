-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: sczl
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `sczl`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sczl` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `sczl`;

--
-- Table structure for table `attractions`
--

DROP TABLE IF EXISTS `attractions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attractions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `buy_url` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `likes` int DEFAULT '0',
  `ticket_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attractions`
--

LOCK TABLES `attractions` WRITE;
/*!40000 ALTER TABLE `attractions` DISABLE KEYS */;
INSERT INTO `attractions` VALUES (1,'敦煌莫高窟','敦煌莫高窟位于甘肃省敦煌市，是丝绸之路上的重要佛教艺术遗址。作为世界文化遗产，莫高窟以其保存完好的壁画和雕塑而闻名，是研究佛教艺术和古代文化的重要场所。这里的洞窟壁画展示了宗教、历史和民俗等方面的内容，涵盖了从十六国到唐朝时期的多元文化。莫高窟的艺术风格独特，精美的壁画和雕塑将佛教文化的演变和丝绸之路沿线的交流历程生动地呈现出来。每年，成千上万的游客和学者纷纷前来，研究这里的艺术和历史，莫高窟被誉为\"东方艺术宝库\"。','甘肃省敦煌市','mogao.jpg','','2024-12-07 11:45:37',1206,50.00),(2,'张掖丹霞地貌','张掖丹霞地貌位于甘肃省张掖市，是世界著名的自然景观。这里的红色岩层在风化和侵蚀的作用下形成了奇特的地貌，展现了丰富的色彩和层次感。张掖丹霞地貌以其五彩斑斓的山脉、如画的峡谷和奇异的岩石景观吸引了大量游客。阳光照射下，山脉的颜色变化丰富，形成了一幅幅如梦如幻的自然画卷。这个景区不仅具有极高的旅游价值，也是地质学研究的重要基地。它是大自然赋予人类的美丽宝藏，是摄影爱好者的天堂。','甘肃省张掖市','danxia.jpg','','2024-12-07 11:45:37',901,40.00),(3,'西安大雁塔','西安大雁塔位于陕西省西安市，是中国古代佛教文化的重要象征之一。建于唐代的大雁塔，是一座七层佛塔，原用于存放佛教经典和文物。作为丝绸之路的起点之一，大雁塔不仅是西安的标志性建筑，也是世界文化遗产的重要组成部分。大雁塔融合了中国古代建筑艺术的精髓，是唐代建筑风格的杰出代表。游客可以登塔远望西安古城，欣赏城市的美丽景色，并在塔下感受到历史的厚重。每年吸引着成千上万的游客前来瞻仰和参拜。','陕西省西安市','dayanta.jpg','','2024-12-07 11:45:37',1500,60.00),(4,'吐鲁番火焰山','吐鲁番火焰山位于新疆吐鲁番市，是一个充满神秘色彩的自然景点。火焰山因其烈日下红色的山峰而得名，气温常年高达40°C以上，被誉为\"地狱之门\"。这里独特的地貌和极端气候条件，使它成为自然环境研究的重要地点。火焰山不仅仅是一个旅游景点，还是中国西部地区的一个重要文化和地质遗址。由于其独特的地理位置和环境条件，这里吸引了许多考察团队和游客，是探索沙漠环境和高温天气的理想场所。','新疆吐鲁番市','huoyanshan.jpg','','2024-12-07 11:45:37',800,45.00),(5,'喀什老城','喀什老城位于新疆喀什市，是丝绸之路沿线的一座历史文化名城。这里不仅是维吾尔文化的发源地之一，也是中亚文化的重要交汇点。喀什老城保留了大量的古建筑和历史遗迹，如艾提尕尔清真寺、古城墙和传统市场等。游客可以在这里漫步于曲折的小巷，品味浓厚的历史气息和民族文化。喀什的市场也是世界著名，香料、手工艺品、地毯和各种独特的商品让游客流连忘返。这里还是感受中亚和丝绸之路历史的最佳场所。','新疆喀什市','kashgar.jpg','','2024-12-07 11:45:37',1100,55.00),(6,'卡帕多奇亚','卡帕多奇亚位于土耳其，是世界著名的自然景点。这里的\"仙人烟囱\"岩石形成了独特的地质景观，成为了热气球旅游的理想目的地。卡帕多奇亚的历史可以追溯到古希腊时代，曾是基督教的发源地之一。这里不仅有如梦如幻的岩石和地下城市，还有丰富的历史遗迹和文化遗产。游客可以在这里体验热气球飞行，俯瞰壮观的地貌，或参观古代的地下城市，感受这片神奇土地的神秘与魅力。','土耳其卡帕多奇亚','cappadocia.jpg','','2024-12-07 11:45:37',2000,100.00),(7,'撒马尔罕','撒马尔罕是乌兹别克斯坦的一座历史名城，是丝绸之路上的重要商业和文化中心。撒马尔罕融合了波斯、阿拉伯和蒙古等多种文化，是中亚地区的璀璨明珠。这里的建筑风格独特，如雷吉斯坦广场、比比哈尼姆清真寺等，展示了伊斯兰文化的辉煌成就。撒马尔罕的历史遗迹和繁华的市场让游客可以充分体验古丝绸之路的风情。它不仅是古代丝路的文化象征，也是今天游客了解中亚历史的重要目的地。','乌兹别克斯坦撒马尔罕','samarkand.jpg','','2024-12-07 11:45:37',1800,80.00),(8,'布哈拉','布哈拉位于乌兹别克斯坦，是丝绸之路的重要城市之一，因其保存完好的伊斯兰建筑和古老的市场而著称。布哈拉的历史可以追溯到公元前，是中亚地区的重要文化和学术中心。这里有着深厚的历史底蕴，曾是商贸和宗教活动的中心。布哈拉的老城区是世界文化遗产，游客可以在其中漫步，感受古老的文化氛围和风貌。这里的建筑群、清真寺和市场展示了波斯和中亚的文化融合。','乌兹别克斯坦布哈拉','bukhara.jpg','','2024-12-07 11:45:37',1600,70.00),(9,'伊斯法罕','伊斯法罕位于伊朗，是该国的历史文化中心之一，也被誉为\"半个世界\"。伊斯法罕因其宏伟的伊斯兰建筑、古老的桥梁和庭园而闻名。这里的伊玛目广场和四十柱宫等建筑，展示了波斯文化的辉煌。伊斯法罕曾是萨法维王朝的首都，是波斯文化的核心地带。游客可以在这里参观历史遗迹、游览美丽的园林，领略波斯文化的魅力。它是丝绸之路的重要一站，也是伊朗最具吸引力的旅游目的地之一。','伊朗伊斯法罕','isfahan.jpg','','2024-12-07 11:45:37',1500,75.00),(10,'阿姆斯特丹运河','阿姆斯特丹运河是荷兰首都阿姆斯特丹的重要地标之一，被列为世界文化遗产。运河网络贯穿整个城市，为游客提供了一种独特的观光方式。阿姆斯特丹运河的历史可以追溯到17世纪，当时是为了促进城市的贸易和航运而建造的。如今，游客可以乘坐游船穿梭于运河之间，欣赏到两岸美丽的建筑、风景和博物馆。运河沿线的咖啡馆和商店也为游客提供了一个休闲放松的好去处。','荷兰阿姆斯特丹','canals.jpg','','2024-12-07 11:45:37',1300,90.00),(11,'巴格达','巴格达是古代丝绸之路的一个重要城市，拥有丰富的历史文化遗产。作为伊拉克的首都，巴格达在历史上曾是阿拔斯王朝的首都，是中东地区学术和宗教思想的中心。巴格达自古以来就是东西方文化交流的桥梁，见证了多种文化的碰撞与融合。尽管近年来遭遇战乱，巴格达依然保留着许多历史遗迹，如古代的清真寺、市场和城墙等。游客可以在这里深入了解阿拉伯文化与历史，感受巴格达的悠久传统与文化底蕴。','伊拉克巴格达','baghdad.jpg','','2024-12-07 11:45:37',1100,50.00),(12,'大马士革','大马士革是世界上最古老的持续有人居住的城市之一，也是丝绸之路的重要城市。作为叙利亚的首都，大马士革有着深厚的历史背景和文化底蕴。这里拥有古老的建筑、宗教遗址和市场，是中东地区的文化和宗教中心之一。大马士革曾是阿拉伯帝国的首都，伊斯兰文化的发源地之一。游客可以在这里看到许多历史遗迹，如大马士革古城、阿尔乌马亚清真寺等，感受这座城市丰富的历史和文化。大马士革的传统市场与街巷是其独特的魅力之一，是历史爱好者和摄影师的天堂。','叙利亚大马士革','damascus.jpg','','2024-12-07 11:45:37',1400,85.00);
/*!40000 ALTER TABLE `attractions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attraction_id` int DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `comment` text,
  `comment_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The time when the comment was made',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,1,'11','21313','2024-12-09 12:48:47'),(4,5,'11','2143124','2024-12-13 12:42:19'),(5,5,'11','2314321421','2024-12-13 12:42:23'),(7,2,'33','213123','2024-12-13 12:58:20'),(8,1,'11','124144','2024-12-23 02:59:40');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotels`
--

DROP TABLE IF EXISTS `hotels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `location` varchar(100) DEFAULT NULL,
  `price_per_night` decimal(10,2) DEFAULT '0.00',
  `contact_phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotels`
--

LOCK TABLES `hotels` WRITE;
/*!40000 ALTER TABLE `hotels` DISABLE KEYS */;
INSERT INTO `hotels` VALUES (1,'西安皇苑华美达广场酒店','坐落于西安，近兵马俑景区','陕西省西安市',480.00,'029-83882222','heih2222otel@zhangye.com','https://tse4-mm.cn.bing.net/th/id/OIP-C.C9RY1oe3I54-4jQBMoihpQHaHa?w=147&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:22','2024-12-11 12:28:51'),(2,'大雁塔凯悦酒店','紧邻大雁塔，现代风格设计','陕西省西安市',620.00,'029-88781234','heihriver23.hotel@zhangye.com','https://assets.hyatt.com/content/dam/hyatt/hyattdam/images/2017/01/23/1145/Hyatt-Regency-Xian-P054-Swimming-Pool.jpg/Hyatt-Regency-Xian-P054-Swimming-Pool.16x9.jpg?imwidth=1280','2024-12-08 12:45:22','2024-12-11 12:17:37'),(9,'张掖宾馆','临近黑河风景区，特色民宿','甘肃省张掖市',280.00,'0937-4521199','heihriver.hotel@zhangye.com','https://tse3-mm.cn.bing.net/th/id/OIP-C.vNhS1Q9QjWu286NpOiFOcwHaE8?w=267&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:22','2024-12-11 12:28:51'),(15,'敦煌雅阁度假酒店','现代奢华，沙漠度假','甘肃省敦煌市',720.00,'0937-8887788','agoda.dunhuang@hotel.com','https://tse4-mm.cn.bing.net/th/id/OIP-C.KeynD96WK5hx-x26b4ZTUwHaFj?w=228&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:22','2024-12-11 12:29:25'),(19,'吐鲁番文化主题酒店','展现丝绸之路文化','新疆吐鲁番市',320.00,'0995-6612244','culture.hotel@turpan.com','https://tse1-mm.cn.bing.net/th/id/OIP-C.xWl07eVvI6IZh90zKhlinAHaHb?w=146&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:33','2024-12-11 12:28:51'),(20,'交河故城精品酒店','靠近世界文化遗产','新疆吐鲁番市',390.00,'0995-6789900','jiaohe.hotel@turpan.com','https://tse1-mm.cn.bing.net/th/id/OIP-C.3jeJ8Xsh6EkJ7ztYbgIcrAHaGS?w=210&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:33','2024-12-11 12:28:51'),(21,'艾提尚酒店','现代伊斯兰风格设计','新疆喀什地区喀什市',520.00,'0998-2886666','aiti.hotel@kashgar.com','https://tse4-mm.cn.bing.net/th/id/OIP-C.XWg8Xt1dRJ1-jTNuLzEPIQHaE8?w=326&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:33','2024-12-11 12:28:51'),(22,'老城区传统酒店','保留古老建筑风格','新疆喀什地区喀什市',380.00,'0998-2334455','oldcity.hotel@kashgar.com','https://tse2-mm.cn.bing.net/th/id/OIP-C.QaBiAo0qjJd4xRcYKa9GVAHaE6?w=235&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:33','2024-12-11 12:28:51'),(29,'蓝色圆顶精品酒店','伊斯兰建筑风格','乌兹别克斯坦撒马尔罕',550.00,'+998 66 788 99 00','bluedomе.hotel@samarkand.com','https://tse4-mm.cn.bing.net/th/id/OIP-C.7teBmXE4sOTkKiuiKx5jQAHaEZ?w=289&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:33','2024-12-11 12:28:51'),(30,'撒马尔罕希尔顿酒店','国际标准，现代设施','乌兹别克斯坦撒马尔罕',680.00,'+998 66 666 77 88','hilton.samarkand@hilton.com','https://tse1-mm.cn.bing.net/th/id/OIP-C.d9W2O41mcuRTZBvtmYvEkwHaGv?w=188&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:33','2024-12-11 12:28:51'),(31,'阿尔克城堡酒店','古城中的历史建筑','乌兹别克斯坦布哈拉',420.00,'+998 65 223 44 55','ark.castle@bukhara.com','https://tse4-mm.cn.bing.net/th/id/OIP-C.82nakp_OxyleipWUZT1tfQHaE8?w=193&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:33','2024-12-11 12:28:51'),(32,'丝绸之路酒店','丝路文化主题','乌兹别克斯坦布哈拉',380.00,'+998 65 445 66 77','silkroad.hotel@bukhara.com','https://tse4-mm.cn.bing.net/th/id/OIP-C.EpG0-qEVNpINnmbKsy_1SwHaFj?w=228&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:33','2024-12-11 12:28:51'),(39,'市中心商务酒店','便捷商务住宿','阿富汗喀布尔',420.00,'+93 20 789 0123','downtown.business@kabul.com','https://tse2-mm.cn.bing.net/th/id/OIP-C.wzJ7hsK6I4a2xNVM5VdwrgHaE7?w=249&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:33','2024-12-11 12:28:51'),(40,'山地景观酒店','俯瞰喀布尔美景','阿富汗喀布尔',390.00,'+93 20 567 8901','mountain.view@kabul.com','https://tse1-mm.cn.bing.net/th/id/OIP-C.db5rOr4PecNfpul0mjCeWwHaEl?w=239&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:33','2024-12-11 12:28:51'),(45,'商务中心酒店','现代商务设施','伊拉克巴格达',450.00,'+964 770 567 8901','business.center@baghdad.com','https://tse4-mm.cn.bing.net/th/id/OIP-C.EpG0-qEVNpINnmbKsy_1SwHaFj?w=257&h=193&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:33','2024-12-11 12:28:51'),(46,'博斯普鲁斯海峡酒店','海峡景观豪华酒店','土耳其伊斯坦布尔',680.00,'+90 212 345 6789','bosphorus.hotel@istanbul.com','https://tse4-mm.cn.bing.net/th/id/OIP-C.qFHHjTU--3JcJI51HV3fUQHaFj?w=222&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:45:55','2024-12-11 12:28:51'),(47,'罗马君悦酒店','位于市中心，提供顶级的住宿体验和豪华设施。','罗马',900.00,'+39-06-5555555','contact@romehotel.com','https://tse4-mm.cn.bing.net/th/id/OIP-C.b_12TkNFyrqgExNYXST2pQHaEK?w=270&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:49:24','2024-12-11 12:28:51'),(48,'罗马皇家酒店','临近古罗马竞技场，方便游客参观历史遗迹。','罗马',700.00,'+39-06-4444444','info@romehotel.com','https://tse2-mm.cn.bing.net/th/id/OIP-C.x9chQ7Q9TXPFPdEpQSSHUQHaEK?w=280&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:49:24','2024-12-11 12:28:51'),(49,'特雷维喷泉酒店','步行可到达特雷维喷泉，是游客的理想选择。','罗马',800.00,'+39-06-3333333','reservations@romehotel.com','https://tse3-mm.cn.bing.net/th/id/OIP-C.Mm8mh1B7ZO2tsjVweFIiqwHaFX?w=255&h=184&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:49:24','2024-12-11 12:28:51'),(55,'圣索菲亚酒店','临近圣索菲亚大教堂，交通便利，旅游方便。','君士坦丁堡',500.00,'+90-212-2222222','sales@istanbulhotel.com','https://tse2-mm.cn.bing.net/th/id/OIP-C.ns-zb0NKe7ztPmO7wfZRlwHaFj?w=264&h=198&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:49:28','2024-12-11 12:28:51'),(56,'独立大街酒店','位置优越，步行即可到达独立大街，购物方便。','君士坦丁堡',350.00,'+90-212-1111111','support@istanbulhotel.com','https://tse1-mm.cn.bing.net/th/id/OIP-C.baTwj1TR2QJOdu4g8_ki9QHaEf?w=316&h=192&c=7&r=0&o=5&dpr=1.5&pid=1.7','2024-12-08 12:49:28','2024-12-11 12:28:51');
/*!40000 ALTER TABLE `hotels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (2,'丝绸之路重启：新时代的经济与文化带','王芳','中国提出\"一带一路\"倡议，将丝绸之路经济带和21世纪海上丝绸之路的复兴带入了新时代。这一倡议为沿线国家带来了基础设施建设、经济发展以及文化互动的机会。通过这一倡议，中国不仅在经济上与世界各国开展合作，还在文化上推动了多元化交流与理解。对于沿线国家来说，\"一带一路\"提供了更广泛的合作平台，促进了基础设施的互联互通，推动了各国的经济发展。同时，\"一带一路\"倡议也成为连接不同文明与文化的桥梁，增进了各国之间的文化理解与友谊，为全球经济合作提供了新的动力与机遇。','2.jpg','2024-12-08 06:54:56'),(3,'丝绸之路的全球影响：贸易与文化的交织','张伟','丝绸之路不仅促进了商品的交换，还带来了包括佛教、伊斯兰教和基督教在内的多种宗教文化的传播，形成了一个多元文化的交汇点。丝绸之路的经济影响是深远的，它为东西方之间的商业互动创造了条件，将中国的丝绸、茶叶、瓷器等商品送到西方市场，而西方的玻璃器皿、金属制品和葡萄酒等则进入了中国市场。然而，丝绸之路的意义不仅仅在于商业，它还在于文化的传播。佛教自印度通过丝绸之路传入中国，随后又传播到中亚、东南亚乃至日本，成为东西文化的重要纽带。同时，丝绸之路也促进了科学、艺术、技术和哲学思想的交流，推动了多元文化的碰撞与融合。','3.jpg','2024-12-08 06:54:56'),(4,'丝绸之路上的古代文明交流','赵强','通过丝绸之路，古代中国与波斯、印度、罗马帝国等文明进行了深入的交流。丝绸之路不仅是物资的流动通道，还是艺术、科技和哲学思想的传播路网。中国的丝绸、纸张、火药、指南针等发明通过丝绸之路传入西方，对西方的科学技术和社会发展产生了深远的影响。同时，西方的建筑技术、天文学、医学等也通过丝绸之路传入中国，对中国古代文明的发展起到了促进作用。丝绸之路的存在使得东西方的文化、科技和哲学在长期的交流与碰撞中不断丰富与发展，形成了深厚的文化积淀。','4.jpg','2024-12-08 06:54:56'),(5,'从丝绸之路到\"一带一路\"：中国的全球视野','李娜','丝绸之路的历史意义跨越了数千年，今天，\"一带一路\"倡议继承并发扬了丝绸之路的精神，促进了中国与世界各国的合作与互动。\"一带一路\"不仅仅是一个经济合作计划，它也是推动全球文化交流与发展的平台。通过加强各国之间的经济合作与文化互访，丝绸之路的现代版已经成为推动世界多极化和经济全球化的重要力量。这一倡议使中国在全球事务中的影响力不断增强，也为沿线国家带来了更多的经济、文化及发展机会，帮助各国共同发展，实现共赢。','5.jpg','2024-12-08 06:54:56'),(6,'丝绸之路与伊斯兰文化的传播','陈立','丝绸之路不仅连接了东西方的经济，还推动了伊斯兰文化在中亚地区的传播。阿拉伯商人和学者通过这条路线将阿拉伯语和伊斯兰教带入了更广泛的区域，促进了东西方文明的对话。随着贸易的拓展，伊斯兰的学术思想、艺术风格以及宗教信仰在丝绸之路沿线的许多国家和地区生根发芽，成为文化交流的一个重要组成部分。伊斯兰教在丝绸之路沿线的传播不仅改变了这些地区的宗教格局，也促成了社会、经济、政治等多个领域的深远变革。','6.jpg','2024-12-08 06:54:56'),(7,'丝绸之路的遗址保护与研究','孙磊','丝绸之路沿线的遗址，如敦煌莫高窟、吐鲁番的交河故城，都是重要的文化遗产。随着考古学和遗址保护工作的展开，越来越多的历史证据被挖掘出来，揭示了丝绸之路的辉煌历史。为了保护这些珍贵的文化遗产，许多国家和地区加强了对遗址的保护和研究工作，同时也加深了对丝绸之路历史和文化的了解。考古学家通过对遗址的发掘，揭示了丝绸之路的贸易网络、宗教交流及其对世界历史的影响。近年来，随着科技的发展，遗址的保护工作逐步走向数字化，保护和修复工作更加科学与系统。','7.jpg','2024-12-08 06:54:56'),(8,'丝绸之路的经济合作：促进全球化的先驱','周敏','丝绸之路不仅推动了物资的交换，还促进了沿线国家间的经济合作与互通，成为古代全球化的先驱。通过这条路线，中国的丝绸、茶叶、瓷器等商品进入了西方市场，带动了全球经济的互动。与此同时，西方的商品、技术和思想也通过丝绸之路传入中国，进一步促进了中国经济的繁荣与发展。丝绸之路的经济合作不仅体现在物资交换上，更体现在商贸城市的繁荣和国际市场的形成。它是全球化的雏形，为后来的国际贸易和跨国合作奠定了基础。','8.jpg','2024-12-08 06:54:56'),(9,'丝绸之路的宗教交流：佛教的传播','王洋','丝绸之路不仅促进了商品的流通，还在各国之间传播了佛教。佛教自印度通过丝绸之路传入中国，随后又传播到中亚、东南亚乃至日本，成为东西文化的重要纽带。佛教的传播不仅改变了中国的宗教格局，也影响了整个东亚地区的文化与社会结构，使得丝绸之路成为文化与宗教交流的枢纽。通过佛教的传播，丝绸之路成了东西方文明互动的重要象征，不仅推动了宗教的交流，还促进了不同文化之间的互鉴与融合。','9.jpg','2024-12-08 06:54:56'),(10,'丝绸之路的起源与发展：从汉朝到唐朝','刘建','丝绸之路的形成与发展经历了漫长的历史过程。最初在汉朝时期，张骞出使西域开启了丝绸之路的早期贸易。到唐朝时，丝绸之路达到了巅峰，成为连接东西方的重要通道。随着中亚地区的稳定和丝绸之路的拓展，唐朝的盛世使得这条贸易路线更加繁荣，成为东西方文化、科技、宗教交流的关键通道。唐朝时期，丝绸之路不仅促进了商贸的繁荣，还推动了文化的融合，成为东西方文明交汇的重要纽带。','10.jpg','2024-12-08 06:54:56'),(11,'丝绸之路与中亚：跨文化的交流与融合','高梅','丝绸之路通过中亚将中国的丝绸、茶叶与西方的金属制品、珠宝等商品互通有无。中亚地区不仅是商品的集散地，也是多种文化、语言和宗教的交汇处。随着丝绸之路的畅通，中亚成为东西方文化交流的重要桥梁。在这个地区，不同文明的交融促进了技术、艺术、宗教等方面的共同进步，形成了独特的文化景观。通过丝绸之路，中亚不仅接纳了来自东方的文化，也传入了大量的西方思想和技术，使得这个地区成为跨文化交流的典范。','11.jpg','2024-12-08 06:54:56');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `comment_id` int DEFAULT NULL,
  `attraction_id` int DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `report_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('未处理','已处理') DEFAULT '未处理',
  PRIMARY KEY (`id`),
  KEY `attraction_id` (`attraction_id`),
  KEY `comment_id` (`comment_id`),
  KEY `username` (`username`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reports_ibfk_3` FOREIGN KEY (`attraction_id`) REFERENCES `attractions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (9,'33',7,2,'不良语言','2024-12-13 21:02:35','未处理');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` enum('USER','ADMIN') DEFAULT 'USER',
  `status` enum('ACTIVE','BANNED') DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `salt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'11','pN+Aqy48YdlOMDqg5Y57QA==$cAzAtV6ED79IIdQ3M+wrtT90JlVY5glV5U1EG8ZRSNU=','USER','BANNED','2024-12-08 14:48:47',NULL),(10,'22','MnrR2TNb1lUMo6jyPpyNWA==$/Beicg0nhD9Z3OR3SRvLfnCWxaKYNrAStSSFTwuGv4w=','USER','ACTIVE','2024-12-09 12:08:53',NULL),(13,'111','9I82Pu/YcWreF3WLiELl1Q==$FaORTmy8E/3U6e6+YPPPQ3XI0My9BbVXV8snNaoCSiA=','ADMIN','ACTIVE','2024-12-09 12:11:27',NULL),(14,'33','E6pBFJbSmIiYvIEoO+XPsg==$yRKpN4kwXLy0GcZWFJsKsxjfcoWkUKDWU2OSc4pzSLY=','USER','ACTIVE','2024-12-13 12:51:26',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-23 15:33:36
