-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Сен 01 2017 г., 18:28
-- Версия сервера: 5.7.11
-- Версия PHP: 5.3.10-1ubuntu3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `gs3`
--

-- --------------------------------------------------------

--
-- Структура таблицы `adm_components`
--

CREATE TABLE IF NOT EXISTS `adm_components` (
  `id` int(11) NOT NULL,
  `title` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `addr` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `actions` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `params` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `cron_scripts_state`
--

CREATE TABLE IF NOT EXISTS `cron_scripts_state` (
  `script_name` varchar(100) COLLATE utf8_bin NOT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT '1',
  `lastchange` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `ftpgroup`
--

CREATE TABLE IF NOT EXISTS `ftpgroup` (
  `groupname` varchar(16) NOT NULL DEFAULT '',
  `gid` smallint(6) NOT NULL DEFAULT '2001',
  `members` varchar(16) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='ProFTP group table';

-- --------------------------------------------------------

--
-- Структура таблицы `ftpuser`
--

CREATE TABLE IF NOT EXISTS `ftpuser` (
  `id` int(10) unsigned NOT NULL,
  `userid` varchar(32) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `passwd` varchar(32) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `uid` smallint(6) NOT NULL DEFAULT '2001',
  `gid` smallint(6) NOT NULL DEFAULT '2001',
  `homedir` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `shell` varchar(16) CHARACTER SET latin1 NOT NULL DEFAULT '/sbin/nologin',
  `count` int(11) NOT NULL DEFAULT '0',
  `accessed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `email` varchar(127) CHARACTER SET latin1 NOT NULL,
  `loaded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='ProFTP user table';

-- --------------------------------------------------------

--
-- Структура таблицы `goods_prices`
--

CREATE TABLE IF NOT EXISTS `goods_prices` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `mfg` char(1) COLLATE utf8_bin NOT NULL COMMENT 'выгрузчик',
  `art` tinytext COLLATE utf8_bin NOT NULL COMMENT 'артикул',
  `images` varchar(4000) COLLATE utf8_bin DEFAULT NULL COMMENT 'список картинок поставщика (hashes ONLY)',
  `price_xindao` int(11) NOT NULL DEFAULT '0',
  `price_xindao_` timestamp NULL DEFAULT NULL,
  `price_eje_initial` int(11) NOT NULL DEFAULT '0',
  `price_eje_initial_` timestamp NULL DEFAULT NULL,
  `price_eje_final` int(11) NOT NULL DEFAULT '0',
  `price_eje_final_` timestamp NULL DEFAULT NULL,
  `price_ebazaar` int(11) NOT NULL DEFAULT '0',
  `price_ebazaar_` timestamp NULL DEFAULT NULL,
  `price_oasis` int(11) NOT NULL DEFAULT '0',
  `price_oasis_` timestamp NULL DEFAULT NULL,
  `price_ocean` int(11) NOT NULL DEFAULT '0',
  `price_ocean_` timestamp NULL DEFAULT NULL,
  `price_happy` int(11) NOT NULL DEFAULT '0',
  `price_happy_` timestamp NULL DEFAULT NULL,
  `price_project111` int(11) NOT NULL DEFAULT '0',
  `price_project111_` timestamp NULL DEFAULT NULL,
  `price_midocean` int(11) NOT NULL DEFAULT '0',
  `price_midocean_` timestamp NULL DEFAULT NULL,
  `price_cuty_sup` int(11) NOT NULL DEFAULT '0',
  `price_cuty_sup_` timestamp NULL DEFAULT NULL,
  `price_cuty_in` int(11) NOT NULL DEFAULT '0',
  `price_cuty_in_` timestamp NULL DEFAULT NULL,
  `price_cuty_opt` int(11) NOT NULL DEFAULT '0',
  `price_cuty_opt_` timestamp NULL DEFAULT NULL,
  `price_cuty_ret` int(11) NOT NULL DEFAULT '0',
  `price_cuty_ret_` timestamp NULL DEFAULT NULL,
  `price_eklektika_main` int(11) NOT NULL DEFAULT '0',
  `price_eklektika_main_` timestamp NULL DEFAULT NULL,
  `price_eklektika_adv` int(11) NOT NULL DEFAULT '0',
  `price_eklektika_adv_` timestamp NULL DEFAULT NULL,
  `stock_xindao_eur` int(11) NOT NULL DEFAULT '0',
  `stock_xindao_eur_` timestamp NULL DEFAULT NULL,
  `stock_xindao_moscow` int(11) NOT NULL DEFAULT '0',
  `stock_xindao_moscow_` datetime DEFAULT NULL,
  `stock_xindao_moscow_avail` int(11) NOT NULL DEFAULT '0',
  `stock_xindao_moscow_avail_` timestamp NULL DEFAULT NULL,
  `stock_eje_stock` int(11) NOT NULL DEFAULT '0',
  `stock_eje_stock_` timestamp NULL DEFAULT NULL,
  `stock_eje_warehouse` int(11) NOT NULL DEFAULT '0',
  `stock_eje_warehouse_` timestamp NULL DEFAULT NULL,
  `stock_eje_delivery` int(11) NOT NULL DEFAULT '0',
  `stock_eje_delivery_` timestamp NULL DEFAULT NULL,
  `stock_ebazaar1` int(11) NOT NULL DEFAULT '0',
  `stock_ebazaar1_` timestamp NULL DEFAULT NULL,
  `stock_ebazaar2` int(11) NOT NULL DEFAULT '0',
  `stock_ebazaar2_` timestamp NULL DEFAULT NULL,
  `stock_oasis_sklad` int(11) NOT NULL DEFAULT '0',
  `stock_oasis_sklad_` timestamp NULL DEFAULT NULL,
  `stock_oasis_rez` int(11) NOT NULL DEFAULT '0',
  `stock_oasis_rez_` timestamp NULL DEFAULT NULL,
  `stock_ocean_total` int(11) NOT NULL DEFAULT '0',
  `stock_ocean_total_` timestamp NULL DEFAULT NULL,
  `stock_ocean_ns` int(11) NOT NULL DEFAULT '0',
  `stock_ocean_ns_` timestamp NULL DEFAULT NULL,
  `stock_ocean_msk` int(11) NOT NULL DEFAULT '0',
  `stock_ocean_msk_` timestamp NULL DEFAULT NULL,
  `stock_ocean_rst` int(11) NOT NULL DEFAULT '0',
  `stock_ocean_rst_` timestamp NULL DEFAULT NULL,
  `stock_happy_sklad` int(11) NOT NULL DEFAULT '0',
  `stock_happy_sklad_` timestamp NULL DEFAULT NULL,
  `stock_happy_rez` int(11) NOT NULL DEFAULT '0',
  `stock_happy_rez_` timestamp NULL DEFAULT NULL,
  `stock_project111_total` int(11) NOT NULL DEFAULT '0',
  `stock_project111_total_` timestamp NULL DEFAULT NULL,
  `stock_project111_free` int(11) NOT NULL DEFAULT '0',
  `stock_project111_free_` timestamp NULL DEFAULT NULL,
  `stock_midocean` int(11) NOT NULL DEFAULT '0',
  `stock_midocean_` timestamp NULL DEFAULT NULL,
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования',
  `isnew` bit(1) NOT NULL DEFAULT b'0' COMMENT 'новика от поставщика',
  `stock_cuty` int(11) NOT NULL DEFAULT '0',
  `stock_cuty_` timestamp NULL DEFAULT NULL,
  `stock_eklektika_sklad` int(11) NOT NULL DEFAULT '0',
  `stock_eklektika_sklad_` timestamp NULL DEFAULT NULL,
  `stock_eklektika_rez` int(11) NOT NULL DEFAULT '0',
  `stock_eklektika_rez_` timestamp NULL DEFAULT NULL,
  `price_stan_main` int(11) DEFAULT NULL,
  `price_stan_main_` timestamp NULL DEFAULT NULL,
  `stock_stan_sklad` int(11) DEFAULT NULL,
  `stock_stan_sklad_` timestamp NULL DEFAULT NULL,
  `stock_stan_moscow` int(11) DEFAULT NULL,
  `stock_stan_moscow_` timestamp NULL DEFAULT NULL,
  `stock_stan_discount` int(11) DEFAULT NULL,
  `stock_stan_discount_` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с ценами и количествами товаров плюс ID';

-- --------------------------------------------------------

--
-- Структура таблицы `goods_prices_log`
--

CREATE TABLE IF NOT EXISTS `goods_prices_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `mfg` char(1) COLLATE utf8_bin NOT NULL COMMENT 'выгрузчик',
  `art` tinytext COLLATE utf8_bin NOT NULL COMMENT 'артикул',
  `price` text COLLATE utf8_bin NOT NULL COMMENT 'строка с ценами',
  `amount` text COLLATE utf8_bin NOT NULL COMMENT 'строка с количествами',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `goods_props`
--

CREATE TABLE IF NOT EXISTS `goods_props` (
  `id` bigint(20) unsigned NOT NULL COMMENT 'ID записи',
  `art_id` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `mfg` char(1) COLLATE utf8_bin NOT NULL,
  `cats` text COLLATE utf8_bin COMMENT 'строка со значением',
  `descr` text COLLATE utf8_bin COMMENT 'строка со значением',
  `params` text COLLATE utf8_bin COMMENT 'строка со значением',
  `images` text COLLATE utf8_bin COMMENT 'строка со значением',
  `ok` bit(1) NOT NULL DEFAULT b'0',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с историей изменения хар-к товаров';

-- --------------------------------------------------------

--
-- Структура таблицы `goods_props_current`
--

CREATE TABLE IF NOT EXISTS `goods_props_current` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `art_id` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `mfg` char(1) COLLATE utf8_bin NOT NULL COMMENT 'выгрузчик',
  `cats` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `descr` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `params` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `images` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `ok` bit(1) NOT NULL DEFAULT b'0' COMMENT 'для разборки на клиенте',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `hashes`
--

CREATE TABLE IF NOT EXISTS `hashes` (
  `part1` bigint(20) unsigned NOT NULL,
  `part2` bigint(20) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `imagefiles`
--

CREATE TABLE IF NOT EXISTS `imagefiles` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `hash` tinytext COLLATE utf8_bin NOT NULL COMMENT 'хэш md5',
  `filename` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='исходники картинок и ресайзы';

-- --------------------------------------------------------

--
-- Структура таблицы `images`
--

CREATE TABLE IF NOT EXISTS `images` (
  `art_id` int(11) NOT NULL COMMENT 'id товара',
  `url_id` int(11) NOT NULL COMMENT 'id ссылки на картинку',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT 'состояние картинки(>0 - в обработке)',
  `upd` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'последнее обновление'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='таблица состояния картинок';

-- --------------------------------------------------------

--
-- Структура таблицы `img_contents`
--

CREATE TABLE IF NOT EXISTS `img_contents` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `hash` tinytext COLLATE utf8_bin NOT NULL COMMENT 'хэш md5',
  `filename` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='исходники картинок и ресайзы';

-- --------------------------------------------------------

--
-- Структура таблицы `img_urls`
--

CREATE TABLE IF NOT EXISTS `img_urls` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `url` text COLLATE utf8_bin NOT NULL COMMENT 'адрес картинки',
  `hash` tinytext COLLATE utf8_bin NOT NULL COMMENT 'md5хэш',
  `state` int(11) NOT NULL DEFAULT '0' COMMENT 'состояние каринки( =0 - нормально, >0 - ошибка скачивания и требуется другой скрипт, <0 - http ошибка... в топку файл)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='список ссылок на картинки и хэшей';

-- --------------------------------------------------------

--
-- Структура таблицы `system_config`
--

CREATE TABLE IF NOT EXISTS `system_config` (
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `tmp_goods`
--

CREATE TABLE IF NOT EXISTS `tmp_goods` (
  `id` bigint(20) unsigned NOT NULL COMMENT 'значение',
  `mfg` char(1) COLLATE utf8_bin NOT NULL COMMENT 'выгрузчик',
  `art` tinytext COLLATE utf8_bin NOT NULL COMMENT 'артикул',
  `cat` text COLLATE utf8_bin NOT NULL COMMENT 'строки к каким категориям относятся CRLF',
  `xml` text COLLATE utf8_bin NOT NULL COMMENT 'полностью строка из выгрузки'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='таблица, куда сливаются выгрузки';

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `adm_components`
--
ALTER TABLE `adm_components`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `cron_scripts_state`
--
ALTER TABLE `cron_scripts_state`
  ADD PRIMARY KEY (`script_name`);

--
-- Индексы таблицы `ftpgroup`
--
ALTER TABLE `ftpgroup`
  ADD KEY `groupname` (`groupname`);

--
-- Индексы таблицы `ftpuser`
--
ALTER TABLE `ftpuser`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `goods_prices`
--
ALTER TABLE `goods_prices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `art` (`art`(20)),
  ADD KEY `mfg` (`mfg`);

--
-- Индексы таблицы `goods_prices_log`
--
ALTER TABLE `goods_prices_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `goods_props`
--
ALTER TABLE `goods_props`
  ADD PRIMARY KEY (`id`),
  ADD KEY `art_id` (`art_id`);

--
-- Индексы таблицы `goods_props_current`
--
ALTER TABLE `goods_props_current`
  ADD PRIMARY KEY (`art_id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `hashes`
--
ALTER TABLE `hashes`
  ADD KEY `part1` (`part1`,`part2`);

--
-- Индексы таблицы `imagefiles`
--
ALTER TABLE `imagefiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hash` (`hash`(32));

--
-- Индексы таблицы `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`art_id`,`url_id`),
  ADD KEY `state` (`state`);

--
-- Индексы таблицы `img_contents`
--
ALTER TABLE `img_contents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hash` (`hash`(32));

--
-- Индексы таблицы `img_urls`
--
ALTER TABLE `img_urls`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `url` (`url`(255));

--
-- Индексы таблицы `tmp_goods`
--
ALTER TABLE `tmp_goods`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `adm_components`
--
ALTER TABLE `adm_components`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `ftpuser`
--
ALTER TABLE `ftpuser`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `goods_prices`
--
ALTER TABLE `goods_prices`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `goods_props`
--
ALTER TABLE `goods_props`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `goods_props_current`
--
ALTER TABLE `goods_props_current`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `imagefiles`
--
ALTER TABLE `imagefiles`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `img_contents`
--
ALTER TABLE `img_contents`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `img_urls`
--
ALTER TABLE `img_urls`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `tmp_goods`
--
ALTER TABLE `tmp_goods`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'значение';
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
