-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Сен 01 2017 г., 12:31
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
-- Структура таблицы `system_config`
--

CREATE TABLE IF NOT EXISTS `system_config` (
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `system_config`
--

INSERT INTO `system_config` (`title`, `content`) VALUES
('var_KEY_RAINBOW','W'),
('arr_PRICES_W', 'a:1:{s:11:"price_rainbow";s:33:"розничная цена rainbow";} '),
('arr_STOCKS_W', 'a:1:{s:14:"stock_rainbow";s:36:"Радуга (на складе)";}'),
('var_TXT_NO_LEGAL', 'чёрный нал...'),
('var_KEY_EBAZAAR', 'E'),
('var_KEY_OASIS', 'O'),
('arr_PRICES_E', 'a:1:{s:13:"price_ebazaar";s:35:"розничная цена ebazaar";} '),
('arr_STOCKS_E', 'a:2:{s:14:"stock_ebazaar1";s:27:"ebazaar (на складе)";s:14:"stock_ebazaar2";s:26:"ebazaar (доступно)";} '),
('arr_MANUFACTURERS', 'a:12:{s:1:"E";s:7:"Ebazaar";s:1:"O";s:5:"OASIS";s:1:"C";s:5:"OCEAN";s:1:"H";s:11:"HAPPY gifts";s:1:"P";s:11:"Project 111";s:1:"M";s:16:"Mid Ocean Brands";s:1:"Q";s:29:"Локальный склад";s:1:"J";s:6:"ЕЖЕ";s:1:"X";s:6:"XINDAO";s:1:"R";s:14:"РосТайм";s:1:"K";s:18:"Эклектика";s:1:"S";s:4:"STAN";}'),
('arr_STOCKS_O', 'a:2:{s:17:"stock_oasis_sklad";s:30:"оазис (на складе)";s:15:"stock_oasis_rez";s:25:"оазис (резерв)";} '),
('arr_PRICES_O', 'a:1:{s:11:"price_oasis";s:33:"розничная цена oasis";} '),
('arr_PRICES_C', 'a:1:{s:11:"price_ocean";s:33:"розничная цена ocean";} '),
('arr_STOCKS_C', 'a:4:{s:17:"stock_ocean_total";s:41:"оазис (на складе всего)";s:14:"stock_ocean_ns";s:53:"оазис (на складе Новосибирск)";s:15:"stock_ocean_msk";s:43:"оазис (на складе Москва)";s:15:"stock_ocean_rst";s:43:"оазис (на складе Ростов)";} '),
('arr_PRICES_H', 'a:1:{s:11:"price_happy";s:33:"розничная цена happy";} '),
('arr_STOCKS_H', 'a:2:{s:17:"stock_happy_sklad";s:30:"хэппи (на складе)";s:15:"stock_happy_rez";s:25:"хэппи (резерв)";} '),
('arr_PRICES_P', 'a:1:{s:16:"price_project111";s:44:"розничная цена Проект 111";} '),
('arr_STOCKS_P', 'a:2:{s:22:"stock_project111_total";s:36:"Проект 111 (на складе)";s:21:"stock_project111_free";s:35:"Проект 111 (доступно)";} '),
('arr_PRICES_M', 'a:1:{s:14:"price_midocean";s:44:"розничная цена Mid Ocean Brands";}'),
('arr_STOCKS_M', 'a:1:{s:14:"stock_midocean";s:36:"Mid Ocean Brands (на складе)";}'),
('arr_PRICES_Q', 'a:4:{s:14:"price_cuty_sup";s:47:"цена поставщика для Кьюти";s:13:"price_cuty_in";s:41:"входная цена для Кьюти";s:14:"price_cuty_opt";s:34:"оптовая цена Кьюти";s:14:"price_cuty_ret";s:38:"розничная цена Кьюти";} '),
('arr_STOCKS_Q', 'a:1:{s:10:"stock_cuty";s:30:"Кьюти (на складе)";} '),
('var_KEY_OCEAN', 'C'),
('var_KEY_HAPPY', 'H'),
('var_KEY_PR111', 'P'),
('var_KEY_MID', 'M'),
('var_KEY_CUTY', 'Q'),
('var_KEY_EJE', 'J'),
('arr_STOCKS_J', 'a:3:{s:15:"stock_eje_stock";s:24:"еже (в запасе)";s:19:"stock_eje_warehouse";s:26:"еже (на складе)";s:18:"stock_eje_delivery";s:20:"еже (в пути)";} '),
('arr_PRICES_J', 'a:2:{s:17:"price_eje_initial";s:27:"начальная цена";s:15:"price_eje_final";s:25:"конечная цена";} '),
('var_KEY_XIN', 'X'),
('arr_STOCKS_X', 'a:3:{s:16:"stock_xindao_eur";s:24:"xindao (в Европе)";s:19:"stock_xindao_moscow";s:24:"xindao (в Москве)";s:25:"stock_xindao_moscow_avail";s:41:"xindao (в Москве доступно)";} '),
('arr_PRICES_X', 'a:1:{s:12:"price_xindao";s:27:"начальная цена";}'),
('var_KEY_ROSTIME', 'R'),
('arr_PRICES_R', 'a:1:{s:14:"price_midocean";s:44:"розничная цена Mid Ocean Brands";}'),
('arr_STOCKS_R', 'a:1:{s:14:"stock_midocean";s:36:"Mid Ocean Brands (на складе)";}'),
('var_KEY_EKLEKTIKA', 'K'),
('arr_STOCKS_K', 'a:2:{s:21:"stock_eklektika_sklad";s:38:"Эклектика (на складе)";s:19:"stock_eklektika_rez";s:33:"Эклектика (резерв)";}'),
('arr_PRICES_K', 'a:2:{s:20:"price_eklektika_main";s:25:"основная цена";s:19:"price_eklektika_adv";s:27:"рекламная цена";}'),
('var_KEY_STAN', 'S'),
('arr_PRICES_S', 'a:1:{s:15:"price_stan_main";s:25:"Цена в базе STAN";}'),
('arr_STOCKS_S', 'a:3:{s:16:"stock_stan_sklad";s:24:"STAN (на складе)";s:17:"stock_stan_moscow";s:19:"STAN (Москва)";s:19:"stock_stan_discount";s:19:"STAN (скидка)";}');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
