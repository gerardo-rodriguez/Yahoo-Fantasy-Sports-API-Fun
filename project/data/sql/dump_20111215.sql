-- phpMyAdmin SQL Dump
-- version 3.3.9.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 15, 2011 at 02:56 PM
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
  `create_date` date NOT NULL,
  `archive_date` date NOT NULL,
  `is_archived` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=55 ;

--
-- Dumping data for table `collection`
--

INSERT INTO `collection` VALUES(48, 'Sike', '2011-12-09', '2011-12-12', 0);
INSERT INTO `collection` VALUES(49, 'Waht', '2011-12-09', '2011-12-09', 0);
INSERT INTO `collection` VALUES(50, 'Where', '2011-12-09', '2011-12-15', 1);
INSERT INTO `collection` VALUES(51, 'Way Out Of This World!!', '2011-12-09', '2011-12-12', 1);
INSERT INTO `collection` VALUES(52, 'Blazers Collection', '2011-12-15', '2011-12-15', 0);
INSERT INTO `collection` VALUES(53, 'Some Cool Collection', '2011-12-15', '0000-00-00', 0);
INSERT INTO `collection` VALUES(54, 'A Collection of the Ages', '2011-12-15', '0000-00-00', 0);

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
  PRIMARY KEY (`id`),
  KEY `collection_id` (`collection_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `item`
--

INSERT INTO `item` VALUES(1, 50, 'A', '2345', 'The coolest sham alive.', '*never need to wash! :o', '0000-00-00');
INSERT INTO `item` VALUES(2, 50, 'B', '0987', 'A sick pillow case.', '', '0000-00-00');
INSERT INTO `item` VALUES(3, 50, 'C', '8484', 'Nothing that cool, really.', '', '2011-12-15');
INSERT INTO `item` VALUES(4, 50, 'D', '1234;lkj1234-1234', 'Something super logn as;lj asdf;klj fadsl;kfjdsa ;lkaj afd;jk', 'Whatever.', '2011-12-15');
INSERT INTO `item` VALUES(5, 50, 'E', '1234;lkj1234-1234', 'Supwitchu', 'Whatever.', '2011-12-15');
INSERT INTO `item` VALUES(6, 52, 'PG', 'Raymond_Felton', 'New addition via trade.', '', '2011-12-15');
INSERT INTO `item` VALUES(7, 52, 'SG', 'Wesley_Matthews', 'Our \\"new\\" fulltime starting SG??', 'In battle with Jamal Crawford for starting position.', '2011-12-15');
INSERT INTO `item` VALUES(8, 52, 'SF', 'Gerald_Wallace', 'Added via trade by Rich Cho.', 'We need to hold onto him.', '2011-12-15');

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

