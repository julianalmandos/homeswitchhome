/*
 Navicat Premium Data Transfer

 Source Server         : Local
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost:3306
 Source Schema         : hsh

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 16/05/2019 02:20:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bids
-- ----------------------------
DROP TABLE IF EXISTS `bids`;
CREATE TABLE `bids`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(10, 2) NOT NULL,
  `idWeek` decimal(10, 2) NOT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cities
-- ----------------------------
DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for countries
-- ----------------------------
DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idProperty` decimal(10, 2) NOT NULL,
  `image` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for localities
-- ----------------------------
DROP TABLE IF EXISTS `localities`;
CREATE TABLE `localities`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for properties
-- ----------------------------
DROP TABLE IF EXISTS `properties`;
CREATE TABLE `properties`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `base_price` decimal(10, 2) NOT NULL,
  `country` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `province` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `locality` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of properties
-- ----------------------------
INSERT INTO `properties` VALUES (1, 'Casa de Oriana', 'asd', '500 N°16122', 1234.00, 'asd', 'fds', 'fds');
INSERT INTO `properties` VALUES (2, 'Casa de Julián', 'Casa sin patio', '44 N°1062', 1235.00, 'asd', 'fds', 'fds');
INSERT INTO `properties` VALUES (3, 'Casa de Cande', 'Casa de cande', '477 N°2696', 1236.00, 'asd', 'fds', 'fds');
INSERT INTO `properties` VALUES (4, 'Casa de Nico', 'Casa en berisso', '540 N°1622', 1237.00, 'asd', 'fds', 'fds');
INSERT INTO `properties` VALUES (5, 'Casa de Tomi', 'Casa en la plata', '506 N°1122', 1238.00, 'asd', 'fds', 'fds');
INSERT INTO `properties` VALUES (6, 'Casa de Mauri', 'Casa grande', '5120 N°162', 1239.00, 'asd', 'fds', 'fds');

-- ----------------------------
-- Table structure for provinces
-- ----------------------------
DROP TABLE IF EXISTS `provinces`;
CREATE TABLE `provinces`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `name` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `surname` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `birthday` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'asd@hotmail.com', 'nada', 'Julian Luis', 'Almandos', '1998-07-08 17:32:28.000000');
INSERT INTO `users` VALUES (2, 'asd@gmail.com', '$2b$08$nFjhtVM/g.wLDqlA/oVU6eUQFsXGtjK000nNTqJWw/TYjCMTcNPCS', 'asd', 'asd', NULL);
INSERT INTO `users` VALUES (3, 'asdasd@yopmail.com', '$2b$08$3f9dV9SRPsuoLA9k5rB1p.uheJCCyPFk6zNpTfu05FHASramgaOke', 'asd', 'asd', NULL);
INSERT INTO `users` VALUES (4, 'yonose@gmail.com', '$2b$08$BgGjBWZCcNyiLn7tqpm4Uejrq5MgMo6c9PTsfI7oKCGu1/6s8oMja', 'Oriana', 'Arevalos', NULL);
INSERT INTO `users` VALUES (5, 'yonose@gmail.com', '$2b$08$PiNJBsBTThg/lbArKMTc9egmQkCv2rCickWqQ.1kGoHHTkI9MecSC', 'Oriana', 'Arevalos', NULL);
INSERT INTO `users` VALUES (6, 'yonose@gmail.com', '$2b$08$fJzd7r9vhffn..J7BJ4w2.OQNhD3OWlnAGQFN1F1wukWOVW/EoGoy', 'Oriana', 'Arevalos', NULL);
INSERT INTO `users` VALUES (7, 'yonose@gmail.com', '$2b$08$hXsjgznh2yE8VfShr09k1.H5Pp1tyi9l5/88./KmIZuRcGjqlYhz.', 'Oriana', 'Arevalos', NULL);
INSERT INTO `users` VALUES (8, 'yonose@gmail.com', '$2b$08$q31ZVpMQArz6y5CD.pFPDuZDbV.XkhO31vIAGAHUB6tPnCFV/7p4u', 'Oriana', 'Arevalos', NULL);
INSERT INTO `users` VALUES (9, 'yonose@gmail.com', '$2b$08$MGeDhcAi.doH4qEUeJtnGunLSbmXpCbvMVyW2hSrVkjNzN8Go0x1C', 'Oriana', 'Arevalos', NULL);
INSERT INTO `users` VALUES (10, 'yonose@gmail.com', '$2b$08$k9SWwL8BOra0aop9ypaZA.444ak8NxcrmEH6NoDap1j9zXsn1mdqy', 'Oriana', 'Arevalos', NULL);

-- ----------------------------
-- Table structure for weeks
-- ----------------------------
DROP TABLE IF EXISTS `weeks`;
CREATE TABLE `weeks`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idProperty` int(11) NOT NULL,
  `date` date NOT NULL,
  `auction` tinyint(1) NOT NULL DEFAULT 0,
  `reserved` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of weeks
-- ----------------------------
INSERT INTO `weeks` VALUES (1, 1, '2019-05-24', 1, 0);

SET FOREIGN_KEY_CHECKS = 1;
