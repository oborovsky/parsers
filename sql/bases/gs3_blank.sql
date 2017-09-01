-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Сен 01 2017 г., 18:31
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
-- Структура таблицы `0_temp`
--

CREATE TABLE IF NOT EXISTS `0_temp` (
  `id` int(11) NOT NULL,
  `arts` text COLLATE utf8_bin,
  `mfgs` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `data` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со списком пользователей';

-- --------------------------------------------------------

--
-- Структура таблицы `accounts_access`
--

CREATE TABLE IF NOT EXISTS `accounts_access` (
  `user_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `component_id` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `accounts_binding`
--

CREATE TABLE IF NOT EXISTS `accounts_binding` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `login` varchar(100) COLLATE utf8_bin NOT NULL,
  `pass` varchar(100) COLLATE utf8_bin NOT NULL,
  `mod_title` varchar(100) COLLATE utf8_bin NOT NULL,
  `mod_name` varchar(100) COLLATE utf8_bin NOT NULL,
  `entrance` tinytext COLLATE utf8_bin NOT NULL,
  `url` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `accounts_log`
--

CREATE TABLE IF NOT EXISTS `accounts_log` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `accounts_upd`
--

CREATE TABLE IF NOT EXISTS `accounts_upd` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
-- Структура таблицы `adm_modules`
--

CREATE TABLE IF NOT EXISTS `adm_modules` (
  `id` int(11) NOT NULL,
  `content` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `parent` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `default_component` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `adm_modules_components_assoc`
--

CREATE TABLE IF NOT EXISTS `adm_modules_components_assoc` (
  `id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `component_id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `adm_systypes`
--

CREATE TABLE IF NOT EXISTS `adm_systypes` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `timestamp` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `bitmasks_0`
--

CREATE TABLE IF NOT EXISTS `bitmasks_0` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `parent` int(10) unsigned NOT NULL COMMENT 'ID родителя',
  `value` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `hvost` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'хвосты CSV',
  `settings` bigint(20) unsigned NOT NULL COMMENT 'биты полей при создании',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица с названиями групп товаров типа 0';

-- --------------------------------------------------------

--
-- Структура таблицы `bitmasks_0_log`
--

CREATE TABLE IF NOT EXISTS `bitmasks_0_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `parent` int(10) unsigned NOT NULL COMMENT 'ID родителя',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `hvost` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'хвосты CSV',
  `settings` bigint(20) unsigned NOT NULL COMMENT 'биты полей при создании',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `bitmasks_0_upd`
--

CREATE TABLE IF NOT EXISTS `bitmasks_0_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `parent` int(10) unsigned NOT NULL COMMENT 'ID родителя',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `hvost` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'хвосты CSV',
  `settings` bigint(20) unsigned NOT NULL COMMENT 'биты полей при создании',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `bits_0`
--

CREATE TABLE IF NOT EXISTS `bits_0` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `col_4` bigint(20) unsigned NOT NULL DEFAULT '0',
  `col_3` bigint(20) unsigned NOT NULL DEFAULT '0',
  `col_2` bigint(20) unsigned NOT NULL DEFAULT '0',
  `col_1` bigint(20) unsigned NOT NULL DEFAULT '0',
  `col_0` bigint(20) unsigned NOT NULL DEFAULT '0',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица с характеристиками товаров типа 0';

-- --------------------------------------------------------

--
-- Структура таблицы `bits_0_log`
--

CREATE TABLE IF NOT EXISTS `bits_0_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `col_0` bigint(20) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `bits_0_upd`
--

CREATE TABLE IF NOT EXISTS `bits_0_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `col_0` bigint(20) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `clients_bindings`
--

CREATE TABLE IF NOT EXISTS `clients_bindings` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица привязки клиентов к юр.лицам';

-- --------------------------------------------------------

--
-- Структура таблицы `clients_bindings_log`
--

CREATE TABLE IF NOT EXISTS `clients_bindings_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `clients_bindings_upd`
--

CREATE TABLE IF NOT EXISTS `clients_bindings_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `clients_legals`
--

CREATE TABLE IF NOT EXISTS `clients_legals` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'основное значение',
  `value2` text COLLATE utf8_bin NOT NULL COMMENT 'синонимы',
  `inn` tinytext COLLATE utf8_bin NOT NULL COMMENT 'ИНН',
  `fields` text COLLATE utf8_bin NOT NULL COMMENT 'прочие поля, массив',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с ИНН юр.лиц и их названиями/параметрами';

-- --------------------------------------------------------

--
-- Структура таблицы `clients_legals_log`
--

CREATE TABLE IF NOT EXISTS `clients_legals_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'основное значение',
  `value2` text COLLATE utf8_bin NOT NULL COMMENT 'синонимы',
  `inn` tinytext COLLATE utf8_bin NOT NULL COMMENT 'ИНН',
  `fields` text COLLATE utf8_bin NOT NULL COMMENT 'прочие поля, массив',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `clients_legals_upd`
--

CREATE TABLE IF NOT EXISTS `clients_legals_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'основное значение',
  `value2` text COLLATE utf8_bin NOT NULL COMMENT 'синонимы',
  `inn` tinytext COLLATE utf8_bin NOT NULL COMMENT 'ИНН',
  `fields` text COLLATE utf8_bin NOT NULL COMMENT 'прочие поля, массив',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `clients_names`
--

CREATE TABLE IF NOT EXISTS `clients_names` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'основное значение',
  `value2` text COLLATE utf8_bin NOT NULL COMMENT 'синонимы',
  `fields` text COLLATE utf8_bin NOT NULL COMMENT 'прочие поля, массив',
  `manager` int(10) unsigned NOT NULL COMMENT 'менеджер (см. users.id)',
  `created` date NOT NULL COMMENT 'дата создания в базе',
  `dynamic` text COLLATE utf8_bin NOT NULL,
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с ID-шниками клиентов и их названиями/параметрами';

-- --------------------------------------------------------

--
-- Структура таблицы `clients_names_log`
--

CREATE TABLE IF NOT EXISTS `clients_names_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'основное значение',
  `value2` text COLLATE utf8_bin NOT NULL COMMENT 'синонимы',
  `fields` text COLLATE utf8_bin NOT NULL COMMENT 'прочие поля, массив',
  `manager` int(10) unsigned NOT NULL COMMENT 'менеджер (см. users.id)',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `clients_names_upd`
--

CREATE TABLE IF NOT EXISTS `clients_names_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'основное значение',
  `value2` text COLLATE utf8_bin NOT NULL COMMENT 'синонимы',
  `fields` text COLLATE utf8_bin NOT NULL COMMENT 'прочие поля, массив',
  `manager` int(10) unsigned NOT NULL COMMENT 'менеджер (см. users.id)',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `clients_types`
--

CREATE TABLE IF NOT EXISTS `clients_types` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `parent` int(10) unsigned NOT NULL COMMENT 'ID родителя',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с видами деятельности';

-- --------------------------------------------------------

--
-- Структура таблицы `clients_types_log`
--

CREATE TABLE IF NOT EXISTS `clients_types_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `parent` int(10) unsigned NOT NULL COMMENT 'ID родителя',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `clients_types_upd`
--

CREATE TABLE IF NOT EXISTS `clients_types_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `parent` int(10) unsigned NOT NULL COMMENT 'ID родителя',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `dyn_fields`
--

CREATE TABLE IF NOT EXISTS `dyn_fields` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `name` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с ID поля',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с заголовком поля',
  `type` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с типом поля',
  `config` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'настройки поля',
  `form` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'название вызываемой формы',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица с динамическими полями форм';

-- --------------------------------------------------------

--
-- Структура таблицы `dyn_fields_log`
--

CREATE TABLE IF NOT EXISTS `dyn_fields_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `name` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с ID поля',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с заголовком поля',
  `type` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с типом поля',
  `type2` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'настройки поля',
  `form` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'название вызываемой формы',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `dyn_fields_upd`
--

CREATE TABLE IF NOT EXISTS `dyn_fields_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `name` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с ID поля',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с заголовком поля',
  `type` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с типом поля',
  `type2` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'настройки поля',
  `form` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'название вызываемой формы',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `dyn_field_forms`
--

CREATE TABLE IF NOT EXISTS `dyn_field_forms` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'читаемое название формы',
  `form` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'название вызываемой формы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица со списком форм для дин. полей';

-- --------------------------------------------------------

--
-- Структура таблицы `dyn_field_forms_log`
--

CREATE TABLE IF NOT EXISTS `dyn_field_forms_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'читаемое название формы',
  `form` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'название вызываемой формы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `dyn_field_forms_upd`
--

CREATE TABLE IF NOT EXISTS `dyn_field_forms_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'читаемое название формы',
  `form` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'название вызываемой формы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `goods_bindings_0`
--

CREATE TABLE IF NOT EXISTS `goods_bindings_0` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `int` int(10) unsigned NOT NULL COMMENT 'ID товара в нашей таблице цен',
  `art_id` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица с названиями групп правого меню';

-- --------------------------------------------------------

--
-- Структура таблицы `goods_bindings_0_backup`
--

CREATE TABLE IF NOT EXISTS `goods_bindings_0_backup` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `int` int(10) unsigned NOT NULL COMMENT 'ID товара в нашей таблице цен',
  `art_id` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица с названиями групп правого меню';

-- --------------------------------------------------------

--
-- Структура таблицы `goods_bindings_0_log`
--

CREATE TABLE IF NOT EXISTS `goods_bindings_0_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `int` int(10) unsigned NOT NULL COMMENT 'ID товара в нашей таблице цен',
  `art_id` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `goods_bindings_0_upd`
--

CREATE TABLE IF NOT EXISTS `goods_bindings_0_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `int` int(10) unsigned NOT NULL COMMENT 'ID товара в нашей таблице цен',
  `art_id` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `goods_prices_0`
--

CREATE TABLE IF NOT EXISTS `goods_prices_0` (
  `id` int(10) unsigned NOT NULL,
  `mfg` char(1) COLLATE utf8_bin NOT NULL,
  `art` tinytext COLLATE utf8_bin NOT NULL,
  `upd` timestamp NOT NULL,
  `isnew` bit(1) NOT NULL DEFAULT b'0',
  `images` varchar(4000) COLLATE utf8_bin DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `goods_upload`
--

CREATE TABLE IF NOT EXISTS `goods_upload` (
  `id` bigint(20) unsigned NOT NULL COMMENT 'ID записи',
  `art_id` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `mfg` char(1) COLLATE utf8_bin NOT NULL COMMENT 'выгрузчик',
  `cats` text COLLATE utf8_bin COMMENT 'строка со значением',
  `descr` text COLLATE utf8_bin COMMENT 'строка со значением',
  `params` text COLLATE utf8_bin COMMENT 'строка со значением',
  `images` text COLLATE utf8_bin COMMENT 'строка со значением',
  `ok` bit(1) NOT NULL DEFAULT b'0',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с историей изменения хар-к товаров';

-- --------------------------------------------------------

--
-- Структура таблицы `goods_upload_done`
--

CREATE TABLE IF NOT EXISTS `goods_upload_done` (
  `id` int(11) DEFAULT NULL,
  `art_id` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `mfg` char(1) COLLATE utf8_bin NOT NULL COMMENT 'выгрузчик',
  `cats` text COLLATE utf8_bin COMMENT 'строка со значением',
  `descr` text COLLATE utf8_bin COMMENT 'строка со значением',
  `params` text COLLATE utf8_bin COMMENT 'строка со значением',
  `images` text COLLATE utf8_bin COMMENT 'строка со значением',
  `ok` bit(1) NOT NULL DEFAULT b'0',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с историей изменения хар-к товаров';

-- --------------------------------------------------------

--
-- Структура таблицы `instr_access`
--

CREATE TABLE IF NOT EXISTS `instr_access` (
  `user_id` int(11) NOT NULL COMMENT 'Идентификатор пользователю',
  `user_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Тип пользователя ( 0 - юзер, 1 - шаблон, 2 - группа )',
  `access` tinytext CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'список идентификаторов разрешённых пользователю'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица доступов к инструкциям';

-- --------------------------------------------------------

--
-- Структура таблицы `instr_content`
--

CREATE TABLE IF NOT EXISTS `instr_content` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `title` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'название инструкции',
  `content` mediumtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'содержание инструкций',
  `type` tinyint(3) unsigned NOT NULL COMMENT 'тип инструкции',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица с содержаниями инструкции';

-- --------------------------------------------------------

--
-- Структура таблицы `instr_content_log`
--

CREATE TABLE IF NOT EXISTS `instr_content_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `title` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'название инструкции',
  `content` mediumtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'содержание инструкций',
  `type` tinyint(3) unsigned NOT NULL COMMENT 'тип инструкции',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='LOG: Таблица с содержаниями инструкции';

-- --------------------------------------------------------

--
-- Структура таблицы `instr_content_upd`
--

CREATE TABLE IF NOT EXISTS `instr_content_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `title` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'название инструкции',
  `content` mediumtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'содержание инструкций',
  `type` tinyint(3) unsigned NOT NULL COMMENT 'тип инструкции',
  `uid` int(11) NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='UPDATE: Таблица с содержаниями инструкции';

-- --------------------------------------------------------

--
-- Структура таблицы `instr_patterns`
--

CREATE TABLE IF NOT EXISTS `instr_patterns` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `title` tinytext CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'название шаблона',
  `order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'порядоковый номер',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица с шаблонами доступов к инструкциям';

-- --------------------------------------------------------

--
-- Структура таблицы `instr_patterns_log`
--

CREATE TABLE IF NOT EXISTS `instr_patterns_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `title` tinytext CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'название шаблона',
  `order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'порядоковый номер',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='LOG: Таблица с шаблонами доступов к инструкциям';

-- --------------------------------------------------------

--
-- Структура таблицы `instr_patterns_upd`
--

CREATE TABLE IF NOT EXISTS `instr_patterns_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `title` tinytext CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'название шаблона',
  `order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'порядоковый номер',
  `uid` int(11) NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='UPDATE: Таблица с шаблонами доступов к инструкциям';

-- --------------------------------------------------------

--
-- Структура таблицы `instr_tree`
--

CREATE TABLE IF NOT EXISTS `instr_tree` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `title` tinytext CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'название инструкции в дереве',
  `content_id` int(10) unsigned NOT NULL COMMENT 'содержание инструкции (см. instr_content)',
  `parent` int(10) unsigned NOT NULL COMMENT 'родительский элемент (0 = root)',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядоковый номер на своём уровне дерева',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица с деревом инструкций';

-- --------------------------------------------------------

--
-- Структура таблицы `instr_tree_log`
--

CREATE TABLE IF NOT EXISTS `instr_tree_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `title` tinytext CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'название инструкции в дереве',
  `content_id` int(10) unsigned NOT NULL COMMENT 'содержание инструкции (см. instr_content)',
  `parent` int(10) unsigned NOT NULL COMMENT 'родительский элемент (0 = root)',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядоковый номер на своём уровне дерева',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='LOG: Таблица с деревом инструкций';

-- --------------------------------------------------------

--
-- Структура таблицы `instr_tree_upd`
--

CREATE TABLE IF NOT EXISTS `instr_tree_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `title` tinytext CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'название инструкции в дереве',
  `content_id` int(10) unsigned NOT NULL COMMENT 'содержание инструкции (см. instr_content)',
  `parent` int(10) unsigned NOT NULL COMMENT 'родительский элемент (0 = root)',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядоковый номер на своём уровне дерева',
  `uid` int(11) NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='UPDATE: Таблица с деревом инструкций';

-- --------------------------------------------------------

--
-- Структура таблицы `items_0`
--

CREATE TABLE IF NOT EXISTS `items_0` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `arts` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `mfgs` text CHARACTER SET utf8 COLLATE utf8_bin,
  `cats` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `descr` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `params` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `images` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `images_new` varchar(4000) DEFAULT NULL,
  `images_backup` varchar(4000) DEFAULT NULL,
  `price` int(10) NOT NULL DEFAULT '0' COMMENT 'цена',
  `overprice` int(10) NOT NULL DEFAULT '0' COMMENT 'цена',
  `prices` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT 'кол-во',
  `overamount` int(11) NOT NULL DEFAULT '0' COMMENT 'ID товара в таблице цен',
  `amounts` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `price_view` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'отображаемая на сайте цена',
  `ok` bit(1) NOT NULL DEFAULT b'0' COMMENT 'для разборки на клиенте',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования',
  `isnew` bit(1) NOT NULL DEFAULT b'0' COMMENT 'новинка из каталога'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Таблица с историей изменения хар-к товаров';

-- --------------------------------------------------------

--
-- Структура таблицы `items_0_backup`
--

CREATE TABLE IF NOT EXISTS `items_0_backup` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `arts` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `mfgs` text CHARACTER SET utf8 COLLATE utf8_bin,
  `cats` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `descr` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `params` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `images` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `images_new` varchar(4000) DEFAULT NULL,
  `images_backup` varchar(4000) DEFAULT NULL,
  `price` int(10) NOT NULL DEFAULT '0' COMMENT 'цена',
  `overprice` int(10) NOT NULL DEFAULT '0' COMMENT 'цена',
  `prices` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT 'кол-во',
  `overamount` int(11) NOT NULL DEFAULT '0' COMMENT 'ID товара в таблице цен',
  `amounts` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'строка со значением',
  `price_view` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'отображаемая на сайте цена',
  `ok` bit(1) NOT NULL DEFAULT b'0' COMMENT 'для разборки на клиенте',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования',
  `isnew` bit(1) NOT NULL DEFAULT b'0' COMMENT 'новинка из каталога'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Таблица с историей изменения хар-к товаров';

-- --------------------------------------------------------

--
-- Структура таблицы `items_0_log`
--

CREATE TABLE IF NOT EXISTS `items_0_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `arts` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `mfgs` text COLLATE utf8_bin NOT NULL,
  `cats` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `descr` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `params` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `images` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `price` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `overprice` int(10) unsigned NOT NULL COMMENT 'цена',
  `prices` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `amount` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `overamount` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `amounts` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `ok` bit(1) NOT NULL COMMENT 'для разборки на клиенте',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `items_0_upd`
--

CREATE TABLE IF NOT EXISTS `items_0_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `arts` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `cats` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `descr` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `params` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `images` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `price` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `overprice` int(10) unsigned NOT NULL COMMENT 'цена',
  `prices` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `amount` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `overamount` int(10) unsigned NOT NULL COMMENT 'ID товара в таблице цен',
  `amounts` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `ok` bit(1) NOT NULL COMMENT 'для разборки на клиенте',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `itemtypes`
--

CREATE TABLE IF NOT EXISTS `itemtypes` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `params` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `settings` bigint(20) unsigned NOT NULL COMMENT 'биты полей при создании',
  `managers` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `departments` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `rightmenus` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица списка видов товаров';

-- --------------------------------------------------------

--
-- Структура таблицы `itemtypes_log`
--

CREATE TABLE IF NOT EXISTS `itemtypes_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `params` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `settings` bigint(20) unsigned NOT NULL COMMENT 'биты полей при создании',
  `managers` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `departments` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `rightmenus` text COLLATE utf8_bin NOT NULL COMMENT 'строка со значением',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `prices`
--

CREATE TABLE IF NOT EXISTS `prices` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `type` int(10) unsigned NOT NULL COMMENT 'тип склада',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `manager` int(10) unsigned NOT NULL COMMENT 'ответственный',
  `managers` tinytext COLLATE utf8_bin NOT NULL COMMENT 'CSV список у кого есть допуск',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `dynamic` text COLLATE utf8_bin NOT NULL COMMENT 'динамические поля',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица складов';

-- --------------------------------------------------------

--
-- Структура таблицы `prices_log`
--

CREATE TABLE IF NOT EXISTS `prices_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `type` int(10) unsigned NOT NULL COMMENT 'тип склада',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `manager` int(10) unsigned NOT NULL COMMENT 'ответственный',
  `managers` tinytext COLLATE utf8_bin NOT NULL COMMENT 'CSV список у кого есть допуск',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `dynamic` text COLLATE utf8_bin NOT NULL COMMENT 'динамические поля',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `prices_upd`
--

CREATE TABLE IF NOT EXISTS `prices_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `type` int(10) unsigned NOT NULL COMMENT 'тип склада',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `manager` int(10) unsigned NOT NULL COMMENT 'ответственный',
  `managers` tinytext COLLATE utf8_bin NOT NULL COMMENT 'CSV список у кого есть допуск',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `dynamic` text COLLATE utf8_bin NOT NULL COMMENT 'динамические поля',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `pricetypes`
--

CREATE TABLE IF NOT EXISTS `pricetypes` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица типов складов';

-- --------------------------------------------------------

--
-- Структура таблицы `pricetypes_log`
--

CREATE TABLE IF NOT EXISTS `pricetypes_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `pricetypes_upd`
--

CREATE TABLE IF NOT EXISTS `pricetypes_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `projects_trees`
--

CREATE TABLE IF NOT EXISTS `projects_trees` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `parent` int(10) unsigned NOT NULL COMMENT 'ID родителя',
  `rightmenu_id` int(10) unsigned NOT NULL COMMENT 'тип записи',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с деревом проектов, включая названия строк';

-- --------------------------------------------------------

--
-- Структура таблицы `projects_trees_log`
--

CREATE TABLE IF NOT EXISTS `projects_trees_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `parent` int(10) unsigned NOT NULL COMMENT 'ID родителя',
  `rightmenu_id` int(10) unsigned NOT NULL COMMENT 'тип записи',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `projects_trees_upd`
--

CREATE TABLE IF NOT EXISTS `projects_trees_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `parent` int(10) unsigned NOT NULL COMMENT 'ID родителя',
  `rightmenu_id` int(10) unsigned NOT NULL COMMENT 'тип записи',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__admin`
--

CREATE TABLE IF NOT EXISTS `project__admin` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__admins`
--

CREATE TABLE IF NOT EXISTS `project__admins` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением юзеров типа admins';

-- --------------------------------------------------------

--
-- Структура таблицы `project__admins_log`
--

CREATE TABLE IF NOT EXISTS `project__admins_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__admins_upd`
--

CREATE TABLE IF NOT EXISTS `project__admins_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__admin_log`
--

CREATE TABLE IF NOT EXISTS `project__admin_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__admin_upd`
--

CREATE TABLE IF NOT EXISTS `project__admin_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__amount_plan`
--

CREATE TABLE IF NOT EXISTS `project__amount_plan` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__amount_plan_log`
--

CREATE TABLE IF NOT EXISTS `project__amount_plan_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__amount_plan_upd`
--

CREATE TABLE IF NOT EXISTS `project__amount_plan_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__amount_ready`
--

CREATE TABLE IF NOT EXISTS `project__amount_ready` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__amount_ready_log`
--

CREATE TABLE IF NOT EXISTS `project__amount_ready_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__amount_ready_upd`
--

CREATE TABLE IF NOT EXISTS `project__amount_ready_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__amount_total`
--

CREATE TABLE IF NOT EXISTS `project__amount_total` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__amount_total_log`
--

CREATE TABLE IF NOT EXISTS `project__amount_total_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__amount_total_upd`
--

CREATE TABLE IF NOT EXISTS `project__amount_total_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__assistant`
--

CREATE TABLE IF NOT EXISTS `project__assistant` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением юзера типа assistant';

-- --------------------------------------------------------

--
-- Структура таблицы `project__assistant_log`
--

CREATE TABLE IF NOT EXISTS `project__assistant_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__assistant_upd`
--

CREATE TABLE IF NOT EXISTS `project__assistant_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__carrier_partner`
--

CREATE TABLE IF NOT EXISTS `project__carrier_partner` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с указанием перевозчиков (транспортных компаний)';

-- --------------------------------------------------------

--
-- Структура таблицы `project__carrier_partner_log`
--

CREATE TABLE IF NOT EXISTS `project__carrier_partner_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__carrier_partner_upd`
--

CREATE TABLE IF NOT EXISTS `project__carrier_partner_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__code`
--

CREATE TABLE IF NOT EXISTS `project__code` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с кодом или артикулом';

-- --------------------------------------------------------

--
-- Структура таблицы `project__code_log`
--

CREATE TABLE IF NOT EXISTS `project__code_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__code_upd`
--

CREATE TABLE IF NOT EXISTS `project__code_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__comment`
--

CREATE TABLE IF NOT EXISTS `project__comment` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__comment_log`
--

CREATE TABLE IF NOT EXISTS `project__comment_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__comment_upd`
--

CREATE TABLE IF NOT EXISTS `project__comment_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__creator`
--

CREATE TABLE IF NOT EXISTS `project__creator` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__creator_log`
--

CREATE TABLE IF NOT EXISTS `project__creator_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__creator_upd`
--

CREATE TABLE IF NOT EXISTS `project__creator_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__descr`
--

CREATE TABLE IF NOT EXISTS `project__descr` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__descr_log`
--

CREATE TABLE IF NOT EXISTS `project__descr_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__descr_upd`
--

CREATE TABLE IF NOT EXISTS `project__descr_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__doc_partner_in`
--

CREATE TABLE IF NOT EXISTS `project__doc_partner_in` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с указанием поставщиков по документам';

-- --------------------------------------------------------

--
-- Структура таблицы `project__doc_partner_in_log`
--

CREATE TABLE IF NOT EXISTS `project__doc_partner_in_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__doc_partner_in_upd`
--

CREATE TABLE IF NOT EXISTS `project__doc_partner_in_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__doc_partner_out`
--

CREATE TABLE IF NOT EXISTS `project__doc_partner_out` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с указанием заказчиков по документам';

-- --------------------------------------------------------

--
-- Структура таблицы `project__doc_partner_out_log`
--

CREATE TABLE IF NOT EXISTS `project__doc_partner_out_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__doc_partner_out_upd`
--

CREATE TABLE IF NOT EXISTS `project__doc_partner_out_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__done`
--

CREATE TABLE IF NOT EXISTS `project__done` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением чекбокса готовности';

-- --------------------------------------------------------

--
-- Структура таблицы `project__done_log`
--

CREATE TABLE IF NOT EXISTS `project__done_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__done_upd`
--

CREATE TABLE IF NOT EXISTS `project__done_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_date_end`
--

CREATE TABLE IF NOT EXISTS `project__fact_date_end` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_date_end_log`
--

CREATE TABLE IF NOT EXISTS `project__fact_date_end_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_date_end_upd`
--

CREATE TABLE IF NOT EXISTS `project__fact_date_end_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_date_start`
--

CREATE TABLE IF NOT EXISTS `project__fact_date_start` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_date_start_log`
--

CREATE TABLE IF NOT EXISTS `project__fact_date_start_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_date_start_upd`
--

CREATE TABLE IF NOT EXISTS `project__fact_date_start_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_partner_in`
--

CREATE TABLE IF NOT EXISTS `project__fact_partner_in` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с указанием фактических поставщиков';

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_partner_in_log`
--

CREATE TABLE IF NOT EXISTS `project__fact_partner_in_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_partner_in_upd`
--

CREATE TABLE IF NOT EXISTS `project__fact_partner_in_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_partner_out`
--

CREATE TABLE IF NOT EXISTS `project__fact_partner_out` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с указанием заказчиков не-по-документам';

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_partner_out_log`
--

CREATE TABLE IF NOT EXISTS `project__fact_partner_out_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_partner_out_upd`
--

CREATE TABLE IF NOT EXISTS `project__fact_partner_out_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_price_in`
--

CREATE TABLE IF NOT EXISTS `project__fact_price_in` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением редактируемых фактических входных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_price_in_log`
--

CREATE TABLE IF NOT EXISTS `project__fact_price_in_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_price_in_upd`
--

CREATE TABLE IF NOT EXISTS `project__fact_price_in_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_price_out`
--

CREATE TABLE IF NOT EXISTS `project__fact_price_out` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением редактируемых фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_price_out_log`
--

CREATE TABLE IF NOT EXISTS `project__fact_price_out_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_price_out_upd`
--

CREATE TABLE IF NOT EXISTS `project__fact_price_out_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_sum_in`
--

CREATE TABLE IF NOT EXISTS `project__fact_sum_in` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанныхых фактических входных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_sum_in_log`
--

CREATE TABLE IF NOT EXISTS `project__fact_sum_in_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_sum_in_upd`
--

CREATE TABLE IF NOT EXISTS `project__fact_sum_in_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_sum_out`
--

CREATE TABLE IF NOT EXISTS `project__fact_sum_out` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_sum_out_log`
--

CREATE TABLE IF NOT EXISTS `project__fact_sum_out_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__fact_sum_out_upd`
--

CREATE TABLE IF NOT EXISTS `project__fact_sum_out_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__follower`
--

CREATE TABLE IF NOT EXISTS `project__follower` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением юзера типа follower';

-- --------------------------------------------------------

--
-- Структура таблицы `project__follower_log`
--

CREATE TABLE IF NOT EXISTS `project__follower_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__follower_upd`
--

CREATE TABLE IF NOT EXISTS `project__follower_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_issued`
--

CREATE TABLE IF NOT EXISTS `project__info_date_issued` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со справочной датой';

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_issued_log`
--

CREATE TABLE IF NOT EXISTS `project__info_date_issued_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_issued_upd`
--

CREATE TABLE IF NOT EXISTS `project__info_date_issued_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_notified`
--

CREATE TABLE IF NOT EXISTS `project__info_date_notified` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со справочной датой';

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_notified_log`
--

CREATE TABLE IF NOT EXISTS `project__info_date_notified_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_notified_upd`
--

CREATE TABLE IF NOT EXISTS `project__info_date_notified_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_paid`
--

CREATE TABLE IF NOT EXISTS `project__info_date_paid` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со справочной датой';

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_paid_log`
--

CREATE TABLE IF NOT EXISTS `project__info_date_paid_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_paid_upd`
--

CREATE TABLE IF NOT EXISTS `project__info_date_paid_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_recieved`
--

CREATE TABLE IF NOT EXISTS `project__info_date_recieved` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со справочной датой';

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_recieved_log`
--

CREATE TABLE IF NOT EXISTS `project__info_date_recieved_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_recieved_upd`
--

CREATE TABLE IF NOT EXISTS `project__info_date_recieved_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_send`
--

CREATE TABLE IF NOT EXISTS `project__info_date_send` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со справочной датой';

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_send_log`
--

CREATE TABLE IF NOT EXISTS `project__info_date_send_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_send_upd`
--

CREATE TABLE IF NOT EXISTS `project__info_date_send_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_signed`
--

CREATE TABLE IF NOT EXISTS `project__info_date_signed` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со справочной датой';

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_signed_log`
--

CREATE TABLE IF NOT EXISTS `project__info_date_signed_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__info_date_signed_upd`
--

CREATE TABLE IF NOT EXISTS `project__info_date_signed_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__listener`
--

CREATE TABLE IF NOT EXISTS `project__listener` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением юзера типа listener';

-- --------------------------------------------------------

--
-- Структура таблицы `project__listeners`
--

CREATE TABLE IF NOT EXISTS `project__listeners` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением юзеров типа listener';

-- --------------------------------------------------------

--
-- Структура таблицы `project__listeners_log`
--

CREATE TABLE IF NOT EXISTS `project__listeners_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__listeners_upd`
--

CREATE TABLE IF NOT EXISTS `project__listeners_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__listener_log`
--

CREATE TABLE IF NOT EXISTS `project__listener_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__listener_upd`
--

CREATE TABLE IF NOT EXISTS `project__listener_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__manager`
--

CREATE TABLE IF NOT EXISTS `project__manager` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__managers`
--

CREATE TABLE IF NOT EXISTS `project__managers` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением юзеров типа managers';

-- --------------------------------------------------------

--
-- Структура таблицы `project__managers_log`
--

CREATE TABLE IF NOT EXISTS `project__managers_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__managers_upd`
--

CREATE TABLE IF NOT EXISTS `project__managers_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__manager_log`
--

CREATE TABLE IF NOT EXISTS `project__manager_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__manager_upd`
--

CREATE TABLE IF NOT EXISTS `project__manager_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__manufacturer_partner`
--

CREATE TABLE IF NOT EXISTS `project__manufacturer_partner` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с указанием партнёров - изготовителей';

-- --------------------------------------------------------

--
-- Структура таблицы `project__manufacturer_partner_log`
--

CREATE TABLE IF NOT EXISTS `project__manufacturer_partner_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__manufacturer_partner_upd`
--

CREATE TABLE IF NOT EXISTS `project__manufacturer_partner_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__name`
--

CREATE TABLE IF NOT EXISTS `project__name` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__name_log`
--

CREATE TABLE IF NOT EXISTS `project__name_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__name_upd`
--

CREATE TABLE IF NOT EXISTS `project__name_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__number`
--

CREATE TABLE IF NOT EXISTS `project__number` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с номером или ID';

-- --------------------------------------------------------

--
-- Структура таблицы `project__number_log`
--

CREATE TABLE IF NOT EXISTS `project__number_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__number_upd`
--

CREATE TABLE IF NOT EXISTS `project__number_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_date_end`
--

CREATE TABLE IF NOT EXISTS `project__plan_date_end` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_date_end_log`
--

CREATE TABLE IF NOT EXISTS `project__plan_date_end_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_date_end_upd`
--

CREATE TABLE IF NOT EXISTS `project__plan_date_end_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_date_start`
--

CREATE TABLE IF NOT EXISTS `project__plan_date_start` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных фактических выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_date_start_log`
--

CREATE TABLE IF NOT EXISTS `project__plan_date_start_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_date_start_upd`
--

CREATE TABLE IF NOT EXISTS `project__plan_date_start_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` date NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_price_in`
--

CREATE TABLE IF NOT EXISTS `project__plan_price_in` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением редактируемых плановых входных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_price_in_log`
--

CREATE TABLE IF NOT EXISTS `project__plan_price_in_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_price_in_upd`
--

CREATE TABLE IF NOT EXISTS `project__plan_price_in_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_price_out`
--

CREATE TABLE IF NOT EXISTS `project__plan_price_out` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением редактируемых плановых выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_price_out_log`
--

CREATE TABLE IF NOT EXISTS `project__plan_price_out_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_price_out_upd`
--

CREATE TABLE IF NOT EXISTS `project__plan_price_out_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_sum_in`
--

CREATE TABLE IF NOT EXISTS `project__plan_sum_in` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанныхых плановых входных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_sum_in_log`
--

CREATE TABLE IF NOT EXISTS `project__plan_sum_in_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_sum_in_upd`
--

CREATE TABLE IF NOT EXISTS `project__plan_sum_in_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_sum_out`
--

CREATE TABLE IF NOT EXISTS `project__plan_sum_out` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением рассчитанных плановых выходных цен';

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_sum_out_log`
--

CREATE TABLE IF NOT EXISTS `project__plan_sum_out_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__plan_sum_out_upd`
--

CREATE TABLE IF NOT EXISTS `project__plan_sum_out_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__state_doc`
--

CREATE TABLE IF NOT EXISTS `project__state_doc` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением статуса документа';

-- --------------------------------------------------------

--
-- Структура таблицы `project__state_doc_log`
--

CREATE TABLE IF NOT EXISTS `project__state_doc_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__state_doc_upd`
--

CREATE TABLE IF NOT EXISTS `project__state_doc_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__state_done`
--

CREATE TABLE IF NOT EXISTS `project__state_done` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением статуса выполнения';

-- --------------------------------------------------------

--
-- Структура таблицы `project__state_done_log`
--

CREATE TABLE IF NOT EXISTS `project__state_done_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__state_done_upd`
--

CREATE TABLE IF NOT EXISTS `project__state_done_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__state_prod`
--

CREATE TABLE IF NOT EXISTS `project__state_prod` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением статуса изготовления';

-- --------------------------------------------------------

--
-- Структура таблицы `project__state_prod_log`
--

CREATE TABLE IF NOT EXISTS `project__state_prod_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__state_prod_upd`
--

CREATE TABLE IF NOT EXISTS `project__state_prod_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__state_sell`
--

CREATE TABLE IF NOT EXISTS `project__state_sell` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением статуса продажи';

-- --------------------------------------------------------

--
-- Структура таблицы `project__state_sell_log`
--

CREATE TABLE IF NOT EXISTS `project__state_sell_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__state_sell_upd`
--

CREATE TABLE IF NOT EXISTS `project__state_sell_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__transit_partner`
--

CREATE TABLE IF NOT EXISTS `project__transit_partner` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица с указанием транзитных партнёров';

-- --------------------------------------------------------

--
-- Структура таблицы `project__transit_partner_log`
--

CREATE TABLE IF NOT EXISTS `project__transit_partner_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__transit_partner_upd`
--

CREATE TABLE IF NOT EXISTS `project__transit_partner_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `client_id` int(10) unsigned NOT NULL COMMENT 'ID клиента',
  `legal_id` int(10) unsigned NOT NULL COMMENT 'ID юр.лица',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'название партнера не из базы',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__worker`
--

CREATE TABLE IF NOT EXISTS `project__worker` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением юзера типа worker';

-- --------------------------------------------------------

--
-- Структура таблицы `project__workers`
--

CREATE TABLE IF NOT EXISTS `project__workers` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со значением юзеров типа worker';

-- --------------------------------------------------------

--
-- Структура таблицы `project__workers_log`
--

CREATE TABLE IF NOT EXISTS `project__workers_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__workers_upd`
--

CREATE TABLE IF NOT EXISTS `project__workers_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` text COLLATE utf8_bin NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__worker_log`
--

CREATE TABLE IF NOT EXISTS `project__worker_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `project__worker_upd`
--

CREATE TABLE IF NOT EXISTS `project__worker_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `projtree_id` int(10) unsigned NOT NULL COMMENT 'строка проекта (см. projects_tree.id)',
  `value` int(11) NOT NULL COMMENT 'значение',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `rightmenugroups`
--

CREATE TABLE IF NOT EXISTS `rightmenugroups` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `descr` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка для меню',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `icon` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'стиль иконки',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица с названиями групп правого меню';

-- --------------------------------------------------------

--
-- Структура таблицы `rightmenugroups_log`
--

CREATE TABLE IF NOT EXISTS `rightmenugroups_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `descr` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка для меню',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `icon` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'стиль иконки',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `rightmenugroups_upd`
--

CREATE TABLE IF NOT EXISTS `rightmenugroups_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `descr` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка для меню',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `icon` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'стиль иконки',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `rightmenus`
--

CREATE TABLE IF NOT EXISTS `rightmenus` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с заголовком формы',
  `value2` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с заголовком формы (создание)',
  `form` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'название вызываемой формы',
  `form2` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'параметр вызываемой формы',
  `dops` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `descr` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка описания для админки',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения в правом меню',
  `icon` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'стиль иконки',
  `rightmenu_group` tinyint(3) unsigned NOT NULL COMMENT 'в какой группе правого меню',
  `menu_name` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка для меню',
  `transform` tinyint(3) unsigned NOT NULL COMMENT 'в какой тип превращается',
  `form_create` bigint(20) unsigned NOT NULL COMMENT 'биты полей при создании',
  `form_create_required` bigint(20) unsigned NOT NULL COMMENT 'биты обязательных полей при создании',
  `form_edit` bigint(20) unsigned NOT NULL COMMENT 'биты полей при редактировании',
  `form_edit_readonly` bigint(20) unsigned NOT NULL COMMENT 'биты нередактируемых полей при редактировании',
  `form_edit_required` bigint(20) unsigned NOT NULL COMMENT 'биты обязательных полей при редактировании',
  `form_edit_hidden` bigint(20) unsigned NOT NULL COMMENT 'биты закрытых полей при редактировании',
  `tree_show` bigint(20) unsigned NOT NULL COMMENT 'выводимые допы в строке дерева проектов',
  `tree_show_childs` bigint(20) unsigned NOT NULL COMMENT 'выводимые допы потомков в строке дерева проектов',
  `tree_calc` bigint(20) unsigned NOT NULL COMMENT 'биты настроек допов',
  `tree_calc_childs` bigint(20) unsigned NOT NULL COMMENT 'биты настроек допов потомков',
  `tree_calc_parents` bigint(20) unsigned NOT NULL COMMENT 'биты настройки форварда допов',
  `rightmenu_childs` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'список строк правого меню на строке',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица с настройками форм и правого меню';

-- --------------------------------------------------------

--
-- Структура таблицы `rightmenus_log`
--

CREATE TABLE IF NOT EXISTS `rightmenus_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с заголовком формы',
  `value2` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с заголовком формы (создание)',
  `form` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'название вызываемой формы',
  `form2` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'параметр вызываемой формы',
  `dops` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `descr` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка описания для админки',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения в правом меню',
  `icon` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'стиль иконки',
  `rightmenu_group` tinyint(3) unsigned NOT NULL COMMENT 'в какой группе правого меню',
  `menu_name` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка для меню',
  `transform` tinyint(3) unsigned NOT NULL COMMENT 'в какой тип превращается',
  `form_create` bigint(20) unsigned NOT NULL COMMENT 'биты полей при создании',
  `form_create_required` bigint(20) unsigned NOT NULL COMMENT 'биты обязательных полей при создании',
  `form_edit` bigint(20) unsigned NOT NULL COMMENT 'биты полей при редактировании',
  `form_edit_readonly` bigint(20) unsigned NOT NULL COMMENT 'биты нередактируемых полей при редактировании',
  `form_edit_required` bigint(20) unsigned NOT NULL COMMENT 'биты обязательных полей при редактировании',
  `form_edit_hidden` bigint(20) unsigned NOT NULL COMMENT 'биты закрытых полей при редактировании',
  `tree_show` bigint(20) unsigned NOT NULL COMMENT 'выводимые допы в строке дерева проектов',
  `tree_show_childs` bigint(20) unsigned NOT NULL COMMENT 'выводимые допы потомков в строке дерева проектов',
  `tree_calc` bigint(20) unsigned NOT NULL COMMENT 'биты настроек допов',
  `tree_calc_childs` bigint(20) unsigned NOT NULL COMMENT 'биты настроек допов потомков',
  `tree_calc_parents` bigint(20) unsigned NOT NULL COMMENT 'биты настройки форварда допов',
  `rightmenu_childs` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'список строк правого меню на строке',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `rightmenus_upd`
--

CREATE TABLE IF NOT EXISTS `rightmenus_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с заголовком формы',
  `value2` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка с заголовком формы (создание)',
  `form` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'название вызываемой формы',
  `form2` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'параметр вызываемой формы',
  `dops` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `descr` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка описания для админки',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения в правом меню',
  `icon` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'стиль иконки',
  `rightmenu_group` tinyint(3) unsigned NOT NULL COMMENT 'в какой группе правого меню',
  `menu_name` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'строка для меню',
  `transform` tinyint(3) unsigned NOT NULL COMMENT 'в какой тип превращается',
  `form_create` bigint(20) unsigned NOT NULL COMMENT 'биты полей при создании',
  `form_create_required` bigint(20) unsigned NOT NULL COMMENT 'биты обязательных полей при создании',
  `form_edit` bigint(20) unsigned NOT NULL COMMENT 'биты полей при редактировании',
  `form_edit_readonly` bigint(20) unsigned NOT NULL COMMENT 'биты нередактируемых полей при редактировании',
  `form_edit_required` bigint(20) unsigned NOT NULL COMMENT 'биты обязательных полей при редактировании',
  `form_edit_hidden` bigint(20) unsigned NOT NULL COMMENT 'биты закрытых полей при редактировании',
  `tree_show` bigint(20) unsigned NOT NULL COMMENT 'выводимые допы в строке дерева проектов',
  `tree_show_childs` bigint(20) unsigned NOT NULL COMMENT 'выводимые допы потомков в строке дерева проектов',
  `tree_calc` bigint(20) unsigned NOT NULL COMMENT 'биты настроек допов',
  `tree_calc_childs` bigint(20) unsigned NOT NULL COMMENT 'биты настроек допов потомков',
  `tree_calc_parents` bigint(20) unsigned NOT NULL COMMENT 'биты настройки форварда допов',
  `rightmenu_childs` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'список строк правого меню на строке',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `stocks`
--

CREATE TABLE IF NOT EXISTS `stocks` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `type` int(10) unsigned NOT NULL COMMENT 'тип склада',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `manager` int(10) unsigned NOT NULL COMMENT 'ответственный',
  `managers` tinytext COLLATE utf8_bin NOT NULL COMMENT 'CSV список у кого есть допуск',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `dynamic` text COLLATE utf8_bin NOT NULL COMMENT 'динамические поля',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица складов';

-- --------------------------------------------------------

--
-- Структура таблицы `stocks_log`
--

CREATE TABLE IF NOT EXISTS `stocks_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `type` int(10) unsigned NOT NULL COMMENT 'тип склада',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `manager` int(10) unsigned NOT NULL COMMENT 'ответственный',
  `managers` tinytext COLLATE utf8_bin NOT NULL COMMENT 'CSV список у кого есть допуск',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `dynamic` text COLLATE utf8_bin NOT NULL COMMENT 'динамические поля',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `stocks_upd`
--

CREATE TABLE IF NOT EXISTS `stocks_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `type` int(10) unsigned NOT NULL COMMENT 'тип склада',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `manager` int(10) unsigned NOT NULL COMMENT 'ответственный',
  `managers` tinytext COLLATE utf8_bin NOT NULL COMMENT 'CSV список у кого есть допуск',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `dynamic` text COLLATE utf8_bin NOT NULL COMMENT 'динамические поля',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `stocktypes`
--

CREATE TABLE IF NOT EXISTS `stocktypes` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица типов складов';

-- --------------------------------------------------------

--
-- Структура таблицы `stocktypes_log`
--

CREATE TABLE IF NOT EXISTS `stocktypes_log` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `stocktypes_upd`
--

CREATE TABLE IF NOT EXISTS `stocktypes_upd` (
  `id` int(10) unsigned NOT NULL COMMENT 'ID записи',
  `value` tinytext COLLATE utf8_bin NOT NULL COMMENT 'строка с названием',
  `order` tinyint(3) unsigned NOT NULL COMMENT 'порядок отображения, сортировка по возрастанию',
  `uid` int(10) unsigned NOT NULL COMMENT 'кто создавал/редактировал (см. users.id)',
  `upd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'время создания/редактирования'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `system_config`
--

CREATE TABLE IF NOT EXISTS `system_config` (
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `accounts_access`
--
ALTER TABLE `accounts_access`
  ADD PRIMARY KEY (`user_id`,`module_id`,`component_id`);

--
-- Индексы таблицы `accounts_binding`
--
ALTER TABLE `accounts_binding`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `accounts_log`
--
ALTER TABLE `accounts_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `accounts_upd`
--
ALTER TABLE `accounts_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `adm_components`
--
ALTER TABLE `adm_components`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `adm_modules`
--
ALTER TABLE `adm_modules`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `adm_modules_components_assoc`
--
ALTER TABLE `adm_modules_components_assoc`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `adm_systypes`
--
ALTER TABLE `adm_systypes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `bitmasks_0`
--
ALTER TABLE `bitmasks_0`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `bits_0`
--
ALTER TABLE `bits_0`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clients_bindings`
--
ALTER TABLE `clients_bindings`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clients_bindings_log`
--
ALTER TABLE `clients_bindings_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clients_bindings_upd`
--
ALTER TABLE `clients_bindings_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clients_legals`
--
ALTER TABLE `clients_legals`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clients_legals_log`
--
ALTER TABLE `clients_legals_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clients_legals_upd`
--
ALTER TABLE `clients_legals_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clients_names`
--
ALTER TABLE `clients_names`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clients_names_log`
--
ALTER TABLE `clients_names_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clients_names_upd`
--
ALTER TABLE `clients_names_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clients_types`
--
ALTER TABLE `clients_types`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clients_types_log`
--
ALTER TABLE `clients_types_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clients_types_upd`
--
ALTER TABLE `clients_types_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `dyn_fields`
--
ALTER TABLE `dyn_fields`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `dyn_field_forms`
--
ALTER TABLE `dyn_field_forms`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `goods_bindings_0`
--
ALTER TABLE `goods_bindings_0`
  ADD PRIMARY KEY (`id`),
  ADD KEY `int` (`int`),
  ADD KEY `art_id` (`art_id`);

--
-- Индексы таблицы `goods_bindings_0_backup`
--
ALTER TABLE `goods_bindings_0_backup`
  ADD PRIMARY KEY (`id`),
  ADD KEY `int` (`int`),
  ADD KEY `art_id` (`art_id`);

--
-- Индексы таблицы `goods_prices_0`
--
ALTER TABLE `goods_prices_0`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `goods_upload`
--
ALTER TABLE `goods_upload`
  ADD PRIMARY KEY (`id`),
  ADD KEY `art_id` (`art_id`),
  ADD KEY `ok` (`ok`),
  ADD KEY `upd` (`upd`);

--
-- Индексы таблицы `goods_upload_done`
--
ALTER TABLE `goods_upload_done`
  ADD PRIMARY KEY (`art_id`),
  ADD KEY `ok` (`ok`),
  ADD KEY `upd` (`upd`);

--
-- Индексы таблицы `instr_access`
--
ALTER TABLE `instr_access`
  ADD PRIMARY KEY (`user_id`,`user_type`);

--
-- Индексы таблицы `instr_content`
--
ALTER TABLE `instr_content`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `instr_content_upd`
--
ALTER TABLE `instr_content_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `instr_patterns`
--
ALTER TABLE `instr_patterns`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `instr_patterns_upd`
--
ALTER TABLE `instr_patterns_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `instr_tree`
--
ALTER TABLE `instr_tree`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `instr_tree_upd`
--
ALTER TABLE `instr_tree_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `items_0`
--
ALTER TABLE `items_0`
  ADD PRIMARY KEY (`id`),
  ADD KEY `arts` (`arts`(10)),
  ADD FULLTEXT KEY `descr` (`descr`);
ALTER TABLE `items_0`
  ADD FULLTEXT KEY `cats` (`cats`);

--
-- Индексы таблицы `items_0_backup`
--
ALTER TABLE `items_0_backup`
  ADD PRIMARY KEY (`id`),
  ADD KEY `arts` (`arts`(10)),
  ADD FULLTEXT KEY `descr` (`descr`);
ALTER TABLE `items_0_backup`
  ADD FULLTEXT KEY `cats` (`cats`);

--
-- Индексы таблицы `items_0_log`
--
ALTER TABLE `items_0_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `items_0_upd`
--
ALTER TABLE `items_0_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `itemtypes`
--
ALTER TABLE `itemtypes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `itemtypes_log`
--
ALTER TABLE `itemtypes_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `prices`
--
ALTER TABLE `prices`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `prices_log`
--
ALTER TABLE `prices_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `prices_upd`
--
ALTER TABLE `prices_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `pricetypes`
--
ALTER TABLE `pricetypes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `pricetypes_log`
--
ALTER TABLE `pricetypes_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `pricetypes_upd`
--
ALTER TABLE `pricetypes_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `projects_trees`
--
ALTER TABLE `projects_trees`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `projects_trees_log`
--
ALTER TABLE `projects_trees_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `projects_trees_upd`
--
ALTER TABLE `projects_trees_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__admin`
--
ALTER TABLE `project__admin`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__admins`
--
ALTER TABLE `project__admins`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__admins_log`
--
ALTER TABLE `project__admins_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__admins_upd`
--
ALTER TABLE `project__admins_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__admin_log`
--
ALTER TABLE `project__admin_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__admin_upd`
--
ALTER TABLE `project__admin_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__amount_plan`
--
ALTER TABLE `project__amount_plan`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__amount_plan_log`
--
ALTER TABLE `project__amount_plan_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__amount_plan_upd`
--
ALTER TABLE `project__amount_plan_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__amount_ready`
--
ALTER TABLE `project__amount_ready`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__amount_ready_log`
--
ALTER TABLE `project__amount_ready_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__amount_ready_upd`
--
ALTER TABLE `project__amount_ready_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__amount_total`
--
ALTER TABLE `project__amount_total`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__amount_total_log`
--
ALTER TABLE `project__amount_total_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__amount_total_upd`
--
ALTER TABLE `project__amount_total_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__assistant`
--
ALTER TABLE `project__assistant`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__assistant_log`
--
ALTER TABLE `project__assistant_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__assistant_upd`
--
ALTER TABLE `project__assistant_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__carrier_partner`
--
ALTER TABLE `project__carrier_partner`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__carrier_partner_log`
--
ALTER TABLE `project__carrier_partner_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__carrier_partner_upd`
--
ALTER TABLE `project__carrier_partner_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__code`
--
ALTER TABLE `project__code`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__code_log`
--
ALTER TABLE `project__code_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__code_upd`
--
ALTER TABLE `project__code_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__comment`
--
ALTER TABLE `project__comment`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__comment_log`
--
ALTER TABLE `project__comment_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__comment_upd`
--
ALTER TABLE `project__comment_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__creator`
--
ALTER TABLE `project__creator`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__creator_log`
--
ALTER TABLE `project__creator_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__creator_upd`
--
ALTER TABLE `project__creator_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__descr`
--
ALTER TABLE `project__descr`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__descr_log`
--
ALTER TABLE `project__descr_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__descr_upd`
--
ALTER TABLE `project__descr_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__doc_partner_in`
--
ALTER TABLE `project__doc_partner_in`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__doc_partner_in_log`
--
ALTER TABLE `project__doc_partner_in_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__doc_partner_in_upd`
--
ALTER TABLE `project__doc_partner_in_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__doc_partner_out`
--
ALTER TABLE `project__doc_partner_out`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__doc_partner_out_log`
--
ALTER TABLE `project__doc_partner_out_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__doc_partner_out_upd`
--
ALTER TABLE `project__doc_partner_out_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__done`
--
ALTER TABLE `project__done`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__done_log`
--
ALTER TABLE `project__done_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__done_upd`
--
ALTER TABLE `project__done_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_date_end`
--
ALTER TABLE `project__fact_date_end`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_date_end_log`
--
ALTER TABLE `project__fact_date_end_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_date_end_upd`
--
ALTER TABLE `project__fact_date_end_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_date_start`
--
ALTER TABLE `project__fact_date_start`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_date_start_log`
--
ALTER TABLE `project__fact_date_start_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_date_start_upd`
--
ALTER TABLE `project__fact_date_start_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_partner_in`
--
ALTER TABLE `project__fact_partner_in`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_partner_in_log`
--
ALTER TABLE `project__fact_partner_in_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_partner_in_upd`
--
ALTER TABLE `project__fact_partner_in_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_partner_out`
--
ALTER TABLE `project__fact_partner_out`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_partner_out_log`
--
ALTER TABLE `project__fact_partner_out_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_partner_out_upd`
--
ALTER TABLE `project__fact_partner_out_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_price_in`
--
ALTER TABLE `project__fact_price_in`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_price_in_log`
--
ALTER TABLE `project__fact_price_in_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_price_in_upd`
--
ALTER TABLE `project__fact_price_in_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_price_out`
--
ALTER TABLE `project__fact_price_out`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_price_out_log`
--
ALTER TABLE `project__fact_price_out_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_price_out_upd`
--
ALTER TABLE `project__fact_price_out_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_sum_in`
--
ALTER TABLE `project__fact_sum_in`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_sum_in_log`
--
ALTER TABLE `project__fact_sum_in_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_sum_in_upd`
--
ALTER TABLE `project__fact_sum_in_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_sum_out`
--
ALTER TABLE `project__fact_sum_out`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_sum_out_log`
--
ALTER TABLE `project__fact_sum_out_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__fact_sum_out_upd`
--
ALTER TABLE `project__fact_sum_out_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__follower`
--
ALTER TABLE `project__follower`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__follower_log`
--
ALTER TABLE `project__follower_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__follower_upd`
--
ALTER TABLE `project__follower_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_issued`
--
ALTER TABLE `project__info_date_issued`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_issued_log`
--
ALTER TABLE `project__info_date_issued_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_issued_upd`
--
ALTER TABLE `project__info_date_issued_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_notified`
--
ALTER TABLE `project__info_date_notified`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_notified_log`
--
ALTER TABLE `project__info_date_notified_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_notified_upd`
--
ALTER TABLE `project__info_date_notified_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_paid`
--
ALTER TABLE `project__info_date_paid`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_paid_log`
--
ALTER TABLE `project__info_date_paid_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_paid_upd`
--
ALTER TABLE `project__info_date_paid_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_recieved`
--
ALTER TABLE `project__info_date_recieved`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_recieved_log`
--
ALTER TABLE `project__info_date_recieved_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_recieved_upd`
--
ALTER TABLE `project__info_date_recieved_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_send`
--
ALTER TABLE `project__info_date_send`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_send_log`
--
ALTER TABLE `project__info_date_send_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_send_upd`
--
ALTER TABLE `project__info_date_send_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_signed`
--
ALTER TABLE `project__info_date_signed`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_signed_log`
--
ALTER TABLE `project__info_date_signed_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__info_date_signed_upd`
--
ALTER TABLE `project__info_date_signed_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__listener`
--
ALTER TABLE `project__listener`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__listeners`
--
ALTER TABLE `project__listeners`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__listeners_log`
--
ALTER TABLE `project__listeners_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__listeners_upd`
--
ALTER TABLE `project__listeners_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__listener_log`
--
ALTER TABLE `project__listener_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__listener_upd`
--
ALTER TABLE `project__listener_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__manager`
--
ALTER TABLE `project__manager`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__managers`
--
ALTER TABLE `project__managers`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__managers_log`
--
ALTER TABLE `project__managers_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__managers_upd`
--
ALTER TABLE `project__managers_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__manager_log`
--
ALTER TABLE `project__manager_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__manager_upd`
--
ALTER TABLE `project__manager_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__manufacturer_partner`
--
ALTER TABLE `project__manufacturer_partner`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__manufacturer_partner_log`
--
ALTER TABLE `project__manufacturer_partner_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__manufacturer_partner_upd`
--
ALTER TABLE `project__manufacturer_partner_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__name`
--
ALTER TABLE `project__name`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__name_log`
--
ALTER TABLE `project__name_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__name_upd`
--
ALTER TABLE `project__name_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__number`
--
ALTER TABLE `project__number`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__number_log`
--
ALTER TABLE `project__number_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__number_upd`
--
ALTER TABLE `project__number_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_date_end`
--
ALTER TABLE `project__plan_date_end`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_date_end_log`
--
ALTER TABLE `project__plan_date_end_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_date_end_upd`
--
ALTER TABLE `project__plan_date_end_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_date_start`
--
ALTER TABLE `project__plan_date_start`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_date_start_log`
--
ALTER TABLE `project__plan_date_start_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_date_start_upd`
--
ALTER TABLE `project__plan_date_start_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_price_in`
--
ALTER TABLE `project__plan_price_in`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_price_in_log`
--
ALTER TABLE `project__plan_price_in_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_price_in_upd`
--
ALTER TABLE `project__plan_price_in_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_price_out`
--
ALTER TABLE `project__plan_price_out`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_price_out_log`
--
ALTER TABLE `project__plan_price_out_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_price_out_upd`
--
ALTER TABLE `project__plan_price_out_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_sum_in`
--
ALTER TABLE `project__plan_sum_in`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_sum_in_log`
--
ALTER TABLE `project__plan_sum_in_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_sum_in_upd`
--
ALTER TABLE `project__plan_sum_in_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_sum_out`
--
ALTER TABLE `project__plan_sum_out`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_sum_out_log`
--
ALTER TABLE `project__plan_sum_out_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__plan_sum_out_upd`
--
ALTER TABLE `project__plan_sum_out_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__state_doc`
--
ALTER TABLE `project__state_doc`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__state_doc_log`
--
ALTER TABLE `project__state_doc_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__state_doc_upd`
--
ALTER TABLE `project__state_doc_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__state_done`
--
ALTER TABLE `project__state_done`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__state_done_log`
--
ALTER TABLE `project__state_done_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__state_done_upd`
--
ALTER TABLE `project__state_done_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__state_prod`
--
ALTER TABLE `project__state_prod`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__state_prod_log`
--
ALTER TABLE `project__state_prod_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__state_prod_upd`
--
ALTER TABLE `project__state_prod_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__state_sell`
--
ALTER TABLE `project__state_sell`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__state_sell_log`
--
ALTER TABLE `project__state_sell_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__state_sell_upd`
--
ALTER TABLE `project__state_sell_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__transit_partner`
--
ALTER TABLE `project__transit_partner`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__transit_partner_log`
--
ALTER TABLE `project__transit_partner_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__transit_partner_upd`
--
ALTER TABLE `project__transit_partner_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__worker`
--
ALTER TABLE `project__worker`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__workers`
--
ALTER TABLE `project__workers`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__workers_log`
--
ALTER TABLE `project__workers_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__workers_upd`
--
ALTER TABLE `project__workers_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__worker_log`
--
ALTER TABLE `project__worker_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `project__worker_upd`
--
ALTER TABLE `project__worker_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `rightmenugroups`
--
ALTER TABLE `rightmenugroups`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `rightmenus`
--
ALTER TABLE `rightmenus`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `stocks_log`
--
ALTER TABLE `stocks_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `stocks_upd`
--
ALTER TABLE `stocks_upd`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `stocktypes`
--
ALTER TABLE `stocktypes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `stocktypes_log`
--
ALTER TABLE `stocktypes_log`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `stocktypes_upd`
--
ALTER TABLE `stocktypes_upd`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `accounts_binding`
--
ALTER TABLE `accounts_binding`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `adm_components`
--
ALTER TABLE `adm_components`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `adm_modules`
--
ALTER TABLE `adm_modules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `adm_modules_components_assoc`
--
ALTER TABLE `adm_modules_components_assoc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `adm_systypes`
--
ALTER TABLE `adm_systypes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `bitmasks_0`
--
ALTER TABLE `bitmasks_0`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `clients_bindings`
--
ALTER TABLE `clients_bindings`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `clients_legals`
--
ALTER TABLE `clients_legals`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `clients_names`
--
ALTER TABLE `clients_names`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `clients_types`
--
ALTER TABLE `clients_types`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `goods_bindings_0`
--
ALTER TABLE `goods_bindings_0`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `goods_bindings_0_backup`
--
ALTER TABLE `goods_bindings_0_backup`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `goods_upload`
--
ALTER TABLE `goods_upload`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `instr_content`
--
ALTER TABLE `instr_content`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `instr_patterns`
--
ALTER TABLE `instr_patterns`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `instr_tree`
--
ALTER TABLE `instr_tree`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `items_0`
--
ALTER TABLE `items_0`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `items_0_backup`
--
ALTER TABLE `items_0_backup`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `itemtypes`
--
ALTER TABLE `itemtypes`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `prices`
--
ALTER TABLE `prices`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `prices_log`
--
ALTER TABLE `prices_log`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `prices_upd`
--
ALTER TABLE `prices_upd`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `pricetypes`
--
ALTER TABLE `pricetypes`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `pricetypes_log`
--
ALTER TABLE `pricetypes_log`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `pricetypes_upd`
--
ALTER TABLE `pricetypes_upd`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `projects_trees`
--
ALTER TABLE `projects_trees`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__admin`
--
ALTER TABLE `project__admin`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__admins`
--
ALTER TABLE `project__admins`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__amount_plan`
--
ALTER TABLE `project__amount_plan`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__amount_ready`
--
ALTER TABLE `project__amount_ready`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__amount_total`
--
ALTER TABLE `project__amount_total`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__assistant`
--
ALTER TABLE `project__assistant`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__carrier_partner`
--
ALTER TABLE `project__carrier_partner`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__code`
--
ALTER TABLE `project__code`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__comment`
--
ALTER TABLE `project__comment`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__creator`
--
ALTER TABLE `project__creator`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__descr`
--
ALTER TABLE `project__descr`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__doc_partner_in`
--
ALTER TABLE `project__doc_partner_in`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__doc_partner_out`
--
ALTER TABLE `project__doc_partner_out`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__done`
--
ALTER TABLE `project__done`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__fact_date_end`
--
ALTER TABLE `project__fact_date_end`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__fact_date_start`
--
ALTER TABLE `project__fact_date_start`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__fact_partner_in`
--
ALTER TABLE `project__fact_partner_in`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__fact_partner_out`
--
ALTER TABLE `project__fact_partner_out`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__fact_price_in`
--
ALTER TABLE `project__fact_price_in`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__fact_price_out`
--
ALTER TABLE `project__fact_price_out`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__fact_sum_in`
--
ALTER TABLE `project__fact_sum_in`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__fact_sum_out`
--
ALTER TABLE `project__fact_sum_out`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__follower`
--
ALTER TABLE `project__follower`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__info_date_issued`
--
ALTER TABLE `project__info_date_issued`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__info_date_notified`
--
ALTER TABLE `project__info_date_notified`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__info_date_paid`
--
ALTER TABLE `project__info_date_paid`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__info_date_recieved`
--
ALTER TABLE `project__info_date_recieved`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__info_date_send`
--
ALTER TABLE `project__info_date_send`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__info_date_signed`
--
ALTER TABLE `project__info_date_signed`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__listener`
--
ALTER TABLE `project__listener`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__listeners`
--
ALTER TABLE `project__listeners`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__manager`
--
ALTER TABLE `project__manager`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__managers`
--
ALTER TABLE `project__managers`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__manufacturer_partner`
--
ALTER TABLE `project__manufacturer_partner`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__name`
--
ALTER TABLE `project__name`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__number`
--
ALTER TABLE `project__number`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__plan_date_end`
--
ALTER TABLE `project__plan_date_end`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__plan_date_start`
--
ALTER TABLE `project__plan_date_start`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__plan_price_in`
--
ALTER TABLE `project__plan_price_in`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__plan_price_out`
--
ALTER TABLE `project__plan_price_out`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__plan_sum_in`
--
ALTER TABLE `project__plan_sum_in`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__plan_sum_out`
--
ALTER TABLE `project__plan_sum_out`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__state_doc`
--
ALTER TABLE `project__state_doc`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__state_done`
--
ALTER TABLE `project__state_done`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__state_prod`
--
ALTER TABLE `project__state_prod`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__state_sell`
--
ALTER TABLE `project__state_sell`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__transit_partner`
--
ALTER TABLE `project__transit_partner`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__worker`
--
ALTER TABLE `project__worker`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `project__workers`
--
ALTER TABLE `project__workers`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `rightmenus`
--
ALTER TABLE `rightmenus`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `stocks`
--
ALTER TABLE `stocks`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `stocks_log`
--
ALTER TABLE `stocks_log`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `stocks_upd`
--
ALTER TABLE `stocks_upd`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `stocktypes`
--
ALTER TABLE `stocktypes`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `stocktypes_log`
--
ALTER TABLE `stocktypes_log`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
--
-- AUTO_INCREMENT для таблицы `stocktypes_upd`
--
ALTER TABLE `stocktypes_upd`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID записи';
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
