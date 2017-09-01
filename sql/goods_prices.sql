-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Сен 01 2017 г., 14:35
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
-- Структура таблицы `goods_prices`
--

CREATE TABLE IF NOT EXISTS `goods_prices` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `mfg` char(1) COLLATE utf8_bin NOT NULL COMMENT 'выгрузчик',
  `art` tinytext COLLATE utf8_bin NOT NULL COMMENT 'артикул',
  `images` varchar(4000) COLLATE utf8_bin DEFAULT NULL COMMENT 'список картинок поставщика (hashes ONLY)',
  `price_xindao` int(11) NOT NULL DEFAULT '0',
  `price_xindao_` timestamp NULL DEFAULT NULL,
  `price_rainbow` int(11) NOT NULL DEFAULT '0',
  `price_rainbow_` timestamp NULL DEFAULT NULL,
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
  `stock_rainbow` int(11) NOT NULL DEFAULT '0',
  `stock_rainbow_` timestamp NULL DEFAULT NULL,
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

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `goods_prices`
--
ALTER TABLE `goods_prices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `art` (`art`(20)),
  ADD KEY `mfg` (`mfg`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `goods_prices`
--
ALTER TABLE `goods_prices`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
