-- phpMyAdmin SQL Dump
-- version 3.3.9.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 06, 2011 at 09:29 AM
-- Server version: 5.5.9
-- PHP Version: 5.3.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `isabellacollection`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `create_date` date NOT NULL,
  `is_complete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` VALUES(1, 'grodriguez@cmdagency.com', '', '0000-00-00', 1);
INSERT INTO `admin` VALUES(2, 'ger.rod34@gmail.com', '', '0000-00-00', 0);
INSERT INTO `admin` VALUES(3, 'test@nothing.com', '', '0000-00-00', 0);
INSERT INTO `admin` VALUES(4, 'new@nothing.com', '', '0000-00-00', 0);
INSERT INTO `admin` VALUES(5, 'hello@nothing.com', '', '0000-00-00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `basket`
--

CREATE TABLE IF NOT EXISTS `basket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `create_date` date NOT NULL,
  `modify_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `basket`
--


-- --------------------------------------------------------

--
-- Table structure for table `basket_item`
--

CREATE TABLE IF NOT EXISTS `basket_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cart_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_id` (`cart_id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `basket_item`
--


-- --------------------------------------------------------

--
-- Table structure for table `collection`
--

CREATE TABLE IF NOT EXISTS `collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `create_date` date NOT NULL,
  `archive_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=40 ;

--
-- Dumping data for table `collection`
--

INSERT INTO `collection` VALUES(1, 'Eden', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(2, 'Diamond Pillow Collection', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(3, 'Cheetah Pillow Collection', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(4, 'Senecal Pillow Collection', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(5, 'Alex', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(6, 'Alexandria', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(7, 'Amore', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(8, 'Amore Coverlets & Shams', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(9, 'Ana Maria', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(10, 'Anastasia', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(11, 'Antoinette', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(12, 'Baylee', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(13, 'Calais', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(14, 'Camelia', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(15, 'Courtney', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(16, 'Crystal', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(17, 'Diana', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(18, 'Elizabeth', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(19, 'Eva', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(20, 'Helena', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(21, 'Hyde Park', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(22, 'Ivanka', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(23, 'Kathryn', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(24, 'Lyone', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(25, 'Maria Christina', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(26, 'Markham', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(27, 'Markham 2', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(28, 'Michelangelo', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(29, 'Molly', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(30, 'Nakita Noir', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(31, 'Olivia', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(32, 'Raquel', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(33, 'San Luis', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(34, 'Sasha', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(35, 'Savannah', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(36, 'Sofia', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(37, 'Symone', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(38, 'Valentina', '0000-00-00', '0000-00-00');
INSERT INTO `collection` VALUES(39, 'Violette', '0000-00-00', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `designer`
--

CREATE TABLE IF NOT EXISTS `designer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `business_name` varchar(255) NOT NULL,
  `owner_first_name` varchar(255) NOT NULL,
  `owner_last_name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `fax_number` varchar(255) NOT NULL,
  `create_date` date NOT NULL,
  `is_approved` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `designer`
--


-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE IF NOT EXISTS `image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `image`
--


-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE IF NOT EXISTS `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collection_id` int(11) NOT NULL,
  `photo_reference` varchar(255) NOT NULL,
  `stock_number` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `notes` varchar(255) NOT NULL,
  `create_date` date NOT NULL,
  `archive_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collection_id` (`collection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `item`
--


-- --------------------------------------------------------

--
-- Table structure for table `item_image`
--

CREATE TABLE IF NOT EXISTS `item_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `image_id` (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `item_image`
--

