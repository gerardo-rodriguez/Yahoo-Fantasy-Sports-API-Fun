-- phpMyAdmin SQL Dump
-- version 3.3.9.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 28, 2011 at 05:40 PM
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
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `create_date` date NOT NULL,
  `is_complete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` VALUES(1, 'grodriguez@cmdagency.com', '', 'Gerardo', 'Rodriguez Perez', '0000-00-00', 1);
INSERT INTO `admin` VALUES(2, 'ger.rod34@gmail.com', '', 'Gerardo Antonio', 'Rodriguez Perez Leal Vidrio', '0000-00-00', 0);

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
  `thumb_filename` varchar(255) NOT NULL,
  `full_filename` varchar(255) NOT NULL,
  `create_date` date NOT NULL,
  `archive_date` date NOT NULL,
  `is_archived` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=70 ;

--
-- Dumping data for table `collection`
--

INSERT INTO `collection` VALUES(65, 'The IE Collection', 'f68058cbc80800986d8b6c23a032ea2f_thumb.png', 'f68058cbc80800986d8b6c23a032ea2f_full.png', '2011-12-28', '0000-00-00', 0);
INSERT INTO `collection` VALUES(66, 'The Nothing Collection', 'd55a8826872d878fd1b6f78d8e6d5b9e_thumb.png', 'd55a8826872d878fd1b6f78d8e6d5b9e_full.jpg', '2011-12-28', '0000-00-00', 0);
INSERT INTO `collection` VALUES(67, 'A Much Needed Collection', 'd3d2207c41407ebc301bda332d7420ec_thumb.jpg', 'd3d2207c41407ebc301bda332d7420ec_full.jpg', '2011-12-28', '0000-00-00', 0);
INSERT INTO `collection` VALUES(68, 'This is another test', '755998c330c18f39f51537b475b1e831_thumb.jpg', '755998c330c18f39f51537b475b1e831_full.jpg', '2011-12-28', '0000-00-00', 0);
INSERT INTO `collection` VALUES(69, 'THE SICKEST COLLECTION V3', '932364867f35903963700514194972ac_thumb.png', '3d3d82a71c97698a8ccfd10e2dd493c9_full.jpg', '2011-12-28', '0000-00-00', 0);

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
  PRIMARY KEY (`id`),
  KEY `collection_id` (`collection_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=39 ;

--
-- Dumping data for table `item`
--

INSERT INTO `item` VALUES(37, 65, 'D', '654-654-999', 'This is the first item in the IE collection.\r\n', '', '2011-12-28');
INSERT INTO `item` VALUES(38, 69, 'R', '234-234', 'This is a super cool description.', '', '2011-12-28');
