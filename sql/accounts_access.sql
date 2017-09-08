-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Сен 04 2017 г., 15:56
-- Версия сервера: 5.7.11
-- Версия PHP: 5.3.10-1ubuntu3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `gs3_blank`
--

-- --------------------------------------------------------

--
-- Структура таблицы `accounts_access`
--

CREATE TABLE IF NOT EXISTS `accounts_access` (
  `user_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `component_id` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `accounts_access`
--

INSERT INTO `accounts_access` (`user_id`, `module_id`, `component_id`) VALUES
(1, 1, 0),
(1, 2, 0),
(1, 3, 0),
(1, 3, 13),
(1, 3, 14),
(1, 3, 18),
(1, 10, 0),
(1, 10, 7),
(1, 10, 8),
(1, 13, 0),
(1, 14, 0),
(1, 15, 0),
(1, 17, 0),
(1, 21, 0),
(1, 22, 0),
(1, 23, 0),
(1, 30, 0),
(1, 32, 0),
(1, 33, 0),
(1, 34, 0),
(1, 35, 0),
(2, 15, 0),
(2, 21, 0),
(2, 22, 0),
(2, 23, 0),
(2, 30, 0),
(2, 32, 0),
(2, 33, 0),
(2, 35, 0),
(3, 1, 0),
(3, 2, 0),
(3, 3, 0),
(3, 4, 0),
(3, 13, 0),
(3, 15, 0),
(3, 16, 0),
(3, 21, 0),
(3, 22, 0),
(3, 23, 0),
(3, 30, 0),
(3, 32, 0),
(3, 35, 0),
(4, 1, 0),
(4, 2, 0),
(4, 3, 0),
(4, 4, 0),
(4, 10, 0),
(4, 13, 0),
(4, 14, 0),
(4, 15, 0),
(4, 16, 0),
(4, 17, 0),
(4, 21, 0),
(4, 22, 0),
(4, 23, 0),
(4, 30, 0),
(4, 32, 0),
(4, 33, 0),
(4, 34, 0),
(4, 35, 0),
(5, 1, 0),
(5, 2, 0),
(5, 3, 0),
(5, 4, 0),
(5, 10, 0),
(5, 13, 0),
(5, 14, 0),
(5, 15, 0),
(5, 16, 0),
(5, 17, 0),
(5, 21, 0),
(5, 22, 0),
(5, 23, 0),
(5, 30, 0),
(6, 1, 0),
(6, 2, 0),
(6, 3, 0),
(6, 21, 0),
(6, 22, 0),
(6, 32, 0),
(6, 33, 0),
(6, 34, 0),
(6, 35, 0),
(7, 32, 0),
(7, 35, 0),
(8, 32, 0),
(8, 35, 0),
(9, 32, 0),
(9, 35, 0),
(10, 32, 0),
(10, 35, 0),
(11, 32, 0),
(11, 35, 0),
(12, 32, 0),
(12, 35, 0),
(13, 32, 0),
(13, 35, 0),
(14, 32, 0),
(14, 35, 0),
(15, 32, 0),
(15, 35, 0),
(16, 32, 0),
(16, 35, 0),
(17, 32, 0),
(17, 35, 0),
(18, 32, 0),
(18, 35, 0),
(19, 32, 0),
(19, 35, 0),
(20, 32, 0),
(20, 35, 0),
(21, 32, 0),
(21, 35, 0),
(22, 32, 0),
(22, 35, 0),
(23, 32, 0),
(23, 35, 0),
(24, 32, 0),
(24, 35, 0),
(25, 15, 0),
(25, 21, 0),
(25, 22, 0),
(25, 23, 0),
(25, 30, 0),
(25, 32, 0),
(25, 35, 0),
(26, 32, 0),
(26, 35, 0),
(27, 32, 0),
(27, 35, 0),
(28, 32, 0),
(28, 35, 0),
(29, 32, 0),
(29, 35, 0),
(30, 32, 0),
(30, 35, 0),
(31, 15, 0),
(31, 21, 0),
(31, 22, 0);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `accounts_access`
--
ALTER TABLE `accounts_access`
  ADD PRIMARY KEY (`user_id`,`module_id`,`component_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
