-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 11. Jul 2020 um 16:27
-- Server-Version: 10.4.13-MariaDB
-- PHP-Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `cr09_rebecca_schedler_delivery`
--
CREATE DATABASE IF NOT EXISTS `cr09_rebecca_schedler_delivery` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `cr09_rebecca_schedler_delivery`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `delivery_process`
--

CREATE TABLE `delivery_process` (
  `process_id` int(10) UNSIGNED NOT NULL,
  `send_time` date DEFAULT NULL,
  `delivery_time` date DEFAULT NULL,
  `fk_sender_id` int(11) UNSIGNED NOT NULL,
  `fk_recipient_id` int(11) UNSIGNED NOT NULL,
  `fk_mail_id` int(11) UNSIGNED NOT NULL,
  `fk_status_id` smallint(5) UNSIGNED NOT NULL,
  `fk_po_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `delivery_process`
--

INSERT INTO `delivery_process` (`process_id`, `send_time`, `delivery_time`, `fk_sender_id`, `fk_recipient_id`, `fk_mail_id`, `fk_status_id`, `fk_po_id`) VALUES
(1, '2020-07-11', NULL, 9, 4, 3, 1, 3),
(2, '2020-07-02', '2020-07-06', 12, 5, 1, 7, 4),
(3, '2020-07-08', '2020-07-11', 7, 2, 5, 6, 5),
(4, '2020-07-01', NULL, 4, 3, 3, 4, 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `delivery_request`
--

CREATE TABLE `delivery_request` (
  `delivery_request_id` smallint(5) UNSIGNED NOT NULL,
  `request_description` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `delivery_request`
--

INSERT INTO `delivery_request` (`delivery_request_id`, `request_description`) VALUES
(1, 'in Mailbox'),
(2, 'on doorstep'),
(3, 'nearest pick-up station'),
(4, 'nearest postal-office'),
(5, 'throw in river');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `delivery_status`
--

CREATE TABLE `delivery_status` (
  `status_id` smallint(5) UNSIGNED NOT NULL,
  `status_description` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `delivery_status`
--

INSERT INTO `delivery_status` (`status_id`, `status_description`) VALUES
(1, 'mail received'),
(2, 'mail beeing processed'),
(3, 'mail in distribution center'),
(4, 'mail on the road'),
(5, 'mail will be delivered today'),
(6, 'mail is at pick-up center'),
(7, 'mail delivered');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mail`
--

CREATE TABLE `mail` (
  `mail_id` int(10) UNSIGNED NOT NULL,
  `type_size` varchar(55) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `shipment_type` enum('domestic','foreign') DEFAULT 'domestic'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `mail`
--

INSERT INTO `mail` (`mail_id`, `type_size`, `weight`, `shipment_type`) VALUES
(1, 'DIN C6', 10, 'domestic'),
(2, 'DIN lang C5', 15, 'domestic'),
(3, 'DIN B4', 30, 'foreign'),
(4, 'small package', 1200, 'domestic'),
(5, 'big package', 30000, 'domestic'),
(6, 'DIN C5', 30, 'foreign');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `postal_employee`
--

CREATE TABLE `postal_employee` (
  `employee_id` int(11) UNSIGNED NOT NULL,
  `first_name` varchar(55) DEFAULT NULL,
  `last_name` varchar(55) DEFAULT NULL,
  `function` varchar(55) DEFAULT NULL,
  `office_phone` int(11) DEFAULT NULL,
  `fk_po_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `postal_employee`
--

INSERT INTO `postal_employee` (`employee_id`, `first_name`, `last_name`, `function`, `office_phone`, `fk_po_id`) VALUES
(1, 'Rita', 'Tanner', 'Counter', 1267543297, 3),
(2, 'Ulrike', 'Müller', 'post man', 1267543297, 3),
(3, 'Vannessa', 'Kleinbauer', 'Truck driver', 126754324, 3),
(4, 'Hans', 'im Glück', 'Janitor', 1267543235, 4),
(5, 'Fritz', 'Fritz', 'post man', 2342537, 1),
(6, 'Jacob', 'Maier', 'truck driver', 235678, 1),
(7, 'Elke', 'Tyroler', 'truck driver', 2342537, 6),
(8, 'Maria', 'Scherer', 'Logistic Manager', 23567834, 6),
(9, 'Michael', 'Geissen', 'janitor', 234253743, 5),
(10, 'Dalia', 'Fritz-Müller', 'Counter', 23567834, 4),
(11, 'Dominik', 'Geissen', 'Janitor', 2342537, 2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `postal_office`
--

CREATE TABLE `postal_office` (
  `po_id` int(11) UNSIGNED NOT NULL,
  `name` varchar(55) DEFAULT NULL,
  `fk_po_address_id` int(11) UNSIGNED NOT NULL,
  `fk_po_type_id` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `postal_office`
--

INSERT INTO `postal_office` (`po_id`, `name`, `fk_po_address_id`, `fk_po_type_id`) VALUES
(1, 'Post Ringstrasse', 1, 1),
(2, 'Post pick-up Alpenweg', 5, 2),
(3, 'Post Fürstenweg', 3, 1),
(4, 'Post Tannenweg', 2, 3),
(5, 'Post pick-up Schwedenplatz', 4, 2),
(6, 'Distribution Center Landeck', 6, 4);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `po_address`
--

CREATE TABLE `po_address` (
  `po_address_id` int(11) UNSIGNED NOT NULL,
  `street_name` varchar(55) DEFAULT NULL,
  `house_number` int(11) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `city_name` varchar(55) DEFAULT NULL,
  `country` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `po_address`
--

INSERT INTO `po_address` (`po_address_id`, `street_name`, `house_number`, `zip`, `city_name`, `country`) VALUES
(1, 'Ringstrasse', 78, 1010, 'Vienna', 'Austria'),
(2, 'Tannenweg', 12, 6020, 'Innsbruck', 'Austria'),
(3, 'Fürstenweg', 2, 6020, 'Innsbruck', 'Austria'),
(4, 'Schwedenplatz', 75, 1020, 'Wien', 'Austria'),
(5, 'Alpenweg', 5, 6019, 'Stubai', 'Austria'),
(6, 'Hauptstrasse', 56, 6753, 'Landeck', 'Austria');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `po_type`
--

CREATE TABLE `po_type` (
  `po_type_id` smallint(5) UNSIGNED NOT NULL,
  `po_type_description` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `po_type`
--

INSERT INTO `po_type` (`po_type_id`, `po_type_description`) VALUES
(1, 'Full Service'),
(2, 'only pick-up'),
(3, 'only sending'),
(4, 'distribution center');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `recipient`
--

CREATE TABLE `recipient` (
  `recipient_id` int(11) UNSIGNED NOT NULL,
  `first_name` varchar(55) DEFAULT NULL,
  `last_name` varchar(55) DEFAULT NULL,
  `fk_r_address_id` int(11) UNSIGNED NOT NULL,
  `fk_request_id` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `recipient`
--

INSERT INTO `recipient` (`recipient_id`, `first_name`, `last_name`, `fk_r_address_id`, `fk_request_id`) VALUES
(1, 'Peter', 'Habsburg', 1, 2),
(2, 'Sissi', 'Kaiserin', 2, 3),
(3, 'Jan', 'Müller', 4, 5),
(4, 'Urs', 'Studer', 5, 1),
(5, 'Seppl', 'Hoffmann', 6, 4),
(6, 'Charlotte', 'Thaler', 3, 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `r_address`
--

CREATE TABLE `r_address` (
  `r_address_id` int(11) UNSIGNED NOT NULL,
  `street_name` varchar(55) DEFAULT NULL,
  `house_number` int(11) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `city_name` varchar(55) DEFAULT NULL,
  `country` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `r_address`
--

INSERT INTO `r_address` (`r_address_id`, `street_name`, `house_number`, `zip`, `city_name`, `country`) VALUES
(1, 'Kaiserallee', 355, 1020, 'Vienna', 'Austria'),
(2, 'Schönbrunnerplatz', 3, 1023, 'Vienna', 'Austria'),
(3, 'Mozartstrasse', 40, 3400, 'Salzburg', 'Austria'),
(4, 'Coolestrasse', 59, 25873, 'Berlin', 'Germany'),
(5, 'Schaffhauserstrasse', 455, 8052, 'Zürich', 'Switzerland'),
(6, 'Hinter-den-Bergen', 33, 87459, 'München', 'Germany');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `sender`
--

CREATE TABLE `sender` (
  `sender_id` int(11) UNSIGNED NOT NULL,
  `first_name` varchar(55) DEFAULT NULL,
  `last_name` varchar(55) DEFAULT NULL,
  `fk_s_address_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `sender`
--

INSERT INTO `sender` (`sender_id`, `first_name`, `last_name`, `fk_s_address_id`) VALUES
(3, 'Heidi', 'Tanner', 1),
(4, 'Heidi', 'Tanner', 1),
(5, 'Peter', 'Geissen', 3),
(6, 'Peter', 'Geissen', 3),
(7, 'Grossvater', 'von de Heidi', 4),
(8, 'Grossvater', 'von de Heidi', 4),
(9, 'Clara', 'Deutsch', 6),
(10, 'Clara', 'Deutsch', 6),
(11, 'Fritz', 'Fritz', 8),
(12, 'Engelbert', 'Schallert', 9),
(13, 'Johnny', 'Autobahn', 7),
(14, 'Engelbert', 'Schallert', 4);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `s_address`
--

CREATE TABLE `s_address` (
  `s_address_id` int(11) UNSIGNED NOT NULL,
  `street_name` varchar(55) DEFAULT NULL,
  `house_number` int(11) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `city_name` varchar(55) DEFAULT NULL,
  `country` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `s_address`
--

INSERT INTO `s_address` (`s_address_id`, `street_name`, `house_number`, `zip`, `city_name`, `country`) VALUES
(1, 'Tannenweg', 4, 6020, 'Innsbruck', 'Austria'),
(3, 'Enzianstrasse', 26, 6020, 'Innsbruck', 'Austria'),
(4, 'Enzianstrasse', 16, 6020, 'Innsbruck', 'Austria'),
(6, 'Edelweissgasse', 67, 6019, 'Landeck', 'Austria'),
(7, 'Brennerautobahn', 245, 6021, 'Stubai', 'Austria'),
(8, 'Fürstenweg', 8, 6020, 'Innsbruck', 'Austria'),
(9, 'Studa', NULL, 6708, 'Brand', NULL);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `delivery_process`
--
ALTER TABLE `delivery_process`
  ADD PRIMARY KEY (`process_id`),
  ADD KEY `fk_sender_id` (`fk_sender_id`),
  ADD KEY `fk_recipient_id` (`fk_recipient_id`),
  ADD KEY `fk_mail_id` (`fk_mail_id`),
  ADD KEY `fk_po_id` (`fk_po_id`),
  ADD KEY `fk_status_id` (`fk_status_id`);

--
-- Indizes für die Tabelle `delivery_request`
--
ALTER TABLE `delivery_request`
  ADD PRIMARY KEY (`delivery_request_id`);

--
-- Indizes für die Tabelle `delivery_status`
--
ALTER TABLE `delivery_status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indizes für die Tabelle `mail`
--
ALTER TABLE `mail`
  ADD PRIMARY KEY (`mail_id`);

--
-- Indizes für die Tabelle `postal_employee`
--
ALTER TABLE `postal_employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD KEY `fk_po_id` (`fk_po_id`);

--
-- Indizes für die Tabelle `postal_office`
--
ALTER TABLE `postal_office`
  ADD PRIMARY KEY (`po_id`),
  ADD KEY `fk_po_address_id` (`fk_po_address_id`),
  ADD KEY `fk_po_type_id` (`fk_po_type_id`);

--
-- Indizes für die Tabelle `po_address`
--
ALTER TABLE `po_address`
  ADD PRIMARY KEY (`po_address_id`);

--
-- Indizes für die Tabelle `po_type`
--
ALTER TABLE `po_type`
  ADD PRIMARY KEY (`po_type_id`);

--
-- Indizes für die Tabelle `recipient`
--
ALTER TABLE `recipient`
  ADD PRIMARY KEY (`recipient_id`),
  ADD KEY `fk_r_address_id` (`fk_r_address_id`),
  ADD KEY `fk_request_id` (`fk_request_id`);

--
-- Indizes für die Tabelle `r_address`
--
ALTER TABLE `r_address`
  ADD PRIMARY KEY (`r_address_id`);

--
-- Indizes für die Tabelle `sender`
--
ALTER TABLE `sender`
  ADD PRIMARY KEY (`sender_id`),
  ADD KEY `fk_s_address_id` (`fk_s_address_id`);

--
-- Indizes für die Tabelle `s_address`
--
ALTER TABLE `s_address`
  ADD PRIMARY KEY (`s_address_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `delivery_process`
--
ALTER TABLE `delivery_process`
  MODIFY `process_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `delivery_request`
--
ALTER TABLE `delivery_request`
  MODIFY `delivery_request_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `delivery_status`
--
ALTER TABLE `delivery_status`
  MODIFY `status_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT für Tabelle `mail`
--
ALTER TABLE `mail`
  MODIFY `mail_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `postal_employee`
--
ALTER TABLE `postal_employee`
  MODIFY `employee_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT für Tabelle `postal_office`
--
ALTER TABLE `postal_office`
  MODIFY `po_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `po_address`
--
ALTER TABLE `po_address`
  MODIFY `po_address_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `po_type`
--
ALTER TABLE `po_type`
  MODIFY `po_type_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `recipient`
--
ALTER TABLE `recipient`
  MODIFY `recipient_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `r_address`
--
ALTER TABLE `r_address`
  MODIFY `r_address_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `sender`
--
ALTER TABLE `sender`
  MODIFY `sender_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT für Tabelle `s_address`
--
ALTER TABLE `s_address`
  MODIFY `s_address_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `delivery_process`
--
ALTER TABLE `delivery_process`
  ADD CONSTRAINT `delivery_process_ibfk_1` FOREIGN KEY (`fk_sender_id`) REFERENCES `sender` (`sender_id`),
  ADD CONSTRAINT `delivery_process_ibfk_2` FOREIGN KEY (`fk_recipient_id`) REFERENCES `recipient` (`recipient_id`),
  ADD CONSTRAINT `delivery_process_ibfk_3` FOREIGN KEY (`fk_mail_id`) REFERENCES `mail` (`mail_id`),
  ADD CONSTRAINT `delivery_process_ibfk_4` FOREIGN KEY (`fk_po_id`) REFERENCES `postal_office` (`po_id`),
  ADD CONSTRAINT `delivery_process_ibfk_5` FOREIGN KEY (`fk_status_id`) REFERENCES `delivery_status` (`status_id`);

--
-- Constraints der Tabelle `postal_employee`
--
ALTER TABLE `postal_employee`
  ADD CONSTRAINT `postal_employee_ibfk_1` FOREIGN KEY (`fk_po_id`) REFERENCES `postal_office` (`po_id`);

--
-- Constraints der Tabelle `postal_office`
--
ALTER TABLE `postal_office`
  ADD CONSTRAINT `postal_office_ibfk_1` FOREIGN KEY (`fk_po_address_id`) REFERENCES `po_address` (`po_address_id`),
  ADD CONSTRAINT `postal_office_ibfk_2` FOREIGN KEY (`fk_po_type_id`) REFERENCES `po_type` (`po_type_id`);

--
-- Constraints der Tabelle `recipient`
--
ALTER TABLE `recipient`
  ADD CONSTRAINT `recipient_ibfk_1` FOREIGN KEY (`fk_r_address_id`) REFERENCES `r_address` (`r_address_id`),
  ADD CONSTRAINT `recipient_ibfk_2` FOREIGN KEY (`fk_request_id`) REFERENCES `delivery_request` (`delivery_request_id`);

--
-- Constraints der Tabelle `sender`
--
ALTER TABLE `sender`
  ADD CONSTRAINT `sender_ibfk_1` FOREIGN KEY (`fk_s_address_id`) REFERENCES `s_address` (`s_address_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
