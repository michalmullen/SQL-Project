-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 01, 2020 at 09:18 AM
-- Server version: 5.6.34-log
-- PHP Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `skolka`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `child_attendance` (IN `id_child` INT(10))  SELECT child.first_name AS 'child', count(attendance.present) AS 'days present'
FROM child, attendance
where  child.id = id_child
and child.id = attendance.child_id
group by (child.id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `child_events` ()  SELECT child.first_name AS 'child name', child.last_name AS 'child surname', GROUP_CONCAT(event.name) AS 'event'
FROM child
JOIN child_event ON child.id = child_event.child_id
JOIN event ON event.id = child_event.event_id
GROUP BY (child.first_name)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `child_guardians` ()  SELECT c.first_name as 'child', GROUP_CONCAT(guardian.first_name) as 'guardian'
FROM guardian
JOIN child_guardian cg on guardian.id = cg.guardian_id
JOIN child c on c.id = cg.child_id
group by c.first_name$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `child_teacher_count` ()  SELECT
  (SELECT COUNT(*) FROM child WHERE child.id) as 'child',
  (SELECT COUNT(*) FROM teacher WHERE teacher.id) as 'teacher'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `child_unpaid_event_fee` ()  SELECT child.first_name AS 'child name', child.last_name AS 'child surname', GROUP_CONCAT(event.name) AS 'event'
FROM child
JOIN child_event ON child.id = child_event.child_id
JOIN event ON event.id = child_event.event_id
where fee = 0
GROUP BY (child.first_name)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `teacher_classes` ()  SELECT teacher.first_name as 'teacher', GROUP_CONCAT(class.name) as 'class'
From class
JOIN class_schedule cs on class.id = cs.class_id
JOIN teacher ON teacher.id = cs.teacher_id
group by (teacher.first_name)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `teacher_class_schedul` ()  SELECT teacher.first_name as 'teacher', class.name as 'class', day.name as 'day', cs.start_time as 'start', cs.end_time as 'end'
From class
JOIN class_schedule cs on class.id = cs.class_id
JOIN teacher ON teacher.id = cs.teacher_id
JOIN day on day.id = cs.day_id
group by (cs.id)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `day` date NOT NULL DEFAULT '0000-00-00',
  `child_id` int(11) NOT NULL DEFAULT '0',
  `present` tinyint(1) DEFAULT NULL,
  `leave_time` time DEFAULT '16:00:00',
  `context` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`day`, `child_id`, `present`, `leave_time`, `context`) VALUES
('2019-04-18', 78, 1, '16:00:00', NULL),
('2019-04-21', 5, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer'),
('2019-04-26', 18, 0, NULL, 'Lorem ipsum'),
('2019-04-26', 36, 1, '16:00:00', NULL),
('2019-04-26', 92, 1, '16:00:00', NULL),
('2019-05-05', 6, 1, '16:00:00', NULL),
('2019-05-07', 2, 0, NULL, 'Lorem'),
('2019-05-09', 7, 1, '16:00:00', NULL),
('2019-05-09', 71, 1, '16:00:00', NULL),
('2019-05-09', 86, 0, NULL, 'Lorem ipsum'),
('2019-05-12', 18, 1, '16:00:00', NULL),
('2019-05-13', 59, 1, '16:00:00', NULL),
('2019-05-15', 95, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'),
('2019-05-28', 86, 1, '16:00:00', NULL),
('2019-05-31', 48, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed'),
('2019-06-02', 85, 0, NULL, 'Lorem'),
('2019-06-08', 9, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur'),
('2019-06-08', 54, 1, '16:00:00', NULL),
('2019-06-11', 83, 1, '16:00:00', NULL),
('2019-06-27', 12, 1, '16:00:00', NULL),
('2019-06-29', 44, 1, '16:00:00', NULL),
('2019-07-04', 50, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur'),
('2019-07-04', 56, 1, '16:00:00', NULL),
('2019-07-20', 69, 1, '16:00:00', NULL),
('2019-07-24', 41, 1, '16:00:00', NULL),
('2019-07-24', 65, 1, '16:00:00', NULL),
('2019-07-29', 98, 1, '16:00:00', NULL),
('2019-08-09', 39, 1, '16:00:00', NULL),
('2019-08-19', 56, 1, '16:00:00', NULL),
('2019-08-19', 74, 1, '16:00:00', NULL),
('2019-08-22', 11, 1, '16:00:00', NULL),
('2019-08-24', 52, 1, '16:00:00', NULL),
('2019-08-27', 71, 1, '16:00:00', NULL),
('2019-09-11', 48, 1, '16:00:00', NULL),
('2019-09-18', 11, 1, '16:00:00', NULL),
('2019-09-22', 49, 0, NULL, 'Lorem ipsum dolor sit amet,'),
('2019-09-23', 64, 1, '16:00:00', NULL),
('2019-10-02', 8, 1, '16:00:00', NULL),
('2019-10-07', 97, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur'),
('2019-10-11', 57, 1, '16:00:00', NULL),
('2019-10-12', 92, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing'),
('2019-10-14', 43, 1, '16:00:00', NULL),
('2019-10-30', 88, 1, '16:00:00', NULL),
('2019-10-31', 82, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer'),
('2019-11-03', 49, 1, '16:00:00', NULL),
('2019-11-03', 52, 1, '16:00:00', NULL),
('2019-11-05', 87, 1, '12:00:00', 'Lorem'),
('2019-11-06', 18, 1, '12:00:00', 'Lorem'),
('2019-11-15', 26, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed'),
('2019-11-21', 15, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer adipiscing'),
('2019-12-05', 13, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'),
('2019-12-05', 75, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'),
('2019-12-12', 88, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer'),
('2019-12-14', 83, 1, '12:00:00', 'Lorem ipsum dolor sit amet,'),
('2019-12-15', 87, 1, '12:00:00', 'Lorem'),
('2019-12-18', 72, 1, '12:00:00', 'Lorem ipsum'),
('2019-12-20', 67, 1, '12:00:00', 'Lorem ipsum dolor'),
('2019-12-20', 83, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed'),
('2019-12-22', 92, 1, '12:00:00', 'Lorem ipsum dolor sit'),
('2019-12-28', 2, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer'),
('2020-01-03', 54, 0, NULL, 'Lorem ipsum dolor sit'),
('2020-01-13', 58, 0, NULL, 'Lorem ipsum'),
('2020-01-16', 59, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'),
('2020-01-24', 63, 0, NULL, 'Lorem ipsum'),
('2020-01-25', 48, 1, '12:00:00', 'Lorem ipsum'),
('2020-01-27', 7, 1, '12:00:00', 'Lorem'),
('2020-01-28', 71, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing'),
('2020-02-05', 36, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed'),
('2020-02-05', 99, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur'),
('2020-02-06', 69, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer adipiscing'),
('2020-02-14', 68, 0, NULL, 'Lorem ipsum dolor'),
('2020-02-23', 9, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'),
('2020-02-23', 84, 1, '12:00:00', 'Lorem'),
('2020-02-25', 48, 0, NULL, 'Lorem ipsum dolor'),
('2020-02-28', 2, 1, '12:00:00', 'Lorem'),
('2020-02-29', 13, 1, '16:00:00', NULL),
('2020-03-04', 19, 1, '16:00:00', NULL),
('2020-03-08', 82, 1, '16:00:00', NULL),
('2020-03-12', 11, 0, NULL, 'Lorem'),
('2020-03-13', 52, 0, NULL, 'Lorem ipsum dolor sit'),
('2020-03-13', 99, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed'),
('2020-03-16', 63, 1, '16:00:00', NULL),
('2020-03-27', 51, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur'),
('2020-04-03', 78, 1, '16:00:00', NULL),
('2020-04-09', 55, 1, '16:00:00', NULL),
('2020-04-12', 83, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur'),
('2020-04-16', 84, 1, '16:00:00', NULL),
('2020-04-18', 43, 1, '16:00:00', NULL),
('2020-04-19', 76, 1, '16:00:00', NULL),
('2020-04-22', 46, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur'),
('2020-04-26', 33, 0, NULL, 'Lorem'),
('2020-04-30', 27, 1, '16:00:00', NULL),
('2020-05-05', 60, 1, '16:00:00', NULL),
('2020-05-09', 50, 1, '16:00:00', NULL),
('2020-05-14', 72, 1, '16:00:00', NULL),
('2020-05-15', 15, 1, '16:00:00', NULL),
('2020-05-16', 39, 1, '16:00:00', NULL),
('2020-05-20', 68, 1, '16:00:00', NULL),
('2020-05-24', 49, 1, '16:00:00', NULL),
('2020-05-29', 70, 1, '16:00:00', NULL),
('2020-05-31', 18, 1, '16:00:00', NULL),
('2020-06-02', 95, 1, '16:00:00', NULL),
('2020-06-05', 78, 1, '16:00:00', NULL),
('2020-06-06', 7, 1, '16:00:00', NULL),
('2020-06-29', 86, 1, '16:00:00', NULL),
('2020-07-05', 34, 1, '16:00:00', NULL),
('2020-07-06', 52, 1, '16:00:00', NULL),
('2020-07-07', 74, 1, '16:00:00', NULL),
('2020-07-10', 94, 0, NULL, 'Lorem'),
('2020-07-11', 13, 1, '16:00:00', NULL),
('2020-07-29', 31, 1, '16:00:00', NULL),
('2020-07-31', 37, 1, '16:00:00', NULL),
('2020-08-01', 38, 1, '16:00:00', NULL),
('2020-08-04', 81, 1, '16:00:00', NULL),
('2020-08-04', 98, 1, '16:00:00', NULL),
('2020-08-06', 9, 1, '16:00:00', NULL),
('2020-08-06', 32, 1, '12:00:00', 'Lorem ipsum dolor'),
('2020-08-06', 55, 1, '12:00:00', 'Lorem ipsum dolor sit'),
('2020-08-06', 79, 1, '12:00:00', 'Lorem ipsum'),
('2020-08-09', 65, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'),
('2020-08-15', 19, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur'),
('2020-08-15', 50, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur'),
('2020-08-16', 3, 1, '12:00:00', 'Lorem ipsum dolor sit amet,'),
('2020-08-20', 59, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer'),
('2020-08-25', 62, 1, '12:00:00', 'Lorem ipsum dolor sit'),
('2020-08-27', 42, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur'),
('2020-08-28', 3, 1, '12:00:00', 'Lorem'),
('2020-08-29', 96, 1, '12:00:00', 'Lorem'),
('2020-08-30', 24, 1, '12:00:00', 'Lorem ipsum dolor sit'),
('2020-08-30', 94, 1, '12:00:00', 'Lorem ipsum dolor sit amet,'),
('2020-08-31', 35, 1, '12:00:00', 'Lorem'),
('2020-09-10', 9, 1, '12:00:00', 'Lorem ipsum dolor sit amet,'),
('2020-09-10', 42, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed'),
('2020-09-11', 54, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer'),
('2020-09-11', 80, 1, '12:00:00', 'Lorem'),
('2020-09-12', 55, 1, '12:00:00', 'Lorem ipsum dolor'),
('2020-09-13', 71, 1, '12:00:00', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'),
('2020-09-14', 95, 1, '16:00:00', NULL),
('2020-09-16', 80, 1, '16:00:00', NULL),
('2020-09-17', 2, 1, '16:00:00', NULL),
('2020-09-17', 25, 1, '16:00:00', NULL),
('2020-09-20', 62, 1, '16:00:00', NULL),
('2020-09-23', 38, 1, '16:00:00', NULL),
('2020-09-24', 90, 1, '16:00:00', NULL),
('2020-09-27', 30, 1, '16:00:00', NULL),
('2020-09-30', 93, 1, '16:00:00', NULL),
('2020-10-05', 45, 0, NULL, 'Lorem'),
('2020-10-09', 27, 1, '16:00:00', NULL),
('2020-10-10', 1, 1, '16:00:00', NULL),
('2020-10-25', 51, 1, '16:00:00', NULL),
('2020-10-29', 19, 1, '16:00:00', NULL),
('2020-10-29', 25, 1, '16:00:00', NULL),
('2020-10-31', 18, 1, '16:00:00', NULL),
('2020-11-02', 39, 1, '16:00:00', NULL),
('2020-11-08', 80, 1, '16:00:00', NULL),
('2020-11-14', 45, 1, '16:00:00', NULL),
('2020-11-15', 57, 1, '16:00:00', NULL),
('2020-11-19', 78, 1, '16:00:00', NULL),
('2020-11-21', 47, 1, '16:00:00', NULL),
('2020-11-23', 10, 1, '16:00:00', NULL),
('2020-11-25', 83, 1, '16:00:00', NULL),
('2020-11-25', 98, 1, '16:00:00', NULL),
('2020-11-26', 62, 1, '16:00:00', NULL),
('2020-11-30', 65, 1, '16:00:00', NULL),
('2020-12-04', 96, 1, '16:00:00', NULL),
('2020-12-20', 54, 1, '16:00:00', NULL),
('2020-12-23', 29, 1, '16:00:00', NULL),
('2021-01-03', 11, 1, '16:00:00', NULL),
('2021-01-04', 72, 1, '16:00:00', NULL),
('2021-01-05', 75, 1, '16:00:00', NULL),
('2021-01-07', 34, 1, '16:00:00', NULL),
('2021-01-16', 7, 1, '16:00:00', NULL),
('2021-01-16', 73, 1, '16:00:00', NULL),
('2021-01-17', 65, 1, '16:00:00', NULL),
('2021-01-23', 20, 1, '16:00:00', NULL),
('2021-01-23', 76, 1, '16:00:00', NULL),
('2021-01-24', 9, 1, '16:00:00', NULL),
('2021-01-24', 19, 1, '16:00:00', NULL),
('2021-02-02', 82, 1, '16:00:00', NULL),
('2021-02-06', 54, 1, '16:00:00', NULL),
('2021-02-08', 64, 1, '16:00:00', NULL),
('2021-02-18', 25, 0, NULL, 'Lorem ipsum dolor sit amet, consectetuer'),
('2021-02-20', 35, 1, '16:00:00', NULL),
('2021-02-21', 35, 1, '16:00:00', NULL),
('2021-02-23', 20, 1, '16:00:00', NULL),
('2021-02-28', 71, 1, '16:00:00', NULL),
('2021-03-02', 43, 1, '16:00:00', NULL),
('2021-03-05', 81, 1, '16:00:00', NULL),
('2021-03-09', 24, 1, '16:00:00', NULL),
('2021-03-09', 62, 1, '16:00:00', NULL),
('2021-03-11', 57, 1, '16:00:00', NULL),
('2021-03-15', 43, 1, '16:00:00', NULL),
('2021-03-19', 51, 1, '16:00:00', NULL),
('2021-03-23', 67, 1, '16:00:00', NULL),
('2021-03-23', 73, 1, '16:00:00', NULL),
('2021-03-26', 60, 1, '16:00:00', NULL),
('2021-03-30', 73, 1, '16:00:00', NULL),
('2021-03-31', 26, 1, '16:00:00', NULL),
('2021-04-03', 29, 1, '16:00:00', NULL),
('2021-04-12', 68, 1, '16:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `child`
--

CREATE TABLE `child` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `default_leave` varchar(255) DEFAULT 'afternoon'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `child`
--

INSERT INTO `child` (`id`, `first_name`, `last_name`, `default_leave`) VALUES
(1, 'Justine', 'Donovan', 'afternoon'),
(2, 'Oliver', 'Cox', 'afternoon'),
(3, 'Hilel', 'George', 'afternoon'),
(4, 'Castor', 'Dominguez', 'afternoon'),
(5, 'Nigel', 'Kim', 'afternoon'),
(6, 'Merritt', 'Rojas', 'afternoon'),
(7, 'Rhona', 'Christensen', 'afternoon'),
(8, 'Ulric', 'Sanders', 'afternoon'),
(9, 'Chelsea', 'Moreno', 'afternoon'),
(10, 'Blair', 'White', 'afternoon'),
(11, 'Hiroko', 'Navarro', 'afternoon'),
(12, 'Shaeleigh', 'Stevenson', 'afternoon'),
(13, 'Garth', 'Miller', 'afternoon'),
(14, 'Leandra', 'Goodman', 'afternoon'),
(15, 'Avye', 'Richardson', 'afternoon'),
(16, 'Baxter', 'May', 'afternoon'),
(17, 'Nita', 'Black', 'afternoon'),
(18, 'Allegra', 'Reilly', 'afternoon'),
(19, 'Nita', 'Meyers', 'afternoon'),
(20, 'Scarlet', 'Rowland', 'afternoon'),
(21, 'Nash', 'Horn', 'afternoon'),
(22, 'Gil', 'Foster', 'afternoon'),
(23, 'Carlos', 'Kim', 'afternoon'),
(24, 'Jamal', 'Davis', 'afternoon'),
(25, 'Hedy', 'Brennan', 'afternoon'),
(26, 'Harrison', 'Merritt', 'afternoon'),
(27, 'Lionel', 'Walters', 'afternoon'),
(28, 'Dieter', 'Rasmussen', 'afternoon'),
(29, 'Plato', 'Simmons', 'afternoon'),
(30, 'Ocean', 'Hines', 'afternoon'),
(31, 'Yasir', 'Merritt', 'afternoon'),
(32, 'Tatiana', 'Hester', 'afternoon'),
(33, 'Bell', 'Cabrera', 'afternoon'),
(34, 'Buckminster', 'Odom', 'afternoon'),
(35, 'Ahmed', 'Gates', 'afternoon'),
(36, 'Jaquelyn', 'Thornton', 'afternoon'),
(37, 'Blair', 'Wiggins', 'afternoon'),
(38, 'Buckminster', 'Pratt', 'afternoon'),
(39, 'Philip', 'Sheppard', 'afternoon'),
(40, 'Craig', 'Terrell', 'afternoon'),
(41, 'Lionel', 'Shepherd', 'afternoon'),
(42, 'Sacha', 'Vazquez', 'afternoon'),
(43, 'MacKensie', 'Jacobson', 'afternoon'),
(44, 'Nomlanga', 'Beard', 'afternoon'),
(45, 'Simon', 'Bowman', 'afternoon'),
(46, 'Melanie', 'Lowery', 'afternoon'),
(47, 'Ethan', 'Bowman', 'afternoon'),
(48, 'Grant', 'Estrada', 'afternoon'),
(49, 'Hadassah', 'Stephens', 'afternoon'),
(50, 'Fay', 'Bradford', 'afternoon'),
(51, 'Bradley', 'Petersen', 'afternoon'),
(52, 'Yoshio', 'Grimes', 'afternoon'),
(53, 'Pearl', 'Blackwell', 'afternoon'),
(54, 'Duncan', 'Blackwell', 'afternoon'),
(55, 'Melanie', 'Snider', 'afternoon'),
(56, 'Ulla', 'Rivera', 'afternoon'),
(57, 'Astra', 'Walters', 'afternoon'),
(58, 'Alan', 'Howard', 'afternoon'),
(59, 'Preston', 'Romero', 'afternoon'),
(60, 'Derek', 'Dorsey', 'afternoon'),
(61, 'Walker', 'Davis', 'afternoon'),
(62, 'Jacob', 'Whitfield', 'afternoon'),
(63, 'Leo', 'Kent', 'afternoon'),
(64, 'Amal', 'Guzman', 'afternoon'),
(65, 'Erin', 'Mercado', 'afternoon'),
(66, 'Amos', 'Nash', 'afternoon'),
(67, 'Maite', 'Evans', 'afternoon'),
(68, 'Beatrice', 'William', 'afternoon'),
(69, 'Daphne', 'Carney', 'afternoon'),
(70, 'Trevor', 'Hardin', 'afternoon'),
(71, 'Hakeem', 'Mason', 'afternoon'),
(72, 'Donovan', 'Sykes', 'afternoon'),
(73, 'Lawrence', 'Fry', 'afternoon'),
(74, 'Debra', 'Spears', 'afternoon'),
(75, 'Russell', 'Jacobson', 'afternoon'),
(76, 'Zelda', 'Schmidt', 'afternoon'),
(77, 'Lucy', 'Moses', 'afternoon'),
(78, 'Zahir', 'Bowen', 'afternoon'),
(79, 'Calvin', 'Silva', 'afternoon'),
(80, 'Indigo', 'Whitehead', 'afternoon'),
(81, 'Patrick', 'Walters', 'afternoon'),
(82, 'Gage', 'Moreno', 'afternoon'),
(83, 'Buckminster', 'Fuller', 'afternoon'),
(84, 'Cedric', 'Bruce', 'afternoon'),
(85, 'Meghan', 'Roberson', 'afternoon'),
(86, 'Maxwell', 'Guthrie', 'afternoon'),
(87, 'Jelani', 'Stein', 'afternoon'),
(88, 'Ariel', 'Crane', 'afternoon'),
(89, 'Lucy', 'Jones', 'afternoon'),
(90, 'Josiah', 'Horn', 'afternoon'),
(91, 'Willa', 'Christensen', 'afternoon'),
(92, 'Sandra', 'Ochoa', 'afternoon'),
(93, 'Lillith', 'Mooney', 'afternoon'),
(94, 'Keegan', 'Tanner', 'afternoon'),
(95, 'Bradley', 'Moore', 'afternoon'),
(96, 'Kaitlin', 'Booker', 'afternoon'),
(97, 'Taylor', 'Powers', 'afternoon'),
(98, 'Herman', 'Dyer', 'afternoon'),
(99, 'Lucy', 'Austin', 'afternoon'),
(100, 'Malachi', 'Moody', 'afternoon'),
(101, 'Bob', 'Johnson', 'afternoon'),
(102, 'Billy', 'Johnson', 'afternoon');

--
-- Triggers `child`
--
DELIMITER $$
CREATE TRIGGER `orientation_meeting` AFTER INSERT ON `child` FOR EACH ROW BEGIN
        INSERT INTO child_event (child_id, event_id, fee) VALUES(NEW.id, 21, 1);
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `child_class`
--

CREATE TABLE `child_class` (
  `child_id` int(11) NOT NULL DEFAULT '0',
  `class_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `child_class`
--

INSERT INTO `child_class` (`child_id`, `class_id`) VALUES
(66, 1),
(79, 1),
(1, 2),
(51, 2),
(5, 3),
(11, 3),
(64, 3),
(71, 3),
(1, 4),
(43, 4),
(53, 4),
(77, 4),
(80, 4),
(97, 4),
(3, 5),
(6, 5),
(40, 5),
(53, 5),
(61, 5),
(74, 5),
(47, 6),
(67, 6),
(52, 7),
(55, 7),
(66, 7),
(73, 7),
(94, 7),
(74, 8),
(39, 9),
(57, 9),
(58, 9),
(72, 9),
(79, 9),
(43, 10),
(18, 11),
(42, 11),
(51, 11),
(88, 11),
(31, 13),
(39, 13),
(69, 13),
(80, 13),
(83, 13),
(85, 13),
(11, 14),
(38, 14),
(80, 14),
(21, 15),
(66, 15),
(75, 15),
(4, 16),
(25, 16),
(29, 16),
(39, 16),
(54, 16),
(64, 16),
(81, 16),
(97, 16),
(2, 17),
(7, 17),
(23, 17),
(28, 17),
(29, 18),
(67, 18),
(86, 18),
(87, 18),
(12, 19),
(33, 19),
(52, 19),
(19, 20),
(25, 20),
(77, 20),
(84, 20),
(89, 20),
(81, 21),
(87, 21),
(100, 21),
(3, 22),
(17, 22),
(26, 22),
(31, 22),
(33, 22),
(93, 22),
(58, 23),
(65, 23),
(95, 23),
(100, 23),
(6, 24),
(7, 24),
(31, 24),
(36, 24),
(44, 24),
(67, 24),
(98, 24),
(44, 25),
(88, 25),
(89, 25),
(92, 25),
(12, 26),
(22, 26),
(42, 26),
(44, 26),
(68, 26),
(83, 26),
(41, 27),
(47, 27),
(88, 27),
(94, 28),
(2, 29),
(21, 29),
(29, 29),
(37, 29),
(75, 29),
(1, 30),
(15, 30),
(81, 30),
(85, 30),
(10, 32),
(21, 32),
(64, 32),
(84, 32),
(28, 34),
(32, 34),
(78, 34),
(2, 35),
(5, 35),
(54, 35),
(6, 36),
(12, 36),
(35, 36),
(66, 36),
(87, 36),
(96, 36),
(8, 37),
(13, 37),
(22, 37),
(35, 37),
(49, 37),
(100, 37),
(30, 38),
(31, 38),
(39, 39),
(80, 39),
(5, 40),
(7, 40),
(28, 40),
(54, 40),
(51, 41),
(71, 41),
(30, 42),
(36, 42),
(95, 42),
(43, 43),
(62, 43),
(68, 43),
(89, 43),
(17, 44),
(50, 44),
(60, 44),
(85, 44),
(90, 44),
(5, 45),
(18, 45),
(46, 45),
(86, 45),
(93, 45),
(6, 46),
(44, 46),
(60, 47),
(71, 47),
(78, 47),
(12, 48),
(18, 48),
(59, 48),
(7, 49),
(27, 49),
(93, 49),
(44, 50),
(60, 50),
(61, 50);

-- --------------------------------------------------------

--
-- Table structure for table `child_event`
--

CREATE TABLE `child_event` (
  `child_id` int(11) NOT NULL DEFAULT '0',
  `event_id` int(11) NOT NULL DEFAULT '0',
  `fee` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `child_event`
--

INSERT INTO `child_event` (`child_id`, `event_id`, `fee`) VALUES
(3, 16, 0),
(4, 1, 0),
(6, 1, 0),
(8, 8, 1),
(8, 14, 0),
(10, 6, 1),
(11, 17, 0),
(13, 3, 0),
(14, 18, 1),
(17, 7, 0),
(22, 1, 0),
(28, 3, 1),
(30, 8, 0),
(31, 8, 0),
(31, 14, 0),
(33, 4, 0),
(34, 6, 1),
(43, 16, 0),
(44, 16, 0),
(45, 13, 0),
(53, 5, 1),
(53, 20, 0),
(55, 11, 0),
(57, 10, 0),
(57, 19, 0),
(62, 13, 0),
(72, 6, 1),
(78, 7, 0),
(80, 6, 0),
(80, 18, 1),
(83, 11, 0),
(84, 8, 0),
(87, 14, 0),
(89, 7, 0),
(90, 6, 1),
(94, 12, 0),
(94, 20, 0),
(97, 8, 0),
(97, 11, 0),
(99, 11, 0),
(101, 21, 1),
(102, 21, 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `child_events`
-- (See below for the actual view)
--
CREATE TABLE `child_events` (
`child name` varchar(255)
,`child surname` varchar(255)
,`event` text
);

-- --------------------------------------------------------

--
-- Table structure for table `child_guardian`
--

CREATE TABLE `child_guardian` (
  `child_id` int(11) NOT NULL DEFAULT '0',
  `guardian_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `child_guardian`
--

INSERT INTO `child_guardian` (`child_id`, `guardian_id`) VALUES
(89, 1),
(89, 3),
(73, 4),
(95, 4),
(53, 5),
(80, 5),
(16, 7),
(37, 7),
(98, 7),
(100, 7),
(21, 8),
(27, 8),
(86, 8),
(96, 8),
(67, 9),
(9, 10),
(83, 10),
(64, 12),
(45, 13),
(88, 13),
(91, 14),
(54, 16),
(97, 16),
(1, 17),
(2, 17),
(76, 17),
(36, 18),
(37, 20),
(91, 20),
(59, 21),
(72, 23),
(2, 24),
(7, 24),
(11, 24),
(88, 24),
(1, 25),
(78, 25),
(18, 26),
(8, 27),
(29, 28),
(52, 28),
(36, 29),
(58, 29),
(17, 30),
(52, 32),
(95, 32),
(55, 33),
(50, 35),
(18, 36),
(10, 37),
(15, 38),
(97, 39),
(90, 40),
(43, 41),
(52, 41),
(84, 42),
(4, 43),
(96, 43),
(98, 43),
(18, 44),
(33, 44),
(49, 45),
(55, 45),
(60, 45),
(94, 45),
(14, 46),
(56, 48),
(68, 48),
(34, 49),
(42, 49),
(26, 50),
(62, 51),
(3, 52),
(51, 52),
(58, 52),
(67, 52),
(42, 53),
(63, 53),
(98, 53),
(67, 54),
(86, 56),
(12, 57),
(91, 58),
(28, 59),
(39, 59),
(45, 59),
(30, 60),
(50, 60),
(62, 60),
(97, 60);

-- --------------------------------------------------------

--
-- Stand-in structure for view `child_guardians`
-- (See below for the actual view)
--
CREATE TABLE `child_guardians` (
`child` varchar(255)
,`guardian` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `child_id_attendance`
-- (See below for the actual view)
--
CREATE TABLE `child_id_attendance` (
`child` varchar(255)
,`days present` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `child_teacher_count`
-- (See below for the actual view)
--
CREATE TABLE `child_teacher_count` (
`child` bigint(21)
,`teacher` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `child_unpaid_event_fee`
-- (See below for the actual view)
--
CREATE TABLE `child_unpaid_event_fee` (
`child name` varchar(255)
,`child surname` varchar(255)
,`event` text
);

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `room` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`id`, `name`, `room`) VALUES
(1, 'eu', '219'),
(2, 'congue', '211'),
(3, 'cursus.', '248'),
(4, 'eu', '225'),
(5, 'non,', '204'),
(6, 'ut,', '239'),
(7, 'Phasellus', '213'),
(8, 'sit', '249'),
(9, 'eros', '213'),
(10, 'eu', '210'),
(11, 'mi,', '246'),
(12, 'amet', '249'),
(13, 'Suspendisse', '240'),
(14, 'vitae', '213'),
(15, 'risus.', '236'),
(16, 'enim.', '239'),
(17, 'libero', '210'),
(18, 'laoreet', '207'),
(19, 'imperdiet', '201'),
(20, 'Curae;', '228'),
(21, 'quis', '250'),
(22, 'Nullam', '232'),
(23, 'Phasellus', '232'),
(24, 'congue', '249'),
(25, 'ultricies', '240'),
(26, 'viverra.', '206'),
(27, 'rutrum', '247'),
(28, 'Sed', '238'),
(29, 'id,', '223'),
(30, 'mollis.', '227'),
(31, 'ligula', '233'),
(32, 'feugiat', '210'),
(33, 'non,', '216'),
(34, 'fames', '213'),
(35, 'a', '242'),
(36, 'rhoncus.', '241'),
(37, 'malesuada', '234'),
(38, 'primis', '208'),
(39, 'enim.', '247'),
(40, 'rutrum', '241'),
(41, 'vel', '241'),
(42, 'euismod', '209'),
(43, 'nibh', '216'),
(44, 'consectetuer,', '221'),
(45, 'pellentesque', '216'),
(46, 'Curae;', '224'),
(47, 'euismod', '206'),
(48, 'Cras', '230'),
(49, 'consequat', '206'),
(50, 'vestibulum.', '236');

-- --------------------------------------------------------

--
-- Table structure for table `class_schedule`
--

CREATE TABLE `class_schedule` (
  `id` int(11) NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `day_id` int(11) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `class_schedule`
--

INSERT INTO `class_schedule` (`id`, `class_id`, `day_id`, `teacher_id`, `start_time`, `end_time`) VALUES
(1, 7, 5, 1, '01:49:18', '05:18:12'),
(2, 9, 5, 2, '12:00:39', '21:36:11'),
(3, 48, 3, 11, '15:53:13', '15:26:24'),
(4, 38, 5, 1, '12:51:14', '21:46:00'),
(5, 34, 5, 12, '03:05:05', '18:11:52'),
(6, 3, 1, 13, '21:26:23', '08:54:05'),
(7, 5, 3, 15, '12:52:01', '04:35:53'),
(8, 46, 2, 2, '21:52:25', '14:02:17'),
(9, 41, 4, 2, '02:15:44', '16:06:18'),
(10, 14, 5, 5, '18:34:28', '05:35:48'),
(11, 39, 4, 11, '18:59:10', '18:48:43'),
(12, 6, 4, 10, '01:41:57', '02:55:27'),
(13, 29, 5, 19, '22:47:43', '21:19:35'),
(14, 12, 2, 2, '06:26:28', '16:06:16'),
(15, 47, 3, 9, '16:33:00', '03:14:45'),
(16, 19, 4, 6, '11:27:21', '18:05:23'),
(17, 26, 2, 11, '17:55:27', '16:57:41'),
(18, 38, 3, 8, '20:41:06', '11:58:55'),
(19, 11, 4, 10, '19:55:37', '10:59:07'),
(20, 47, 2, 5, '11:15:27', '15:44:48'),
(21, 15, 4, 17, '18:56:50', '20:34:24'),
(22, 46, 2, 15, '09:19:47', '12:42:54'),
(23, 41, 4, 15, '04:24:30', '12:43:39'),
(24, 43, 1, 4, '10:11:34', '00:40:23'),
(25, 25, 4, 13, '13:51:47', '11:26:50'),
(26, 31, 5, 9, '17:23:44', '01:56:00'),
(27, 7, 5, 11, '14:38:06', '11:16:56'),
(28, 29, 1, 15, '14:40:45', '07:40:31'),
(29, 19, 5, 19, '13:45:21', '05:04:40'),
(30, 10, 2, 16, '12:13:22', '12:52:34'),
(31, 20, 1, 3, '10:21:47', '04:18:28'),
(32, 9, 3, 3, '01:58:08', '01:32:25'),
(33, 48, 1, 16, '03:30:47', '03:57:45'),
(34, 23, 4, 13, '15:56:07', '10:00:09'),
(35, 50, 5, 1, '09:14:49', '02:49:42'),
(36, 34, 5, 4, '05:45:51', '03:11:41'),
(37, 16, 3, 8, '06:45:39', '21:15:36'),
(38, 2, 4, 3, '06:40:05', '20:58:17'),
(39, 21, 4, 17, '21:53:16', '08:27:37'),
(40, 40, 3, 8, '17:47:33', '09:37:39'),
(41, 24, 2, 10, '13:30:05', '16:34:44'),
(42, 11, 4, 4, '00:36:35', '18:09:35'),
(43, 39, 5, 19, '07:50:07', '14:16:07'),
(44, 15, 2, 10, '00:40:32', '13:37:09'),
(45, 18, 5, 3, '00:18:07', '06:25:04'),
(46, 16, 4, 17, '08:51:37', '15:06:21'),
(47, 27, 4, 8, '23:29:37', '07:14:41'),
(48, 30, 3, 1, '04:09:23', '18:52:23'),
(49, 35, 3, 11, '23:34:06', '02:17:07'),
(50, 41, 4, 18, '21:26:08', '00:59:42'),
(51, 36, 1, 20, '04:16:30', '10:31:18'),
(52, 27, 2, 14, '04:05:20', '06:20:48'),
(53, 27, 1, 5, '06:04:04', '07:06:23'),
(54, 38, 4, 11, '11:05:30', '07:19:12'),
(55, 25, 5, 20, '06:16:03', '04:10:41'),
(56, 24, 1, 16, '00:22:03', '08:38:01'),
(57, 44, 5, 13, '00:31:26', '08:23:45'),
(58, 39, 4, 17, '16:00:13', '16:16:57'),
(59, 14, 2, 8, '02:12:41', '06:39:46'),
(60, 27, 2, 12, '01:07:12', '02:46:32'),
(61, 22, 5, 20, '10:27:28', '15:50:01'),
(62, 27, 4, 20, '09:14:27', '16:13:07'),
(63, 40, 2, 17, '20:26:12', '00:35:20'),
(64, 20, 4, 4, '07:58:41', '19:23:00'),
(65, 28, 5, 12, '17:01:57', '05:14:48'),
(66, 13, 3, 6, '18:57:40', '06:40:00'),
(67, 36, 1, 13, '18:59:36', '00:04:57'),
(68, 36, 2, 3, '12:16:59', '13:06:10'),
(69, 11, 1, 16, '09:25:13', '01:47:01'),
(70, 49, 4, 11, '05:14:46', '23:00:11'),
(71, 30, 5, 5, '09:28:48', '08:52:17'),
(72, 44, 2, 5, '20:45:15', '15:00:37'),
(73, 38, 2, 10, '13:30:54', '03:00:02'),
(74, 22, 3, 9, '02:51:38', '04:06:55'),
(75, 5, 1, 18, '11:07:44', '17:12:51'),
(76, 9, 2, 13, '17:08:26', '03:05:37'),
(77, 41, 3, 9, '08:36:53', '06:57:43'),
(78, 28, 3, 4, '13:35:17', '09:34:48'),
(79, 36, 5, 5, '17:05:15', '09:26:35'),
(80, 34, 2, 14, '17:08:21', '08:05:34'),
(81, 14, 5, 20, '13:10:32', '12:45:06'),
(82, 40, 2, 4, '13:39:52', '04:19:38'),
(83, 19, 2, 13, '16:36:29', '15:57:13'),
(84, 27, 2, 8, '08:52:13', '12:48:40'),
(85, 23, 4, 2, '23:24:10', '06:59:57'),
(86, 25, 2, 2, '00:56:28', '13:24:44'),
(87, 9, 2, 13, '23:02:22', '13:39:07'),
(88, 3, 1, 14, '09:39:56', '00:52:58'),
(89, 31, 1, 12, '07:48:51', '23:34:53'),
(90, 8, 5, 18, '00:17:14', '06:12:37');

-- --------------------------------------------------------

--
-- Table structure for table `day`
--

CREATE TABLE `day` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `day`
--

INSERT INTO `day` (`id`, `name`) VALUES
(1, 'Mon'),
(2, 'Tue'),
(3, 'Wen'),
(4, 'Thur'),
(5, 'Fri');

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`id`, `name`, `address`, `start_time`, `end_time`, `city`) VALUES
(1, 'Fusce', '144-1975 Quisque St.', '2019-10-06 23:45:42', '2021-04-11 09:51:20', 'Vielsalm'),
(2, 'Duis', '793-4515 Mollis. Ave', '2020-10-14 11:07:11', '2019-09-01 03:31:37', 'Burlington'),
(3, 'vestibulum.', 'Ap #494-2280 Donec Road', '2019-04-23 11:52:55', '2020-06-12 16:55:18', 'Champlain'),
(4, 'Nunc', 'P.O. Box 202, 2818 Feugiat. Rd.', '2019-12-08 16:02:22', '2019-07-06 06:16:24', 'Kasur'),
(5, 'Cum', 'Ap #244-5648 Aliquam Avenue', '2019-10-14 21:16:14', '2020-12-18 05:47:40', 'Chakwal'),
(6, 'mauris', '885-8272 Fermentum Rd.', '2021-02-01 07:14:18', '2020-12-27 19:20:29', 'San Gregorio'),
(7, 'Donec', '690-3124 Nec Ave', '2020-07-28 16:45:36', '2020-01-08 11:52:07', 'Banbury'),
(8, 'magna.', '515-835 Nulla Av.', '2020-06-09 01:44:24', '2020-01-14 10:23:50', 'Alassio'),
(9, 'libero.', '155-3497 Donec Road', '2020-08-21 18:02:40', '2021-02-22 16:05:17', 'Varanasi'),
(10, 'felis', 'Ap #824-8624 Rutrum Avenue', '2020-12-23 10:37:41', '2020-02-25 06:06:51', 'João Pessoa'),
(11, 'vitae,', 'Ap #169-8029 Eu Av.', '2020-06-09 13:29:18', '2021-03-29 21:03:52', 'Bloxham'),
(12, 'nunc', '166-9589 Eleifend. Rd.', '2021-01-30 17:56:05', '2020-03-18 15:24:51', 'El Carmen'),
(13, 'hymenaeos.', 'P.O. Box 882, 9007 Enim Street', '2021-01-12 02:00:52', '2020-09-03 07:56:55', 'Lunel'),
(14, 'diam', 'Ap #327-3301 A Road', '2019-08-11 20:42:21', '2021-04-07 04:45:24', 'Prince Albert'),
(15, 'lorem,', '6477 Orci Av.', '2020-02-20 10:00:48', '2021-03-08 07:56:09', 'Jinju'),
(16, 'hendrerit', '692-6279 Et Road', '2020-01-11 11:17:19', '2020-06-22 03:37:04', 'Heusden'),
(17, 'Nam', '751-3468 A, St.', '2020-07-06 08:46:57', '2020-09-12 20:27:52', 'Berbroek'),
(18, 'fermentum', 'P.O. Box 968, 1612 Cursus St.', '2020-09-30 07:48:28', '2019-09-23 23:39:07', 'Marchienne-au-Pont'),
(19, 'at', '554-3294 Auctor Avenue', '2019-06-25 01:31:08', '2020-12-08 20:48:28', 'Grand Island'),
(20, 'vestibulum,', 'Ap #138-2024 Augue Avenue', '2021-03-06 17:00:38', '2020-09-15 13:59:23', 'Aubange'),
(21, 'Orientation', 'school street 255', '2020-09-01 08:00:00', '2020-09-01 11:00:00', 'school city');

-- --------------------------------------------------------

--
-- Table structure for table `guardian`
--

CREATE TABLE `guardian` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guardian`
--

INSERT INTO `guardian` (`id`, `first_name`, `last_name`, `email`, `phone_number`) VALUES
(1, 'Wendy', 'Perkins', 'eget@seddictum.com', '(0788) 82618894'),
(2, 'Sheila', 'Buck', 'non.dapibus@metus.co.uk', '(035467) 911439'),
(3, 'Avye', 'Payne', 'vestibulum@pulvinararcuet.edu', '(082) 92120917'),
(4, 'Igor', 'Delgado', 'ultrices@variusultrices.co.uk', '(0466) 36069488'),
(5, 'Tobias', 'Simmons', 'porttitor.vulputate.posuere@odio.edu', '(0860) 53415468'),
(6, 'Kennedy', 'Stein', 'dictum.placerat@consequatenimdiam.org', '(03977) 0339619'),
(7, 'Ocean', 'Hurley', 'quam.quis@hendrerit.edu', '(036) 74460720'),
(8, 'Amir', 'Wiggins', 'faucibus.ut@bibendumfermentummetus.com', '(069) 07676897'),
(9, 'Gabriel', 'Hatfield', 'et.risus@Loremipsum.org', '(034483) 793129'),
(10, 'Melanie', 'Tucker', 'neque@volutpatNulla.org', '(037953) 351863'),
(11, 'Tana', 'Battle', 'lorem.Donec@ipsumporta.com', '(039420) 651489'),
(12, 'Aurora', 'Aguilar', 'Cras@iderat.net', '(0595) 55317310'),
(13, 'Aurora', 'Waller', 'odio.sagittis.semper@elit.ca', '(0272) 96775897'),
(14, 'Odessa', 'Carlson', 'mollis.Integer.tincidunt@ipsum.edu', '(00778) 6938886'),
(15, 'Yen', 'Emerson', 'ac.sem@vitaediam.org', '(0492) 27265241'),
(16, 'Grant', 'Cobb', 'Maecenas.libero.est@fermentumconvallis.edu', '(041) 36168469'),
(17, 'Rebekah', 'Phelps', 'eu@scelerisque.ca', '(014) 30983824'),
(18, 'Nolan', 'Cooley', 'malesuada@sedest.org', '(042) 89132825'),
(19, 'Paula', 'Valentine', 'rhoncus@elitAliquamauctor.com', '(0613) 95661284'),
(20, 'Dexter', 'Conner', 'Pellentesque@disparturientmontes.co.uk', '(009) 73143143'),
(21, 'Hunter', 'Herring', 'velit@massa.com', '(0951) 17219504'),
(22, 'Joel', 'Hardin', 'semper@habitantmorbi.co.uk', '(037677) 987255'),
(23, 'Xander', 'Robinson', 'aliquet.odio.Etiam@NullafacilisiSed.net', '(034642) 621122'),
(24, 'Sybill', 'May', 'velit@ipsumdolor.net', '(0507) 43776852'),
(25, 'Laura', 'Rhodes', 'quis@Donec.org', '(0431) 36015806'),
(26, 'Harlan', 'Stafford', 'semper.erat@Donecsollicitudinadipiscing.com', '(04435) 5741469'),
(27, 'Larissa', 'Ayers', 'laoreet@non.org', '(00051) 4411243'),
(28, 'Noelani', 'Stewart', 'in@purus.ca', '(0845) 89811570'),
(29, 'Roanna', 'Gordon', 'euismod.ac@indolorFusce.co.uk', '(094) 99688838'),
(30, 'Zachary', 'Garrett', 'blandit@molestiein.net', '(036232) 538044'),
(31, 'Allistair', 'Shaffer', 'mus.Aenean@pedeblandit.net', '(07526) 0988044'),
(32, 'Bruno', 'Carr', 'ac.turpis@necluctusfelis.org', '(0223) 80379295'),
(33, 'Ursa', 'Wilkins', 'suscipit.nonummy.Fusce@idsapien.co.uk', '(02752) 9296122'),
(34, 'Merrill', 'Blair', 'eu.tellus.eu@Nullainterdum.net', '(08618) 8540063'),
(35, 'Craig', 'Vaughn', 'Integer@Donecestmauris.com', '(0031) 28258501'),
(36, 'Jennifer', 'Molina', 'Mauris.quis.turpis@imperdieterat.co.uk', '(0862) 75051546'),
(37, 'Echo', 'Mclaughlin', 'est@duiaugue.net', '(037200) 938946'),
(38, 'Cullen', 'Buchanan', 'dignissim.tempor@afeugiat.co.uk', '(02046) 2924052'),
(39, 'Ezekiel', 'Gordon', 'erat.semper@DonecnibhQuisque.net', '(084) 42393482'),
(40, 'Vladimir', 'Nguyen', 'ut.molestie.in@fringillaornare.com', '(06799) 5416141'),
(41, 'Keaton', 'Sanchez', 'amet.ante.Vivamus@Morbimetus.org', '(039620) 805704'),
(42, 'India', 'Baker', 'imperdiet.ornare@nec.net', '(084) 43574699'),
(43, 'Camden', 'Vega', 'Duis@eleifendnec.edu', '(0647) 16870325'),
(44, 'Shafira', 'Olsen', 'odio@ami.co.uk', '(057) 09796354'),
(45, 'Margaret', 'Jarvis', 'sem.Pellentesque.ut@necmetus.edu', '(0421) 48208734'),
(46, 'Brady', 'Perkins', 'a.arcu.Sed@tortorNunc.net', '(03565) 6558608'),
(47, 'Macaulay', 'Stephenson', 'quis.accumsan.convallis@semmagnanec.org', '(031168) 934604'),
(48, 'Norman', 'Howard', 'non.sollicitudin@vehicularisus.com', '(026) 43885552'),
(49, 'Kylee', 'Cain', 'lacus@metus.com', '(0450) 25903644'),
(50, 'Harper', 'Morales', 'fringilla@sed.co.uk', '(012) 14038274'),
(51, 'Emmanuel', 'Landry', 'laoreet@vehiculaPellentesque.net', '(032232) 326292'),
(52, 'Jennifer', 'Patterson', 'nulla.In.tincidunt@facilisiseget.org', '(030071) 013327'),
(53, 'Timon', 'Underwood', 'massa@aliquamerosturpis.ca', '(0810) 64848664'),
(54, 'Urielle', 'Sheppard', 'metus.In@arcuVivamus.co.uk', '(0463) 65524031'),
(55, 'Carter', 'Terrell', 'at.velit@tortordictumeu.org', '(0434) 52605964'),
(56, 'Duncan', 'Burks', 'felis.purus@nonummyipsum.edu', '(02085) 7319262'),
(57, 'Kelly', 'Watkins', 'sem.mollis.dui@Duis.com', '(032411) 383927'),
(58, 'Tyrone', 'Griffith', 'vulputate@Namacnulla.co.uk', '(055) 33452856'),
(59, 'Otto', 'Crosby', 'tempus.risus@idliberoDonec.edu', '(04581) 8287720'),
(60, 'Tobias', 'Townsend', 'Sed.id@maurisIntegersem.ca', '(034425) 259658');

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`id`, `first_name`, `last_name`) VALUES
(1, 'Bruce', 'Bonner'),
(2, 'Uta', 'Salinas'),
(3, 'Lewis', 'Spence'),
(4, 'Shafira', 'Bentley'),
(5, 'Sandra', 'Jacobson'),
(6, 'Honorato', 'Le'),
(7, 'Nasim', 'Downs'),
(8, 'Allistair', 'Deleon'),
(9, 'Burke', 'Sanchez'),
(10, 'Sawyer', 'Sanford'),
(11, 'Kay', 'Vinson'),
(12, 'Kuame', 'Nguyen'),
(13, 'Elliott', 'Gill'),
(14, 'Halla', 'Hatfield'),
(15, 'Candace', 'Hester'),
(16, 'Rafael', 'Burt'),
(17, 'Christian', 'Robles'),
(18, 'Marah', 'Benson'),
(19, 'Gloria', 'Durham'),
(20, 'Jasmine', 'Gomez');

-- --------------------------------------------------------

--
-- Stand-in structure for view `teacher_classes`
-- (See below for the actual view)
--
CREATE TABLE `teacher_classes` (
`teacher` varchar(255)
,`class` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `teacher_class_schedule`
-- (See below for the actual view)
--
CREATE TABLE `teacher_class_schedule` (
`teacher` varchar(255)
,`class` varchar(255)
,`day` varchar(255)
,`start` time
,`end` time
);

-- --------------------------------------------------------

--
-- Structure for view `child_events`
--
DROP TABLE IF EXISTS `child_events`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `child_events`  AS  select `child`.`first_name` AS `child name`,`child`.`last_name` AS `child surname`,group_concat(`event`.`name` separator ',') AS `event` from ((`child` join `child_event` on((`child`.`id` = `child_event`.`child_id`))) join `event` on((`event`.`id` = `child_event`.`event_id`))) group by `child`.`first_name` ;

-- --------------------------------------------------------

--
-- Structure for view `child_guardians`
--
DROP TABLE IF EXISTS `child_guardians`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `child_guardians`  AS  select `c`.`first_name` AS `child`,group_concat(`guardian`.`first_name` separator ',') AS `guardian` from ((`guardian` join `child_guardian` `cg` on((`guardian`.`id` = `cg`.`guardian_id`))) join `child` `c` on((`c`.`id` = `cg`.`child_id`))) group by `c`.`first_name` ;

-- --------------------------------------------------------

--
-- Structure for view `child_id_attendance`
--
DROP TABLE IF EXISTS `child_id_attendance`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `child_id_attendance`  AS  select `child`.`first_name` AS `child`,count(`attendance`.`present`) AS `days present` from (`child` join `attendance`) where ((`child`.`id` = 10) and (`child`.`id` = `attendance`.`child_id`)) group by `child`.`id` ;

-- --------------------------------------------------------

--
-- Structure for view `child_teacher_count`
--
DROP TABLE IF EXISTS `child_teacher_count`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `child_teacher_count`  AS  select (select count(0) from `child` where `child`.`id`) AS `child`,(select count(0) from `teacher` where `teacher`.`id`) AS `teacher` ;

-- --------------------------------------------------------

--
-- Structure for view `child_unpaid_event_fee`
--
DROP TABLE IF EXISTS `child_unpaid_event_fee`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `child_unpaid_event_fee`  AS  select `child`.`first_name` AS `child name`,`child`.`last_name` AS `child surname`,group_concat(`event`.`name` separator ',') AS `event` from ((`child` join `child_event` on((`child`.`id` = `child_event`.`child_id`))) join `event` on((`event`.`id` = `child_event`.`event_id`))) where (`child_event`.`fee` = 0) group by `child`.`first_name` ;

-- --------------------------------------------------------

--
-- Structure for view `teacher_classes`
--
DROP TABLE IF EXISTS `teacher_classes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `teacher_classes`  AS  select `teacher`.`first_name` AS `teacher`,group_concat(`class`.`name` separator ',') AS `class` from ((`class` join `class_schedule` `cs` on((`class`.`id` = `cs`.`class_id`))) join `teacher` on((`teacher`.`id` = `cs`.`teacher_id`))) group by `teacher`.`first_name` ;

-- --------------------------------------------------------

--
-- Structure for view `teacher_class_schedule`
--
DROP TABLE IF EXISTS `teacher_class_schedule`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `teacher_class_schedule`  AS  select `teacher`.`first_name` AS `teacher`,`class`.`name` AS `class`,`day`.`name` AS `day`,`cs`.`start_time` AS `start`,`cs`.`end_time` AS `end` from (((`class` join `class_schedule` `cs` on((`class`.`id` = `cs`.`class_id`))) join `teacher` on((`teacher`.`id` = `cs`.`teacher_id`))) join `day` on((`day`.`id` = `cs`.`day_id`))) group by `cs`.`id` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`day`,`child_id`),
  ADD KEY `child_id` (`child_id`);

--
-- Indexes for table `child`
--
ALTER TABLE `child`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `child_class`
--
ALTER TABLE `child_class`
  ADD PRIMARY KEY (`child_id`,`class_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `child_event`
--
ALTER TABLE `child_event`
  ADD PRIMARY KEY (`child_id`,`event_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `child_guardian`
--
ALTER TABLE `child_guardian`
  ADD PRIMARY KEY (`child_id`,`guardian_id`),
  ADD KEY `guardian_id` (`guardian_id`);

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `class_schedule`
--
ALTER TABLE `class_schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `day_id` (`day_id`),
  ADD KEY `teacher_id` (`teacher_id`);

--
-- Indexes for table `day`
--
ALTER TABLE `day`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `guardian`
--
ALTER TABLE `guardian`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `child`
--
ALTER TABLE `child`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;
--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
--
-- AUTO_INCREMENT for table `class_schedule`
--
ALTER TABLE `class_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;
--
-- AUTO_INCREMENT for table `day`
--
ALTER TABLE `day`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `guardian`
--
ALTER TABLE `guardian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;
--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `child` (`id`),
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`child_id`) REFERENCES `child` (`id`);

--
-- Constraints for table `child_class`
--
ALTER TABLE `child_class`
  ADD CONSTRAINT `child_class_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `child` (`id`),
  ADD CONSTRAINT `child_class_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`);

--
-- Constraints for table `child_event`
--
ALTER TABLE `child_event`
  ADD CONSTRAINT `child_event_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `child` (`id`),
  ADD CONSTRAINT `child_event_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`);

--
-- Constraints for table `child_guardian`
--
ALTER TABLE `child_guardian`
  ADD CONSTRAINT `child_guardian_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `child` (`id`),
  ADD CONSTRAINT `child_guardian_ibfk_2` FOREIGN KEY (`guardian_id`) REFERENCES `guardian` (`id`);

--
-- Constraints for table `class_schedule`
--
ALTER TABLE `class_schedule`
  ADD CONSTRAINT `class_schedule_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`),
  ADD CONSTRAINT `class_schedule_ibfk_2` FOREIGN KEY (`day_id`) REFERENCES `day` (`id`),
  ADD CONSTRAINT `class_schedule_ibfk_3` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`),
  ADD CONSTRAINT `class_schedule_ibfk_4` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`),
  ADD CONSTRAINT `class_schedule_ibfk_5` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`),
  ADD CONSTRAINT `class_schedule_ibfk_6` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`),
  ADD CONSTRAINT `class_schedule_ibfk_7` FOREIGN KEY (`day_id`) REFERENCES `day` (`id`),
  ADD CONSTRAINT `class_schedule_ibfk_8` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
