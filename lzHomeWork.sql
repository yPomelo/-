-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: lzhomework
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `employee_table`
--

DROP TABLE IF EXISTS `employee_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_table` (
  `职工号` varchar(45) NOT NULL,
  `职工姓名` varchar(45) DEFAULT NULL,
  `EmplpoyeeAge` varchar(45) DEFAULT NULL,
  `EmployeePosition` varchar(45) DEFAULT NULL,
  `PassWord` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`职工号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_table`
--

LOCK TABLES `employee_table` WRITE;
/*!40000 ALTER TABLE `employee_table` DISABLE KEYS */;
INSERT INTO `employee_table` VALUES ('01','王一','18','采购员','123'),('02','王二','19','部门经理','123'),('03','王三','20','系统管理员','123'),('04','王四','19','采购员','123');
/*!40000 ALTER TABLE `employee_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordering_table_product`
--

DROP TABLE IF EXISTS `ordering_table_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordering_table_product` (
  `订单编号` varchar(45) NOT NULL,
  `商品编号` varchar(45) NOT NULL,
  `订货数量` int(11) DEFAULT NULL,
  PRIMARY KEY (`订单编号`,`商品编号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordering_table_product`
--

LOCK TABLES `ordering_table_product` WRITE;
/*!40000 ALTER TABLE `ordering_table_product` DISABLE KEYS */;
INSERT INTO `ordering_table_product` VALUES ('201712251820510','01',10),('201712251820510','11',10),('201712251820510','12',10),('201712251820510','17',10),('201712251820511','13',10),('201712251820511','16',10),('201712251820512','03',10),('201712251820512','14',10),('201712251820512','15',10),('201712251824410','01',10),('201712251824410','11',10),('201712251824410','12',10),('201712251824410','17',10),('201712251824411','13',10),('201712251824411','16',10),('201712251824412','03',10),('201712251824412','14',10),('201712251824412','15',10),('201712251832190','01',10),('201712251832190','11',10),('201712251832190','12',10),('201712251832190','17',10),('201712251832191','06',100),('201712251832192','03',100),('201712251832192','06',11),('201712251832192','15',100),('201712261843080','01',10),('201712261843080','11',10),('201712261843080','12',10),('201712261843080','17',10),('201712261843081','16',10),('201712261843082','03',100),('201712261843082','14',10),('201712261843082','15',10),('201712291514090','13',10),('201712291525500','55',100),('201712291525501','13',10),('201806281025590','13',10);
/*!40000 ALTER TABLE `ordering_table_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordering_table_supplier`
--

DROP TABLE IF EXISTS `ordering_table_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordering_table_supplier` (
  `订单编号` varchar(45) NOT NULL,
  `供应商编号` varchar(45) NOT NULL,
  `职工号` varchar(45) NOT NULL,
  `下单时间` varchar(45) DEFAULT NULL,
  `订单审核时间` varchar(45) DEFAULT NULL,
  `是否审核` enum('已审核','未审核') DEFAULT '未审核',
  `审核意见` varchar(45) DEFAULT NULL,
  `是否通过` enum('通过','未通过') DEFAULT '未通过',
  PRIMARY KEY (`订单编号`),
  KEY `fk_ORDERING_TABLE_EMPLOYEE_TABLE1_idx` (`职工号`),
  KEY `fk_ORDERING_TABLE_SUPPLIER_TABLE1_idx` (`供应商编号`),
  CONSTRAINT `fk_ORDERING_TABLE_EMPLOYEE_TABLE1` FOREIGN KEY (`职工号`) REFERENCES `employee_table` (`职工号`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDERING_TABLE_SUPPLIER_TABLE1` FOREIGN KEY (`供应商编号`) REFERENCES `supplier_table` (`供应商编号`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordering_table_supplier`
--

LOCK TABLES `ordering_table_supplier` WRITE;
/*!40000 ALTER TABLE `ordering_table_supplier` DISABLE KEYS */;
INSERT INTO `ordering_table_supplier` VALUES ('201712251832190','01','01','2017-12-25 18:32:19','2017-12-25 20:13:14','已审核','审核意见','通过'),('201712251832191','02','01','2017-12-25 18:32:19','2017-12-25 20:12:08','已审核','审核意见','通过'),('201712251832192','03','01','2017-12-25 18:32:19','2018-06-28 10:23:05','已审核','审核意见','通过'),('201712261843080','01','01','2017-12-26 18:43:08','2017-12-26 18:44:04','已审核','审核意见','通过'),('201712261843081','02','01','2017-12-26 18:43:08','2017-12-29 13:18:09','已审核','审核意见','通过'),('201712261843082','03','01','2017-12-26 18:43:08','2017-12-29 14:58:48','已审核','审核意见','通过'),('201712291514090','02','01','2017-12-29 15:14:09',NULL,'未审核',NULL,'未通过'),('201712291525500','01','01','2017-12-29 15:25:50','2017-12-29 15:26:58','已审核','审核意见','通过'),('201712291525501','02','01','2017-12-29 15:25:50',NULL,'未审核',NULL,'未通过'),('201806281025590','02','01','2018-06-28 10:25:59',NULL,'未审核',NULL,'未通过');
/*!40000 ALTER TABLE `ordering_table_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_table`
--

DROP TABLE IF EXISTS `product_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_table` (
  `商品编号` varchar(45) NOT NULL,
  `供应商编号` varchar(45) NOT NULL,
  `商品名称` varchar(45) DEFAULT NULL,
  `商品规格` varchar(45) DEFAULT NULL,
  `商品型号` varchar(45) DEFAULT NULL,
  `商品尺寸` varchar(45) DEFAULT NULL,
  `单价` double DEFAULT NULL,
  `进价` double DEFAULT NULL,
  `会员价` double DEFAULT NULL,
  `商品库存` int(11) DEFAULT NULL,
  PRIMARY KEY (`商品编号`),
  KEY `fk_PRODUCT_TABLE_SUPPLIER_TABLE1_idx` (`供应商编号`),
  CONSTRAINT `fk_PRODUCT_TABLE_SUPPLIER_TABLE1` FOREIGN KEY (`供应商编号`) REFERENCES `supplier_table` (`供应商编号`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_table`
--

LOCK TABLES `product_table` WRITE;
/*!40000 ALTER TABLE `product_table` DISABLE KEYS */;
INSERT INTO `product_table` VALUES ('01','01','纸抽','125ML','纸抽','小瓶',5,3,4,15),('03','03','防晒霜','125ml','增白','小瓶',5,3,4,31),('06','04','乌江榨菜','225g','单包','中包',2.5,4,2,200),('07','04','香肠','1根','食品','小包',2,1,1.5,11),('08','04','百事可乐','500ml','饮品','小瓶',3.5,2,3,11),('09','04','新乐酸奶','225ml','饮品','小包',3.5,2.5,3,11),('10','04','卫龙辣条','70g','零食','小包',2,3,1.5,11),('100','01','纸巾A','小包','日用品','小',14,10,12,11),('11','01','酒鬼花生','50g','零食','小包',2,1,1.5,11),('12','01','龙山泉啤酒','400ml','啤酒','小瓶',3,2,2.5,11),('13','02','雪花啤酒','400ml','啤酒','小瓶',3,2,2.5,1),('14','03','欧莱雅洗发水','200ml','洗发水','小瓶',20,15,17.5,21),('15','03','洽洽香瓜子','70g','零食','小袋',5,4,3,31),('16','02','洽洽花生','70g','零食','小袋',5,4,3,11),('17','01','恰恰花生麻辣味','70g','零食','小袋',5,4,3,11),('18','01','欧莱雅洗面奶','200ml','洗面奶','小瓶',20,15,17.5,100),('55','01','纸抽','纸巾',NULL,NULL,6,5,3,110),('66','01','黑色卫生巾','5片','包','M',1200,800,1000,100);
/*!40000 ALTER TABLE `product_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_table`
--

DROP TABLE IF EXISTS `supplier_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier_table` (
  `供应商编号` varchar(45) NOT NULL,
  `供应商名` varchar(45) DEFAULT NULL,
  `联系人` varchar(45) DEFAULT NULL,
  `联系电话` varchar(45) DEFAULT NULL,
  `手机` varchar(45) DEFAULT NULL,
  `单位地址` varchar(45) DEFAULT NULL,
  `邮政编码` varchar(45) DEFAULT NULL,
  `开户银行` varchar(45) DEFAULT NULL,
  `银行账号` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`供应商编号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_table`
--

LOCK TABLES `supplier_table` WRITE;
/*!40000 ALTER TABLE `supplier_table` DISABLE KEYS */;
INSERT INTO `supplier_table` VALUES ('01','旺仔集团','刘哲','123456789','123456789','广东','321','旺仔集团银行','321'),('02','乐事','刘哲','123456789','123456789','福建','321','乐事集团','123'),('03','椰树集团','刘哲','6546513','131123','海南','3156','椰树集团','156'),('04','无敌供应商','刘哲','3211321','3213215','中国','5313','无敌','313153');
/*!40000 ALTER TABLE `supplier_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'lzhomework'
--

--
-- Dumping routines for database 'lzhomework'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-06  0:15:18
