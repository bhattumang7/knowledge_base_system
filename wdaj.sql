-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 22, 2012 at 05:41 PM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `wdaj`
--

-- --------------------------------------------------------

--
-- Table structure for table `disease`
--

CREATE TABLE IF NOT EXISTS `disease` (
  `diseaseId` bigint(20) NOT NULL AUTO_INCREMENT,
  `diseaseName` varchar(50) DEFAULT NULL,
  `rule` text,
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`diseaseId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `disease`
--

INSERT INTO `disease` (`diseaseId`, `diseaseName`, `rule`, `deleted`) VALUES
(2, 'd1', '(9|10)', 0),
(3, 'd2', '(10|11)', 0),
(4, 'd3', '(9&(10|11))', 0),
(6, 'd65', '(9&11&12)', 0),
(7, 'disease test', '(9&11&12&12)', 0);

-- --------------------------------------------------------

--
-- Table structure for table `medicine`
--

CREATE TABLE IF NOT EXISTS `medicine` (
  `medicineId` int(11) NOT NULL AUTO_INCREMENT,
  `medicineName` varchar(2500) NOT NULL,
  `medicineType` int(11) NOT NULL,
  `deleted` int(1) NOT NULL,
  PRIMARY KEY (`medicineId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

--
-- Table structure for table `medicinefordisease`
--

CREATE TABLE IF NOT EXISTS `medicinefordisease` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diseaseId` bigint(20) NOT NULL,
  `medicineId` int(11) NOT NULL,
  `times_a_day` int(11) NOT NULL DEFAULT '0',
  `quantity` decimal(10,3) DEFAULT '0.000',
  PRIMARY KEY (`id`),
  KEY `medicineId` (`medicineId`),
  KEY `diseaseId` (`diseaseId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

-- --------------------------------------------------------

--
-- Table structure for table `symptom`
--

CREATE TABLE IF NOT EXISTS `symptom` (
  `symptomID` bigint(20) NOT NULL AUTO_INCREMENT,
  `symptomName` varchar(255) DEFAULT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`symptomID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `medicinefordisease`
--
ALTER TABLE `medicinefordisease`
  ADD CONSTRAINT `diseaseId` FOREIGN KEY (`diseaseId`) REFERENCES `disease` (`diseaseId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `medicineId` FOREIGN KEY (`medicineId`) REFERENCES `medicine` (`medicineId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
