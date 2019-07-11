-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 11-07-2019 a las 15:17:23
-- Versión del servidor: 10.1.37-MariaDB
-- Versión de PHP: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `hsh`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bids`
--

CREATE TABLE `bids` (
  `id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `idWeek` int(11) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `bids`
--

INSERT INTO `bids` (`id`, `price`, `idWeek`, `email`) VALUES
(20, '130001.00', 382, 'orianarevalos@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `idMaxBId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `countries`
--

CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `idProperty` int(11) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `images`
--

INSERT INTO `images` (`id`, `idProperty`, `image`) VALUES
(127, 6, 'https://st3.idealista.com/news/archivos/styles/news_detail/public/2018-11/casa_prefabricada.jpg?sv=pX_Hqy9d&itok=kCOtbqgQ'),
(128, 7, 'https://i.pinimg.com/originals/11/2c/2d/112c2d46206b19be8ae926b2f7fdce19.jpg'),
(129, 8, 'https://i.pinimg.com/originals/11/2c/2d/112c2d46206b19be8ae926b2f7fdce19.jpg'),
(130, 9, 'https://st3.idealista.com/news/archivos/styles/news_detail/public/2018-11/casa_prefabricada.jpg?sv=pX_Hqy9d&itok=kCOtbqgQ'),
(131, 10, 'https://st3.idealista.com/news/archivos/styles/news_detail/public/2018-11/casa_prefabricada.jpg?sv=pX_Hqy9d&itok=kCOtbqgQ'),
(132, 11, 'https://st3.idealista.com/news/archivos/styles/news_detail/public/2018-11/casa_prefabricada.jpg?sv=pX_Hqy9d&itok=kCOtbqgQ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localities`
--

CREATE TABLE `localities` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `normal_requests`
--

CREATE TABLE `normal_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `accepted` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `normal_requests`
--

INSERT INTO `normal_requests` (`id`, `user_id`, `comment`, `accepted`) VALUES
(1, 14, 'Porque quiero', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `premium_requests`
--

CREATE TABLE `premium_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `accepted` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `premium_requests`
--

INSERT INTO `premium_requests` (`id`, `user_id`, `comment`, `accepted`) VALUES
(2, 14, '', 1),
(3, 15, 'Porque si', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `country` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `locality` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `properties`
--

INSERT INTO `properties` (`id`, `name`, `description`, `address`, `base_price`, `country`, `province`, `locality`) VALUES
(6, 'Casa de Oriana', 'asdasd', 'asdasd', '123000.00', 'Argentina', 'Buenos Aires', 'La Plata'),
(7, 'Casa de Candela', 'asdasd', 'asdasd', '130000.00', 'Argentina', 'Buenos Aires', 'La Plata'),
(8, 'Casa de Oriana', 'asdasd', 'asdasd', '130000.00', 'Argentina', 'La Pampa', 'La Plata'),
(9, 'asdasdsad', 'asdas', 'asdasda', '5000000.00', 'asdasd', 'asdasd', 'asdasd'),
(10, 'jkhkjh', 'kjhkjhkjh', 'kjhkjhkj', '12312332.00', 'kjhjkhkjh', 'kjhkjhkjh', 'kjhkkjkjh'),
(11, 'oiuoiuoi', 'uoiuoiu', 'oiuoiuoiu', '99999999.99', 'lkjlkjlk', 'jkljlkjlkj', 'lkjlkjlkjlk');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provinces`
--

CREATE TABLE `provinces` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
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
  `last_charge` date NOT NULL,
  `card_type` varchar(255) NOT NULL,
  `register_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `name`, `surname`, `birthday`, `role`, `card_number`, `card_expiration_month`, `card_expiration_year`, `card_security_number`, `recover_password_token`, `credits`, `last_charge`, `card_type`, `register_date`) VALUES
(12, 'julianalmandos@gmail.com', '$2b$08$p5Yb5aWgr4Dl7Ck7N8iB1.y1hIM6ZaPd6I/YpM4MEIQMV.7.qAnme', 'Julian', 'Almandos', '1998-07-08 00:00:00.000000', 2, '458562697852645963', 12, 2029, '123', '', 0, '0000-00-00', 'VISA', '0000-00-00'),
(14, 'orianarevalos@gmail.com', '$2b$08$GhtkpcWaQm9XWPoWzAJtQORX23C0HMdMNHX7LpFY8fvlK2gDlsRPi', 'Oriana', 'Arevalos', '1998-07-08 00:00:00.000000', 2, '123123123123123123', 10, 2020, '123', NULL, 0, '0000-00-00', 'VISA', '0000-00-00'),
(15, 'candelamrouaux@gmail.com', '$2b$08$OACoSQVY62P9Mxs3X3MQM.gT8QW9ALKEhSNGkTmElVbldv1JN11iG', 'Candela', 'Rouaux', '1998-07-08 00:00:00.000000', 1, '123123123123123123', 11, 2028, '123', NULL, 0, '0000-00-00', 'VISA', '0000-00-00'),
(16, 'francoliptak@gmail.com', '$2b$08$l0N8mTSgx47d/zGcePcPY.k.l15BcgSSGk1b4zhuSH4soPH1dt4sO', 'Franco', 'Liptak', '1996-04-01 00:00:00.000000', 2, '789456123456789456', 11, 2029, '123', NULL, 0, '0000-00-00', 'VISA', '0000-00-00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `weeks`
--

CREATE TABLE `weeks` (
  `id` int(11) NOT NULL,
  `idProperty` int(11) NOT NULL,
  `date` date NOT NULL,
  `auction` tinyint(1) NOT NULL DEFAULT '0',
  `reserved` tinyint(1) NOT NULL DEFAULT '0',
  `idle` tinyint(1) NOT NULL DEFAULT '0',
  `auctionDate` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

--
-- Volcado de datos para la tabla `weeks`
--

INSERT INTO `weeks` (`id`, `idProperty`, `date`, `auction`, `reserved`, `idle`, `auctionDate`) VALUES
(275, 6, '2019-06-23', 1, 0, 0, '2019-06-21'),
(276, 6, '2019-06-30', 1, 0, 0, '2019-06-21'),
(277, 6, '2019-07-07', 1, 0, 0, '2019-06-21'),
(278, 6, '2019-07-14', 1, 0, 0, '2019-06-21'),
(279, 6, '2019-07-21', 1, 0, 0, '2019-06-21'),
(280, 6, '2019-07-28', 1, 0, 0, '2019-06-21'),
(281, 6, '2019-08-04', 1, 0, 0, '2019-06-21'),
(282, 6, '2019-08-11', 1, 0, 0, '2019-06-21'),
(283, 6, '2019-08-18', 1, 0, 0, '2019-06-21'),
(284, 6, '2019-08-25', 1, 0, 0, '2019-06-21'),
(285, 6, '2019-09-01', 1, 0, 0, '2019-06-21'),
(286, 6, '2019-09-08', 1, 0, 0, '2019-06-21'),
(287, 6, '2019-09-15', 1, 0, 0, '2019-06-21'),
(288, 6, '2019-09-22', 1, 0, 0, '2019-06-21'),
(289, 6, '2019-09-29', 1, 0, 0, '2019-06-21'),
(290, 6, '2019-10-06', 1, 0, 0, '2019-06-21'),
(291, 6, '2019-10-13', 1, 0, 0, '2019-06-21'),
(292, 6, '2019-10-20', 1, 0, 0, '2019-06-21'),
(293, 6, '2019-10-27', 1, 0, 0, '2019-06-21'),
(294, 6, '2019-11-03', 1, 0, 0, '2019-06-21'),
(295, 6, '2019-11-10', 1, 0, 0, '2019-06-21'),
(296, 6, '2019-11-17', 1, 0, 0, '2019-06-21'),
(297, 6, '2019-11-24', 1, 0, 0, '2019-06-21'),
(298, 6, '2019-12-01', 1, 0, 0, '2019-06-21'),
(299, 6, '2019-12-08', 1, 0, 0, '2019-06-21'),
(300, 6, '2019-12-15', 1, 0, 0, '2019-06-21'),
(301, 6, '2019-12-22', 0, 0, 0, '1899-12-31'),
(302, 6, '2019-12-29', 0, 0, 0, '1899-12-31'),
(303, 6, '2020-01-05', 0, 0, 0, '1899-12-31'),
(304, 6, '2020-01-12', 0, 0, 0, '1899-12-31'),
(305, 6, '2020-01-19', 0, 0, 0, '1899-12-31'),
(306, 6, '2020-01-26', 0, 0, 0, '1899-12-31'),
(307, 6, '2020-02-02', 0, 0, 0, '1899-12-31'),
(308, 6, '2020-02-09', 0, 0, 0, '1899-12-31'),
(309, 6, '2020-02-16', 0, 0, 0, '1899-12-31'),
(310, 6, '2020-02-23', 0, 0, 0, '1899-12-31'),
(311, 6, '2020-03-01', 0, 0, 0, '1899-12-31'),
(312, 6, '2020-03-08', 0, 0, 0, '1899-12-31'),
(313, 6, '2020-03-15', 0, 0, 0, '1899-12-31'),
(314, 6, '2020-03-22', 0, 0, 0, '1899-12-31'),
(315, 6, '2020-03-29', 0, 0, 0, '1899-12-31'),
(316, 6, '2020-04-05', 0, 0, 0, '1899-12-31'),
(317, 6, '2020-04-12', 0, 0, 0, '1899-12-31'),
(318, 6, '2020-04-19', 0, 0, 0, '1899-12-31'),
(319, 6, '2020-04-26', 0, 0, 0, '1899-12-31'),
(320, 6, '2020-05-03', 0, 0, 0, '1899-12-31'),
(321, 6, '2020-05-10', 0, 0, 0, '1899-12-31'),
(322, 6, '2020-05-17', 0, 0, 0, '1899-12-31'),
(323, 6, '2020-05-24', 0, 0, 0, '1899-12-31'),
(324, 6, '2020-05-31', 0, 0, 0, '1899-12-31'),
(325, 6, '2020-06-07', 0, 0, 0, '1899-12-31'),
(326, 6, '2020-06-14', 0, 0, 0, '1899-12-31'),
(327, 6, '2020-06-21', 0, 0, 0, '1899-12-31'),
(328, 7, '2019-06-23', 1, 0, 0, '2019-06-21'),
(329, 7, '2019-06-30', 1, 0, 0, '2019-06-21'),
(330, 7, '2019-07-07', 1, 0, 0, '2019-06-21'),
(331, 7, '2019-07-14', 1, 0, 0, '2019-06-21'),
(332, 7, '2019-07-21', 1, 0, 0, '2019-06-21'),
(333, 7, '2019-07-28', 1, 0, 0, '2019-06-21'),
(334, 7, '2019-08-04', 1, 0, 0, '2019-06-21'),
(335, 7, '2019-08-11', 1, 0, 0, '2019-06-21'),
(336, 7, '2019-08-18', 1, 0, 0, '2019-06-21'),
(337, 7, '2019-08-25', 1, 0, 0, '2019-06-21'),
(338, 7, '2019-09-01', 1, 0, 0, '2019-06-21'),
(339, 7, '2019-09-08', 1, 0, 0, '2019-06-21'),
(340, 7, '2019-09-15', 1, 0, 0, '2019-06-21'),
(341, 7, '2019-09-22', 1, 0, 0, '2019-06-21'),
(342, 7, '2019-09-29', 1, 0, 0, '2019-06-21'),
(343, 7, '2019-10-06', 1, 0, 0, '2019-06-21'),
(344, 7, '2019-10-13', 1, 0, 0, '2019-06-21'),
(345, 7, '2019-10-20', 1, 0, 0, '2019-06-21'),
(346, 7, '2019-10-27', 1, 0, 0, '2019-06-21'),
(347, 7, '2019-11-03', 1, 0, 0, '2019-06-21'),
(348, 7, '2019-11-10', 1, 0, 0, '2019-06-21'),
(349, 7, '2019-11-17', 1, 0, 0, '2019-06-21'),
(350, 7, '2019-11-24', 1, 0, 0, '2019-06-21'),
(351, 7, '2019-12-01', 1, 0, 0, '2019-06-21'),
(352, 7, '2019-12-08', 1, 0, 0, '2019-06-21'),
(353, 7, '2019-12-15', 1, 0, 0, '2019-06-21'),
(354, 7, '2019-12-22', 0, 0, 0, '1899-12-31'),
(355, 7, '2019-12-29', 0, 0, 0, '1899-12-31'),
(356, 7, '2020-01-05', 0, 0, 0, '1899-12-31'),
(357, 7, '2020-01-12', 0, 0, 0, '1899-12-31'),
(358, 7, '2020-01-19', 0, 0, 0, '1899-12-31'),
(359, 7, '2020-01-26', 0, 0, 0, '1899-12-31'),
(360, 7, '2020-02-02', 0, 0, 0, '1899-12-31'),
(361, 7, '2020-02-09', 0, 0, 0, '1899-12-31'),
(362, 7, '2020-02-16', 0, 0, 0, '1899-12-31'),
(363, 7, '2020-02-23', 0, 0, 0, '1899-12-31'),
(364, 7, '2020-03-01', 0, 0, 0, '1899-12-31'),
(365, 7, '2020-03-08', 0, 0, 0, '1899-12-31'),
(366, 7, '2020-03-15', 0, 0, 0, '1899-12-31'),
(367, 7, '2020-03-22', 0, 0, 0, '1899-12-31'),
(368, 7, '2020-03-29', 0, 0, 0, '1899-12-31'),
(369, 7, '2020-04-05', 0, 0, 0, '1899-12-31'),
(370, 7, '2020-04-12', 0, 0, 0, '1899-12-31'),
(371, 7, '2020-04-19', 0, 0, 0, '1899-12-31'),
(372, 7, '2020-04-26', 0, 0, 0, '1899-12-31'),
(373, 7, '2020-05-03', 0, 0, 0, '1899-12-31'),
(374, 7, '2020-05-10', 0, 0, 0, '1899-12-31'),
(375, 7, '2020-05-17', 0, 0, 0, '1899-12-31'),
(376, 7, '2020-05-24', 0, 0, 0, '1899-12-31'),
(377, 7, '2020-05-31', 0, 0, 0, '1899-12-31'),
(378, 7, '2020-06-07', 0, 0, 0, '1899-12-31'),
(379, 7, '2020-06-14', 0, 0, 0, '1899-12-31'),
(380, 7, '2020-06-21', 0, 0, 0, '1899-12-31'),
(381, 8, '2019-06-23', 1, 0, 0, '2019-06-21'),
(382, 8, '2019-06-30', 1, 0, 0, '2019-06-21'),
(383, 8, '2019-07-07', 1, 0, 0, '2019-06-21'),
(384, 8, '2019-07-14', 1, 0, 0, '2019-06-21'),
(385, 8, '2019-07-21', 1, 0, 0, '2019-06-21'),
(386, 8, '2019-07-28', 1, 0, 0, '2019-06-21'),
(387, 8, '2019-08-04', 1, 0, 0, '2019-06-21'),
(388, 8, '2019-08-11', 1, 0, 0, '2019-06-21'),
(389, 8, '2019-08-18', 1, 0, 0, '2019-06-21'),
(390, 8, '2019-08-25', 1, 0, 0, '2019-06-21'),
(391, 8, '2019-09-01', 1, 0, 0, '2019-06-21'),
(392, 8, '2019-09-08', 1, 0, 0, '2019-06-21'),
(393, 8, '2019-09-15', 1, 0, 0, '2019-06-21'),
(394, 8, '2019-09-22', 1, 0, 0, '2019-06-21'),
(395, 8, '2019-09-29', 1, 0, 0, '2019-06-21'),
(396, 8, '2019-10-06', 1, 0, 0, '2019-06-21'),
(397, 8, '2019-10-13', 1, 0, 0, '2019-06-21'),
(398, 8, '2019-10-20', 1, 0, 0, '2019-06-21'),
(399, 8, '2019-10-27', 1, 0, 0, '2019-06-21'),
(400, 8, '2019-11-03', 1, 0, 0, '2019-06-21'),
(401, 8, '2019-11-10', 1, 0, 0, '2019-06-21'),
(402, 8, '2019-11-17', 1, 0, 0, '2019-06-21'),
(403, 8, '2019-11-24', 1, 0, 0, '2019-06-21'),
(404, 8, '2019-12-01', 1, 0, 0, '2019-06-21'),
(405, 8, '2019-12-08', 1, 0, 0, '2019-06-21'),
(406, 8, '2019-12-15', 1, 0, 0, '2019-06-21'),
(407, 8, '2019-12-22', 0, 0, 0, '1899-12-31'),
(408, 8, '2019-12-29', 0, 0, 0, '1899-12-31'),
(409, 8, '2020-01-05', 0, 0, 0, '1899-12-31'),
(410, 8, '2020-01-12', 0, 0, 0, '1899-12-31'),
(411, 8, '2020-01-19', 0, 0, 0, '1899-12-31'),
(412, 8, '2020-01-26', 0, 0, 0, '1899-12-31'),
(413, 8, '2020-02-02', 0, 0, 0, '1899-12-31'),
(414, 8, '2020-02-09', 0, 0, 0, '1899-12-31'),
(415, 8, '2020-02-16', 0, 0, 0, '1899-12-31'),
(416, 8, '2020-02-23', 0, 0, 0, '1899-12-31'),
(417, 8, '2020-03-01', 0, 0, 0, '1899-12-31'),
(418, 8, '2020-03-08', 0, 0, 0, '1899-12-31'),
(419, 8, '2020-03-15', 0, 0, 0, '1899-12-31'),
(420, 8, '2020-03-22', 0, 0, 0, '1899-12-31'),
(421, 8, '2020-03-29', 0, 0, 0, '1899-12-31'),
(422, 8, '2020-04-05', 0, 0, 0, '1899-12-31'),
(423, 8, '2020-04-12', 0, 0, 0, '1899-12-31'),
(424, 8, '2020-04-19', 0, 0, 0, '1899-12-31'),
(425, 8, '2020-04-26', 0, 0, 0, '1899-12-31'),
(426, 8, '2020-05-03', 0, 0, 0, '1899-12-31'),
(427, 8, '2020-05-10', 0, 0, 0, '1899-12-31'),
(428, 8, '2020-05-17', 0, 0, 0, '1899-12-31'),
(429, 8, '2020-05-24', 0, 0, 0, '1899-12-31'),
(430, 8, '2020-05-31', 0, 0, 0, '1899-12-31'),
(431, 8, '2020-06-07', 0, 0, 0, '1899-12-31'),
(432, 8, '2020-06-14', 0, 0, 0, '1899-12-31'),
(433, 8, '2020-06-21', 0, 0, 0, '1899-12-31');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bids`
--
ALTER TABLE `bids`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indices de la tabla `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indices de la tabla `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indices de la tabla `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indices de la tabla `localities`
--
ALTER TABLE `localities`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indices de la tabla `normal_requests`
--
ALTER TABLE `normal_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `premium_requests`
--
ALTER TABLE `premium_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `provinces`
--
ALTER TABLE `provinces`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indices de la tabla `weeks`
--
ALTER TABLE `weeks`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bids`
--
ALTER TABLE `bids`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT de la tabla `localities`
--
ALTER TABLE `localities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `normal_requests`
--
ALTER TABLE `normal_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `premium_requests`
--
ALTER TABLE `premium_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `provinces`
--
ALTER TABLE `provinces`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `weeks`
--
ALTER TABLE `weeks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=434;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
