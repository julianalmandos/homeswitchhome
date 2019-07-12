/*
Navicat MySQL Data Transfer

Source Server         : Symfony
Source Server Version : 50721
Source Host           : localhost:3306
Source Database       : hsh

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2019-07-11 14:33:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bids
-- ----------------------------
DROP TABLE IF EXISTS `bids`;
CREATE TABLE `bids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL,
  `idWeek` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of bids
-- ----------------------------
INSERT INTO `bids` VALUES ('20', '130001.00', '382', 'orianarevalos@gmail.com');

-- ----------------------------
-- Table structure for bookings
-- ----------------------------
DROP TABLE IF EXISTS `bookings`;
CREATE TABLE `bookings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idMaxBId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bookings
-- ----------------------------

-- ----------------------------
-- Table structure for cities
-- ----------------------------
DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cities
-- ----------------------------

-- ----------------------------
-- Table structure for countries
-- ----------------------------
DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of countries
-- ----------------------------

-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idProperty` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of images
-- ----------------------------
INSERT INTO `images` VALUES ('127', '6', 'https://st3.idealista.com/news/archivos/styles/news_detail/public/2018-11/casa_prefabricada.jpg?sv=pX_Hqy9d&itok=kCOtbqgQ');
INSERT INTO `images` VALUES ('128', '7', 'https://i.pinimg.com/originals/11/2c/2d/112c2d46206b19be8ae926b2f7fdce19.jpg');
INSERT INTO `images` VALUES ('129', '8', 'https://i.pinimg.com/originals/11/2c/2d/112c2d46206b19be8ae926b2f7fdce19.jpg');
INSERT INTO `images` VALUES ('130', '9', 'https://st3.idealista.com/news/archivos/styles/news_detail/public/2018-11/casa_prefabricada.jpg?sv=pX_Hqy9d&itok=kCOtbqgQ');
INSERT INTO `images` VALUES ('131', '10', 'https://st3.idealista.com/news/archivos/styles/news_detail/public/2018-11/casa_prefabricada.jpg?sv=pX_Hqy9d&itok=kCOtbqgQ');
INSERT INTO `images` VALUES ('132', '11', 'https://st3.idealista.com/news/archivos/styles/news_detail/public/2018-11/casa_prefabricada.jpg?sv=pX_Hqy9d&itok=kCOtbqgQ');

-- ----------------------------
-- Table structure for localities
-- ----------------------------
DROP TABLE IF EXISTS `localities`;
CREATE TABLE `localities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of localities
-- ----------------------------

-- ----------------------------
-- Table structure for normal_requests
-- ----------------------------
DROP TABLE IF EXISTS `normal_requests`;
CREATE TABLE `normal_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `accepted` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of normal_requests
-- ----------------------------
INSERT INTO `normal_requests` VALUES ('1', '14', 'Porque quiero', '1');

-- ----------------------------
-- Table structure for premium_requests
-- ----------------------------
DROP TABLE IF EXISTS `premium_requests`;
CREATE TABLE `premium_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `accepted` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of premium_requests
-- ----------------------------
INSERT INTO `premium_requests` VALUES ('2', '14', '', '1');
INSERT INTO `premium_requests` VALUES ('3', '15', 'Porque si', '1');

-- ----------------------------
-- Table structure for properties
-- ----------------------------
DROP TABLE IF EXISTS `properties`;
CREATE TABLE `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `country` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `locality` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of properties
-- ----------------------------
INSERT INTO `properties` VALUES ('6', 'Casa de Oriana', 'asdasd', 'asdasd', '123000.00', 'Argentina', 'Buenos Aires', 'La Plata');
INSERT INTO `properties` VALUES ('7', 'Casa de Candela', 'asdasd', 'asdasd', '130000.00', 'Argentina', 'Buenos Aires', 'La Plata');
INSERT INTO `properties` VALUES ('8', 'Casa de Oriana', 'asdasd', 'asdasd', '130000.00', 'Argentina', 'La Pampa', 'La Plata');
INSERT INTO `properties` VALUES ('9', 'asdasdsad', 'asdas', 'asdasda', '5000000.00', 'asdasd', 'asdasd', 'asdasd');
INSERT INTO `properties` VALUES ('10', 'jkhkjh', 'kjhkjhkjh', 'kjhkjhkj', '12312332.00', 'kjhjkhkjh', 'kjhkjhkjh', 'kjhkkjkjh');
INSERT INTO `properties` VALUES ('11', 'oiuoiuoi', 'uoiuoiu', 'oiuoiuoiu', '99999999.99', 'lkjlkjlk', 'jkljlkjlkj', 'lkjlkjlkjlk');

-- ----------------------------
-- Table structure for provinces
-- ----------------------------
DROP TABLE IF EXISTS `provinces`;
CREATE TABLE `provinces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of provinces
-- ----------------------------

-- ----------------------------
-- Table structure for suscription_prices
-- ----------------------------
DROP TABLE IF EXISTS `suscription_prices`;
CREATE TABLE `suscription_prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` int(11) NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of suscription_prices
-- ----------------------------
INSERT INTO `suscription_prices` VALUES ('1', '0', '2000');
INSERT INTO `suscription_prices` VALUES ('2', '1', '3000');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(40) NOT NULL,
  `surname` varchar(40) NOT NULL,
  `birthday` datetime(6) DEFAULT NULL,
  `role` int(11) NOT NULL,
  `card_number` varchar(20) NOT NULL,
  `card_expiration_month` int(11) NOT NULL,
  `card_expiration_year` int(11) NOT NULL,
  `card_security_number` varchar(3) NOT NULL,
  `recover_password_token` varchar(255) DEFAULT NULL,
  `credits` int(11) NOT NULL,
  `last_charge` date DEFAULT NULL,
  `card_type` varchar(255) NOT NULL,
  `register_date` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('12', 'julianalmandos@gmail.com', '$2b$08$p5Yb5aWgr4Dl7Ck7N8iB1.y1hIM6ZaPd6I/YpM4MEIQMV.7.qAnme', 'Julian', 'Almandos', '1998-07-08 00:00:00.000000', '2', '458562697852645963', '12', '2029', '123', '', '0', '2019-06-04', 'VISA', '2019-07-11');
INSERT INTO `users` VALUES ('14', 'orianarevalos@gmail.com', '$2b$08$GhtkpcWaQm9XWPoWzAJtQORX23C0HMdMNHX7LpFY8fvlK2gDlsRPi', 'Oriana', 'Arevalos', '1998-07-08 00:00:00.000000', '0', '123123123123123123', '10', '2020', '123', null, '0', '2019-07-11', 'VISA', '2019-07-11');
INSERT INTO `users` VALUES ('15', 'candelamrouaux@gmail.com', '$2b$08$OACoSQVY62P9Mxs3X3MQM.gT8QW9ALKEhSNGkTmElVbldv1JN11iG', 'Candela', 'Rouaux', '1998-07-08 00:00:00.000000', '1', '123123123123123123', '11', '2028', '123', null, '0', '2019-07-11', 'VISA', '2019-07-11');
INSERT INTO `users` VALUES ('16', 'francoliptak@gmail.com', '$2b$08$l0N8mTSgx47d/zGcePcPY.k.l15BcgSSGk1b4zhuSH4soPH1dt4sO', 'Franco', 'Liptak', '1996-04-01 00:00:00.000000', '0', '789456123456789456', '11', '2029', '123', null, '0', '2019-07-11', 'VISA', '2019-07-11');

-- ----------------------------
-- Table structure for weeks
-- ----------------------------
DROP TABLE IF EXISTS `weeks`;
CREATE TABLE `weeks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idProperty` int(11) NOT NULL,
  `date` date NOT NULL,
  `auction` tinyint(1) NOT NULL DEFAULT '0',
  `reserved` tinyint(1) NOT NULL DEFAULT '0',
  `idle` tinyint(1) NOT NULL DEFAULT '0',
  `auctionDate` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=602 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records of weeks
-- ----------------------------
INSERT INTO `weeks` VALUES ('275', '6', '2019-06-23', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('276', '6', '2019-06-30', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('277', '6', '2019-07-07', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('278', '6', '2019-07-14', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('279', '6', '2019-07-21', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('280', '6', '2019-07-28', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('281', '6', '2019-08-04', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('282', '6', '2019-08-11', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('283', '6', '2019-08-18', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('284', '6', '2019-08-25', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('285', '6', '2019-09-01', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('286', '6', '2019-09-08', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('287', '6', '2019-09-15', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('288', '6', '2019-09-22', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('289', '6', '2019-09-29', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('290', '6', '2019-10-06', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('291', '6', '2019-10-13', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('292', '6', '2019-10-20', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('293', '6', '2019-10-27', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('294', '6', '2019-11-03', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('295', '6', '2019-11-10', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('296', '6', '2019-11-17', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('297', '6', '2019-11-24', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('298', '6', '2019-12-01', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('299', '6', '2019-12-08', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('300', '6', '2019-12-15', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('301', '6', '2019-12-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('302', '6', '2019-12-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('303', '6', '2020-01-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('304', '6', '2020-01-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('305', '6', '2020-01-19', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('306', '6', '2020-01-26', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('307', '6', '2020-02-02', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('308', '6', '2020-02-09', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('309', '6', '2020-02-16', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('310', '6', '2020-02-23', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('311', '6', '2020-03-01', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('312', '6', '2020-03-08', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('313', '6', '2020-03-15', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('314', '6', '2020-03-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('315', '6', '2020-03-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('316', '6', '2020-04-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('317', '6', '2020-04-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('318', '6', '2020-04-19', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('319', '6', '2020-04-26', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('320', '6', '2020-05-03', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('321', '6', '2020-05-10', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('322', '6', '2020-05-17', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('323', '6', '2020-05-24', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('324', '6', '2020-05-31', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('325', '6', '2020-06-07', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('326', '6', '2020-06-14', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('327', '6', '2020-06-21', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('328', '7', '2019-06-23', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('329', '7', '2019-06-30', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('330', '7', '2019-07-07', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('331', '7', '2019-07-14', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('332', '7', '2019-07-21', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('333', '7', '2019-07-28', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('334', '7', '2019-08-04', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('335', '7', '2019-08-11', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('336', '7', '2019-08-18', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('337', '7', '2019-08-25', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('338', '7', '2019-09-01', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('339', '7', '2019-09-08', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('340', '7', '2019-09-15', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('341', '7', '2019-09-22', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('342', '7', '2019-09-29', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('343', '7', '2019-10-06', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('344', '7', '2019-10-13', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('345', '7', '2019-10-20', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('346', '7', '2019-10-27', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('347', '7', '2019-11-03', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('348', '7', '2019-11-10', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('349', '7', '2019-11-17', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('350', '7', '2019-11-24', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('351', '7', '2019-12-01', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('352', '7', '2019-12-08', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('353', '7', '2019-12-15', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('354', '7', '2019-12-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('355', '7', '2019-12-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('356', '7', '2020-01-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('357', '7', '2020-01-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('358', '7', '2020-01-19', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('359', '7', '2020-01-26', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('360', '7', '2020-02-02', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('361', '7', '2020-02-09', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('362', '7', '2020-02-16', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('363', '7', '2020-02-23', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('364', '7', '2020-03-01', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('365', '7', '2020-03-08', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('366', '7', '2020-03-15', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('367', '7', '2020-03-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('368', '7', '2020-03-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('369', '7', '2020-04-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('370', '7', '2020-04-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('371', '7', '2020-04-19', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('372', '7', '2020-04-26', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('373', '7', '2020-05-03', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('374', '7', '2020-05-10', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('375', '7', '2020-05-17', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('376', '7', '2020-05-24', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('377', '7', '2020-05-31', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('378', '7', '2020-06-07', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('379', '7', '2020-06-14', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('380', '7', '2020-06-21', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('381', '8', '2019-06-23', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('382', '8', '2019-06-30', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('383', '8', '2019-07-07', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('384', '8', '2019-07-14', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('385', '8', '2019-07-21', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('386', '8', '2019-07-28', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('387', '8', '2019-08-04', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('388', '8', '2019-08-11', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('389', '8', '2019-08-18', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('390', '8', '2019-08-25', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('391', '8', '2019-09-01', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('392', '8', '2019-09-08', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('393', '8', '2019-09-15', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('394', '8', '2019-09-22', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('395', '8', '2019-09-29', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('396', '8', '2019-10-06', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('397', '8', '2019-10-13', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('398', '8', '2019-10-20', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('399', '8', '2019-10-27', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('400', '8', '2019-11-03', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('401', '8', '2019-11-10', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('402', '8', '2019-11-17', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('403', '8', '2019-11-24', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('404', '8', '2019-12-01', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('405', '8', '2019-12-08', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('406', '8', '2019-12-15', '1', '0', '0', '2019-06-21');
INSERT INTO `weeks` VALUES ('407', '8', '2019-12-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('408', '8', '2019-12-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('409', '8', '2020-01-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('410', '8', '2020-01-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('411', '8', '2020-01-19', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('412', '8', '2020-01-26', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('413', '8', '2020-02-02', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('414', '8', '2020-02-09', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('415', '8', '2020-02-16', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('416', '8', '2020-02-23', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('417', '8', '2020-03-01', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('418', '8', '2020-03-08', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('419', '8', '2020-03-15', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('420', '8', '2020-03-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('421', '8', '2020-03-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('422', '8', '2020-04-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('423', '8', '2020-04-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('424', '8', '2020-04-19', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('425', '8', '2020-04-26', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('426', '8', '2020-05-03', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('427', '8', '2020-05-10', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('428', '8', '2020-05-17', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('429', '8', '2020-05-24', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('430', '8', '2020-05-31', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('431', '8', '2020-06-07', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('432', '8', '2020-06-14', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('433', '8', '2020-06-21', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('434', '6', '2020-06-28', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('435', '6', '2020-07-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('436', '6', '2020-07-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('437', '7', '2020-06-28', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('438', '7', '2020-07-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('439', '7', '2020-07-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('440', '8', '2020-06-28', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('441', '8', '2020-07-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('442', '8', '2020-07-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('443', '9', '2019-07-14', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('444', '9', '2019-07-21', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('445', '9', '2019-07-28', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('446', '9', '2019-08-04', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('447', '9', '2019-08-11', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('448', '9', '2019-08-18', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('449', '9', '2019-08-25', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('450', '9', '2019-09-01', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('451', '9', '2019-09-08', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('452', '9', '2019-09-15', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('453', '9', '2019-09-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('454', '9', '2019-09-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('455', '9', '2019-10-06', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('456', '9', '2019-10-13', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('457', '9', '2019-10-20', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('458', '9', '2019-10-27', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('459', '9', '2019-11-03', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('460', '9', '2019-11-10', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('461', '9', '2019-11-17', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('462', '9', '2019-11-24', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('463', '9', '2019-12-01', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('464', '9', '2019-12-08', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('465', '9', '2019-12-15', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('466', '9', '2019-12-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('467', '9', '2019-12-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('468', '9', '2020-01-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('469', '9', '2020-01-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('470', '9', '2020-01-19', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('471', '9', '2020-01-26', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('472', '9', '2020-02-02', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('473', '9', '2020-02-09', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('474', '9', '2020-02-16', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('475', '9', '2020-02-23', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('476', '9', '2020-03-01', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('477', '9', '2020-03-08', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('478', '9', '2020-03-15', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('479', '9', '2020-03-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('480', '9', '2020-03-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('481', '9', '2020-04-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('482', '9', '2020-04-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('483', '9', '2020-04-19', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('484', '9', '2020-04-26', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('485', '9', '2020-05-03', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('486', '9', '2020-05-10', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('487', '9', '2020-05-17', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('488', '9', '2020-05-24', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('489', '9', '2020-05-31', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('490', '9', '2020-06-07', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('491', '9', '2020-06-14', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('492', '9', '2020-06-21', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('493', '9', '2020-06-28', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('494', '9', '2020-07-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('495', '9', '2020-07-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('496', '10', '2019-07-14', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('497', '10', '2019-07-21', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('498', '10', '2019-07-28', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('499', '10', '2019-08-04', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('500', '10', '2019-08-11', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('501', '10', '2019-08-18', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('502', '10', '2019-08-25', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('503', '10', '2019-09-01', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('504', '10', '2019-09-08', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('505', '10', '2019-09-15', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('506', '10', '2019-09-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('507', '10', '2019-09-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('508', '10', '2019-10-06', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('509', '10', '2019-10-13', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('510', '10', '2019-10-20', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('511', '10', '2019-10-27', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('512', '10', '2019-11-03', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('513', '10', '2019-11-10', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('514', '10', '2019-11-17', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('515', '10', '2019-11-24', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('516', '10', '2019-12-01', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('517', '10', '2019-12-08', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('518', '10', '2019-12-15', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('519', '10', '2019-12-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('520', '10', '2019-12-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('521', '10', '2020-01-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('522', '10', '2020-01-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('523', '10', '2020-01-19', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('524', '10', '2020-01-26', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('525', '10', '2020-02-02', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('526', '10', '2020-02-09', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('527', '10', '2020-02-16', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('528', '10', '2020-02-23', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('529', '10', '2020-03-01', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('530', '10', '2020-03-08', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('531', '10', '2020-03-15', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('532', '10', '2020-03-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('533', '10', '2020-03-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('534', '10', '2020-04-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('535', '10', '2020-04-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('536', '10', '2020-04-19', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('537', '10', '2020-04-26', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('538', '10', '2020-05-03', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('539', '10', '2020-05-10', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('540', '10', '2020-05-17', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('541', '10', '2020-05-24', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('542', '10', '2020-05-31', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('543', '10', '2020-06-07', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('544', '10', '2020-06-14', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('545', '10', '2020-06-21', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('546', '10', '2020-06-28', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('547', '10', '2020-07-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('548', '10', '2020-07-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('549', '11', '2019-07-14', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('550', '11', '2019-07-21', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('551', '11', '2019-07-28', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('552', '11', '2019-08-04', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('553', '11', '2019-08-11', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('554', '11', '2019-08-18', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('555', '11', '2019-08-25', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('556', '11', '2019-09-01', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('557', '11', '2019-09-08', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('558', '11', '2019-09-15', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('559', '11', '2019-09-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('560', '11', '2019-09-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('561', '11', '2019-10-06', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('562', '11', '2019-10-13', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('563', '11', '2019-10-20', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('564', '11', '2019-10-27', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('565', '11', '2019-11-03', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('566', '11', '2019-11-10', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('567', '11', '2019-11-17', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('568', '11', '2019-11-24', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('569', '11', '2019-12-01', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('570', '11', '2019-12-08', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('571', '11', '2019-12-15', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('572', '11', '2019-12-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('573', '11', '2019-12-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('574', '11', '2020-01-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('575', '11', '2020-01-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('576', '11', '2020-01-19', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('577', '11', '2020-01-26', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('578', '11', '2020-02-02', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('579', '11', '2020-02-09', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('580', '11', '2020-02-16', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('581', '11', '2020-02-23', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('582', '11', '2020-03-01', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('583', '11', '2020-03-08', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('584', '11', '2020-03-15', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('585', '11', '2020-03-22', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('586', '11', '2020-03-29', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('587', '11', '2020-04-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('588', '11', '2020-04-12', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('589', '11', '2020-04-19', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('590', '11', '2020-04-26', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('591', '11', '2020-05-03', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('592', '11', '2020-05-10', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('593', '11', '2020-05-17', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('594', '11', '2020-05-24', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('595', '11', '2020-05-31', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('596', '11', '2020-06-07', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('597', '11', '2020-06-14', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('598', '11', '2020-06-21', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('599', '11', '2020-06-28', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('600', '11', '2020-07-05', '0', '0', '0', '1899-12-31');
INSERT INTO `weeks` VALUES ('601', '11', '2020-07-12', '0', '0', '0', '1899-12-31');
