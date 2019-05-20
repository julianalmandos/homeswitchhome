-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 20-05-2019 a las 14:33:25
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
(38, 27, 'https://www.mundoflaneur.com/wp-content/uploads/2011/02/Casa-vista-mar-2.jpg'),
(39, 27, 'https://www.elpatio-inmobiliaria.com/wp-content/uploads/2018/11/casa-chalet-vista-mar-9.jpg'),
(40, 27, 'https://www.mundoflaneur.com/wp-content/uploads/2011/02/Casa-vista-mar-5.jpg'),
(41, 28, 'https://s-ec.bstatic.com/images/hotel/max1024x768/100/100376604.jpg'),
(42, 28, 'http://www.cordoba24.info/jugendherbergen/apartamentos_mi_casa_en_cordoba_2.jpg'),
(52, 29, 'https://images.adsttc.com/media/images/58d0/776c/e58e/ce69/fa00/003d/slideshow/dusk79436_2_sm.jpg?1490057061'),
(53, 29, 'https://www.construyehogar.com/wp-content/uploads/2013/09/fachadadecasaenlamontaC3B1a-1.jpg'),
(54, 29, 'https://i.pinimg.com/originals/5e/6e/20/5e6e2005bee5864116b57a62639a37e5.jpg'),
(55, 29, 'https://s-ec.bstatic.com/images/hotel/max1024x768/167/167134709.jpg');

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
(27, 'Casa de Prueba 1', 'Casa con vista al mar, admite mascotas, capacidad para 5 personas.', 'Avenida del Mar N°750', '5000.00', 'Argentina', 'Buenos Aires', 'Pinamar'),
(28, 'Casa de Prueba 2', 'Casa de dos plantas, con piscina al aire libre', 'Avenida Colón N°685', '3500.00', 'Argentina', 'Córdoba', 'Córdoba'),
(29, 'Casa de Prueba 3', 'Casa con vista a la montaña, con Wi-Fi gratuito y estacionamiento', 'Río Grande N°2270', '4750.00', 'Argentina', 'Mendoza', 'Luján de Cuyo');

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
  `role` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `name`, `surname`, `birthday`, `role`) VALUES
(11, 'juan.perez@gmail.com', '$2b$08$4KkzQFDoQW1CG0PL5cv3W.t4ih6v0vkL5MAyTKMikcHomUMYuW8J6', 'Juan', 'Perez', NULL, 2);

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
  `idle` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

--
-- Volcado de datos para la tabla `weeks`
--

INSERT INTO `weeks` (`id`, `idProperty`, `date`, `auction`, `reserved`, `idle`) VALUES
(2, 27, '2019-05-26', 0, 0, 0),
(3, 27, '2019-06-02', 0, 0, 0),
(4, 27, '2019-06-09', 0, 0, 0),
(5, 27, '2019-06-16', 0, 0, 0),
(6, 27, '2019-06-23', 0, 0, 0),
(7, 27, '2019-06-30', 0, 0, 0),
(8, 27, '2019-07-07', 0, 0, 0),
(9, 27, '2019-07-14', 0, 0, 0),
(10, 27, '2019-07-21', 0, 0, 0),
(11, 27, '2019-07-28', 0, 0, 0),
(12, 27, '2019-08-04', 0, 0, 0),
(13, 27, '2019-08-11', 0, 0, 0),
(14, 28, '2019-05-26', 0, 0, 0),
(15, 28, '2019-06-02', 0, 0, 0),
(16, 28, '2019-06-09', 0, 0, 0),
(17, 28, '2019-06-16', 0, 0, 0),
(18, 28, '2019-06-23', 0, 0, 0),
(19, 28, '2019-06-30', 0, 0, 0),
(20, 28, '2019-07-07', 0, 0, 0),
(21, 28, '2019-07-14', 0, 0, 0),
(22, 28, '2019-07-21', 0, 0, 0),
(23, 28, '2019-07-28', 0, 0, 0),
(24, 28, '2019-08-04', 0, 0, 0),
(25, 28, '2019-08-11', 0, 0, 0),
(26, 29, '2019-05-26', 0, 0, 0),
(27, 29, '2019-06-02', 0, 0, 0),
(28, 29, '2019-06-09', 0, 0, 0),
(29, 29, '2019-06-16', 0, 0, 0),
(30, 29, '2019-06-23', 0, 0, 0),
(31, 29, '2019-06-30', 0, 0, 0),
(32, 29, '2019-07-07', 0, 0, 0),
(33, 29, '2019-07-14', 0, 0, 0),
(34, 29, '2019-07-21', 0, 0, 0),
(35, 29, '2019-07-28', 0, 0, 0),
(36, 29, '2019-08-04', 0, 0, 0),
(37, 29, '2019-08-11', 0, 0, 0),
(1, 27, '2019-05-19', 0, 0, 0);

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
-- Indices de la tabla `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`) USING BTREE;

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
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bids`
--
ALTER TABLE `bids`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT de la tabla `localities`
--
ALTER TABLE `localities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `provinces`
--
ALTER TABLE `provinces`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `weeks`
--
ALTER TABLE `weeks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
