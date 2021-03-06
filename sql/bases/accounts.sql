-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Сен 01 2017 г., 18:32
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
-- Структура таблицы `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `login` tinytext COLLATE utf8_bin NOT NULL COMMENT 'логин',
  `password` tinytext COLLATE utf8_bin NOT NULL COMMENT 'хэш пароля',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'отображаемое имя',
  `add_date` date NOT NULL COMMENT 'дата начала работы',
  `status` char(1) COLLATE utf8_bin NOT NULL COMMENT 'работает ли, доступен ли',
  `ip` tinytext COLLATE utf8_bin NOT NULL COMMENT 'разрешённые адреса',
  `dynamic` text COLLATE utf8_bin NOT NULL COMMENT 'динамические поля',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со списком пользователей';

--
-- Дамп данных таблицы `accounts`
--

INSERT INTO `accounts` (`id`, `login`, `password`, `value`, `add_date`, `status`, `ip`, `dynamic`, `uid`, `upd`) VALUES
(1, 'mlsf', '102e5a75eb5c41149c752ca433a0e938', 'Миша Е', '2014-04-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:8:"Шлюз";}', 0, '2015-02-02 06:47:21'),
(2, 'aspr', 'a6f9e6b1fb306e8f0c015793b9e458f6', 'Алёна', '2014-04-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:8:"Шлюз";}', 0, '2015-02-02 06:34:02'),
(3, 'nmkr', '3b263730e3a32fe6b7463d980fd76ec5', 'Наташа М', '2014-04-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:8:"Шлюз";}', 0, '2015-02-02 06:29:30'),
(4, 'novs', '84f675004d9a55516ce44a939ecf7ac7', 'Николай О', '2014-04-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:8:"Шлюз";}', 1, '2014-05-20 09:28:48'),
(5, 'imld', '62d208149f8175e56fc89c09c275b1a7', 'Игорь', '2014-04-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:8:"Шлюз";}', 1, '2014-05-20 09:28:48'),
(6, 'mprs', 'b6872cf83e1ae3bc47bd092bd6e2a723', 'Михаил П', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:8:"Шлюз";}', 1, '2015-02-01 04:25:03'),
(7, 'kzbz', '310c958cf48ff404aaba843d1081a480', 'Кристина З', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:10:"Город";}', 0, '2015-02-01 05:56:57'),
(8, 'vsht', '19be5a73b0c9a992ed07a4579f32171c', 'Валерия Ш', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:10:"Город";}', 0, '2015-02-01 05:58:10'),
(9, 'npch', 'fb86e89eea0b57c27db6ef3e4da7841f', 'Наташа П', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:10:"Город";}', 0, '2015-02-01 06:01:27'),
(10, 'estl', 'd59541f61739718e74f912ac4db03250', 'Евгений С', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:8:"Шлюз";}', 0, '2015-02-01 06:01:16'),
(11, 'ozmt', '0860a0b24140b8417b82d0b2aadb5109', 'Олеся З', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:10:"Город";}', 0, '2015-02-01 06:03:21'),
(12, 'aykn', 'f95374aebd93a8c813b585410a798d26', 'Аня Я', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:12:"Бердск";}', 0, '2015-02-01 06:03:14'),
(13, 'vbnk', '18e2ae9faf692ad3fa61ee49d6972159', 'Валерий Б', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:8:"Шлюз";}', 0, '2015-02-01 06:04:32'),
(14, 'iblv', '51a88e77ebab9aa3e5502f2280f39653', 'Ирина Б', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:2:"Щ";}', 0, '2015-02-01 06:05:36'),
(15, 'ishb', '03e9fe60f44572e65141c9c663a02dfe', 'Ирина Ш', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:2:"Щ";}', 0, '2015-02-01 06:06:35'),
(16, 'nlsv', '26208ea05bf170588adaf755f41867e4', 'Наташа Л', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:10:"Город";}', 0, '2015-02-01 06:07:31'),
(17, 'osgn', '2a3554dbe5e3c323844d59c08063aefb', 'Оксана С', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:10:"Город";}', 0, '2015-02-01 06:08:29'),
(18, 'vmsk', 'f5c2ab0d672f25b9cf4dbe6df6c1c6c9', 'Владимир М', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:8:"Шлюз";}', 0, '2015-02-01 06:09:17'),
(19, 'asbl', 'fe25b6768a886321357ceec4dc959e1f', 'Александра С', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:10:"Город";}', 0, '2015-02-02 06:42:10'),
(20, 'sbnd', 'fe5ae4da273f5abf2b8281c3c66120fb', 'Светлана Р', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:8:"Шлюз";}', 0, '2015-02-01 06:11:01'),
(21, 'astg', '4ce7d607450d950d0d9f369ed65544b6', 'Андрей С', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:12:"Бердск";}', 0, '2015-02-01 06:11:42'),
(22, 'tttv', 'c587a9527070898efd22f79a62606071', 'Татьяна Т', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:26:"Академгородок";}', 0, '2015-02-01 06:12:54'),
(23, 'ikzn', 'f303d682aa5f725cea78af66782d70ce', 'Ирина К', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:2:"Щ";}', 0, '2015-02-01 06:13:41'),
(24, 'emln', 'f1daa9f4d718d8e5c985e18703d83367', 'Екатерина М', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:8:"Шлюз";}', 0, '2015-02-01 06:15:43'),
(25, 'dbkl', 'eaadce26858b0d314aae8981e7f0f1b3', 'Дмитрий Б', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:2:"Щ";}', 0, '2015-02-01 06:16:57'),
(26, 'mzvd', '8425092161d705e9f35845b0e48e94eb', 'Михаил З', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:12:"Бердск";}', 0, '2015-02-01 06:18:00'),
(27, 'vttr', 'c500a247d5ed4cc4b706d6763c948dec', 'Виктор Т', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:10:"Город";}', 0, '2015-02-01 06:19:19'),
(28, 'yphl', '83d3f916809769dd89e96a7e76bc3c6a', 'Юрий П', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:9:"Undefined";}', 0, '2015-02-01 06:20:56'),
(29, 'dobr', '9e42710682103540a2a38d5b254013da', 'Дмитрий О', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:12:"Бердск";}', 0, '2015-02-01 06:21:45'),
(30, 'idmt', 'b1a9bcbe38b69dca30dbf645945de4ea', 'Ирина Д', '2015-02-01', '3', '*.*.*.*', 'a:1:{s:5:"adres";s:8:"Шлюз";}', 0, '2015-02-01 06:22:38');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи',AUTO_INCREMENT=31;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
