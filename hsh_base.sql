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

 Date: 04/05/2019 16:46:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ciudades
-- ----------------------------
DROP TABLE IF EXISTS `ciudades`;
CREATE TABLE `ciudades`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for paises
-- ----------------------------
DROP TABLE IF EXISTS `paises`;
CREATE TABLE `paises`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for propiedades
-- ----------------------------
DROP TABLE IF EXISTS `propiedades`;
CREATE TABLE `propiedades`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `address` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `base_price` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for provincias
-- ----------------------------
DROP TABLE IF EXISTS `provincias`;
CREATE TABLE `provincias`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `name` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `surname` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `birthday` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuarios
-- ----------------------------
INSERT INTO `usuarios` VALUES (1, 'asd@hotmail.com', 'nada', 'Julian Luis', 'Almandos', '1998-07-08 17:32:28.000000');
INSERT INTO `usuarios` VALUES (2, 'asd@gmail.com', '$2b$08$nFjhtVM/g.wLDqlA/oVU6eUQFsXGtjK000nNTqJWw/TYjCMTcNPCS', 'asd', 'asd', NULL);
INSERT INTO `usuarios` VALUES (3, 'asdasd@yopmail.com', '$2b$08$3f9dV9SRPsuoLA9k5rB1p.uheJCCyPFk6zNpTfu05FHASramgaOke', 'asd', 'asd', NULL);
INSERT INTO `usuarios` VALUES (4, 'yonose@gmail.com', '$2b$08$BgGjBWZCcNyiLn7tqpm4Uejrq5MgMo6c9PTsfI7oKCGu1/6s8oMja', 'Oriana', 'Arevalos', NULL);
INSERT INTO `usuarios` VALUES (5, 'yonose@gmail.com', '$2b$08$PiNJBsBTThg/lbArKMTc9egmQkCv2rCickWqQ.1kGoHHTkI9MecSC', 'Oriana', 'Arevalos', NULL);
INSERT INTO `usuarios` VALUES (6, 'yonose@gmail.com', '$2b$08$fJzd7r9vhffn..J7BJ4w2.OQNhD3OWlnAGQFN1F1wukWOVW/EoGoy', 'Oriana', 'Arevalos', NULL);
INSERT INTO `usuarios` VALUES (7, 'yonose@gmail.com', '$2b$08$hXsjgznh2yE8VfShr09k1.H5Pp1tyi9l5/88./KmIZuRcGjqlYhz.', 'Oriana', 'Arevalos', NULL);
INSERT INTO `usuarios` VALUES (8, 'yonose@gmail.com', '$2b$08$q31ZVpMQArz6y5CD.pFPDuZDbV.XkhO31vIAGAHUB6tPnCFV/7p4u', 'Oriana', 'Arevalos', NULL);
INSERT INTO `usuarios` VALUES (9, 'yonose@gmail.com', '$2b$08$MGeDhcAi.doH4qEUeJtnGunLSbmXpCbvMVyW2hSrVkjNzN8Go0x1C', 'Oriana', 'Arevalos', NULL);
INSERT INTO `usuarios` VALUES (10, 'yonose@gmail.com', '$2b$08$k9SWwL8BOra0aop9ypaZA.444ak8NxcrmEH6NoDap1j9zXsn1mdqy', 'Oriana', 'Arevalos', NULL);

SET FOREIGN_KEY_CHECKS = 1;
