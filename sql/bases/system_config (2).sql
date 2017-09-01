-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Сен 01 2017 г., 18:35
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
('admin', '1cb6414f8e9c4389a416f807bdcc47d4'),
('modules', ''),
('arr_MEASURES', 'a:4:{i:1;a:2:{s:4:"name";s:4:"шт";s:5:"delim";s:1:"1";}i:2;a:2:{s:4:"name";s:2:"л";s:5:"delim";s:4:"1000";}i:3;a:2:{s:4:"name";s:4:"кг";s:5:"delim";s:4:"1000";}i:4;a:2:{s:4:"name";s:2:"м";s:5:"delim";s:4:"1000";}}'),
('arr_ITEMFLAGS', 'a:5:{i:1;s:22:"едет на сайт";i:2;s:40:"собственное произв-во";i:3;s:30:"всегда в наличии";i:4;s:31:"не резервируется";i:5;s:30:"цена у менеджера";}'),
('var_TXT_NO_LEGAL', 'без юр.лица'),
('arr_CLI_JUR_HDR', 'a:4:{i:0;s:16:"Название";i:1;s:6:"ИНН";i:2;s:16:"синонимы";i:3;s:27:"дата заведения";}'),
('arr_CLI_HDR', 'a:4:{i:0;s:16:"Название";i:1;s:16:"синонимы";i:2;s:27:"дата заведения";i:3;s:26:"ответственный";}'),
('arr_DIMENSIONS_ICON', 'a:2:{i:0;s:2:"90";i:1;s:2:"90";}'),
('arr_DIMENSIONS_PICT', 'a:2:{i:0;s:3:"250";i:1;s:3:"250";}'),
('arr_STAFF_HDR', 'a:3:{i:0;s:10:"логин";i:1;s:6:"ФИО";i:2;s:27:"дата заведения";}'),
('arr_ITEMFIELDS', 'a:8:{s:3:"mfg";s:18:"Поставщик";s:3:"art";s:14:"Артикул";s:4:"cats";s:18:"Категории";s:5:"descr";s:16:"Описание";s:6:"params";s:28:"Характеристики";s:6:"images";s:16:"Картинки";s:6:"prices";s:8:"Цены";s:7:"amounts";s:20:"Количества";}'),
('arr_ITEMPARAMS', 'a:33:{s:5:"brand";s:10:"Бренд";s:10:"collection";s:18:"Коллекция";s:5:"descr";s:35:"Подробное описание";s:8:"manufact";s:26:"Производитель";s:5:"color";s:8:"Цвет";s:4:"size";s:12:"Размер";s:7:"boxtype";s:23:"Вид упаковки";s:6:"weight";s:6:"Вес";s:11:"countperbox";s:40:"Количество в упаковке";s:7:"sizebox";s:29:"Размер упаковки";s:5:"print";s:18:"Нанесение";s:7:"catpage";s:33:"Страница каталога";s:8:"discount";s:29:"Страница скидки";s:8:"material";s:16:"Материал";s:5:"sizes";s:29:"Размер текстиля";s:7:"measure";s:33:"Единица измерения";s:10:"descr_full";s:29:"Полное описание";s:9:"volumebox";s:25:"Объём коробки";s:9:"weightbox";s:21:"Вес коробки";s:6:"volume";s:10:"Объём";s:3:"new";s:14:"Новинка";s:6:"offers";s:10:"Акции";s:7:"comment";s:22:"Комментарий";s:7:"weights";s:23:"Вес текстиля";s:6:"gender";s:43:"Половая принадлежность";s:9:"papertype";s:19:"Тип бумаги";s:6:"series";s:10:"Серия";s:8:"viewtype";s:25:"Вид материала";s:12:"blindingtype";s:25:"Тип переплёта";s:10:"makeuptype";s:17:"Тип блока";s:7:"section";s:17:"Тип среза";s:10:"poducttype";s:21:"Тип изделия";s:14:"topicalitytype";s:30:"Спецпредложение";} '),
('var_BITSCOUNT_0', '4'),
('var_PRICEMULT_E', 'price_ebazaar:1.00'),
('var_AMOUNTSUM_E', '`stock_ebazaar2`'),
('var_PRICEMULT_O', 'price_oasis:1.00'),
('var_AMOUNTSUM_O', '`stock_oasis_sklad`'),
('var_FTPOUT', 'ftp://qtw:ced42Sddse@46.36.220.49/www/cat_new/in/'),
('var_PRICEMULT_C', 'price_ocean:1.00'),
('var_AMOUNTSUM_C', '`stock_ocean_total`'),
('var_PRICEMULT_H', 'price_happy:1.00'),
('var_AMOUNTSUM_H', '`stock_happy_sklad`+`stock_happy_rez`'),
('var_PRICEMULT_P', 'price_project111:1.00'),
('var_AMOUNTSUM_P', '`stock_project111_free`'),
('var_PRICEMULT_M', 'price_midocean:1.00'),
('var_AMOUNTSUM_M', '`stock_midocean`'),
('var_PRICEMULT_Q', 'price_cuty_opt:1.00'),
('var_AMOUNTSUM_Q', '`stock_cuty`'),
('var_PRICEMULT_J', 'price_eje_final:EUR'),
('var_AMOUNTSUM_J', '`stock_eje_stock`'),
('var_PRICEVIEW_E', 'CONCAT(CAST(TRUNCATE(`price_ebazaar`/100,2) AS CHAR),'' р.'')'),
('var_PRICEVIEW_O', 'CONCAT(CAST(TRUNCATE(`price_oasis`/100,2) AS CHAR),'' р.'')'),
('var_PRICEVIEW_C', 'CONCAT(CAST(TRUNCATE(`price_ocean`/100,2) AS CHAR),'' р.'')'),
('var_PRICEVIEW_H', 'CONCAT(CAST(TRUNCATE(`price_happy`/100,2) AS CHAR),'' р.'')'),
('var_PRICEVIEW_P', 'CONCAT(CAST(TRUNCATE(`price_project111`/100,2) AS CHAR),'' р.'')'),
('var_PRICEVIEW_M', 'CONCAT(CAST(TRUNCATE(`price_midocean`/100,2) AS CHAR),'' р.'')'),
('var_PRICEVIEW_Q', 'CONCAT(CAST(TRUNCATE(`price_cuty_opt`/100,2) AS CHAR),'' р.'')'),
('var_PRICEVIEW_J', 'CONCAT(CAST(TRUNCATE(`price_eje_final`/100,2) AS CHAR),'' €'')'),
('arr_ITEMPARAMSTYPES', 'a:2:{s:4:"main";s:44:"brand,descr,color,size,weight,print,material";s:6:"hidden";s:49:"descr_full,new,offers,topicalitype,gender,comment";} '),
('var_DAYLIMIT', '14'),
('var_PRICEMULT_X', 'price_xindao:1.00'),
('var_AMOUNTSUM_X', '`stock_xindao_eur`'),
('var_PRICEVIEW_X', 'CONCAT(CAST(TRUNCATE(`price_xindao`/100,2) AS CHAR),'' р.'')'),
('var_PRICEMULT_K', 'price_eklektika_main:1.00'),
('var_AMOUNTSUM_K', '`stock_eklektika_sklad`'),
('var_PRICEVIEW_K', 'CONCAT(CAST(TRUNCATE(`price_eklektika_main`/100,2) AS CHAR),'' р.'')'),
('var_PRICEMULT_S', 'price_stan_main:1.00'),
('var_AMOUNTSUM_S', 'IFNULL(`stock_stan_sklad`,0) + IFNULL(`stock_stan_moscow`,0) + IFNULL(`stock_stan_discount`,0)'),
('var_PRICEVIEW_S', 'CONCAT(CAST(TRUNCATE(`price_stan_main`/100,2) AS CHAR),'' р.'')'),
('admin', '1cb6414f8e9c4389a416f807bdcc47d4'),
('var_PRICEMULT_W', 'price_rainbow:1.00'),
('var_AMOUNTSUM_W', '`stock_rainbow`'),
('var_PRICEVIEW_W', 'CONCAT(CAST(TRUNCATE(`price_rainbow`/100,2) AS CHAR),'' р.'')'),
('var_SUBSCRIBES', 'E,O,C,H,P,M,Q,J,X,R,K,S,W');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
