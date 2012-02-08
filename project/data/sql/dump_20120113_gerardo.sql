-- phpMyAdmin SQL Dump
-- version 3.3.9.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 13, 2012 at 03:07 PM
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
  `hash` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `create_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` VALUES(1, 'ger.rod34@gmail.com', 'e67fcd2cc33010208bc8507cb536c06a93ef6bfe', '642765e64bdf3331f29d83f18c1d595ee0386cc4', 'Gerardo', 'Rodriguez', '2012-01-02');

-- --------------------------------------------------------

--
-- Table structure for table `basket`
--

CREATE TABLE IF NOT EXISTS `basket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` date NOT NULL,
  `modify_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `basket`
--

INSERT INTO `basket` VALUES(1, '2012-01-09', '2012-01-09');
INSERT INTO `basket` VALUES(2, '2012-01-09', '2012-01-09');
INSERT INTO `basket` VALUES(3, '2012-01-10', '2012-01-10');
INSERT INTO `basket` VALUES(4, '2012-01-10', '2012-01-10');
INSERT INTO `basket` VALUES(7, '2012-01-11', '2012-01-11');

-- --------------------------------------------------------

--
-- Table structure for table `basket_item`
--

CREATE TABLE IF NOT EXISTS `basket_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basket_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cart_id` (`basket_id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `basket_item`
--

INSERT INTO `basket_item` VALUES(1, 1, 1, 10);
INSERT INTO `basket_item` VALUES(2, 1, 4, 1);
INSERT INTO `basket_item` VALUES(3, 1, 3, 1);
INSERT INTO `basket_item` VALUES(4, 1, 2, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `collection`
--

INSERT INTO `collection` VALUES(1, 'A Test Collection', '17a16c5f7aceee0fb70da864395302eb_thumb.jpg', '17a16c5f7aceee0fb70da864395302eb_full.jpg', '2012-01-10', '2012-01-10', 0);
INSERT INTO `collection` VALUES(2, 'This is a 2nd collection.', 'a5c859530525eddcaaca96adfe5b49dc_thumb.jpg', '0f962e17817d6e1b95433c33020af335_full.jpg', '2012-01-10', '2012-01-10', 0);
INSERT INTO `collection` VALUES(3, 'Temp Laptop Collection', '1e5d20d32dbe1a72ecc397292a55950a_thumb.png', '1e5d20d32dbe1a72ecc397292a55950a_full.png', '2012-01-10', '2012-01-10', 0);
INSERT INTO `collection` VALUES(4, 'The Video Player Collection', 'ccfa251eb445d9de868a016bcc42355b_thumb.png', 'ccfa251eb445d9de868a016bcc42355b_full.png', '2012-01-10', '0000-00-00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `designer`
--

CREATE TABLE IF NOT EXISTS `designer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `hash` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `business_name` varchar(255) NOT NULL,
  `owner_first_name` varchar(255) NOT NULL,
  `owner_last_name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `fax_number` varchar(255) DEFAULT NULL,
  `tax_id_delivery` varchar(255) NOT NULL,
  `tax_document_filename` varchar(255) DEFAULT NULL,
  `create_date` date NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `basket_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `designer`
--

INSERT INTO `designer` VALUES(21, 'ger.rod34@gmail.com', '148d8caec0f03064e45b11aa9a1ce6d334b3d599', '895eaade9f2eaac5ad374593a9ca0efd4c87b496', 'nb', 'Gerardo', 'Rodriguez-Perez', '123 What St', 'Portland', 'OR', '97209', '123-123-1232', '', 'attach', 'cd3da24c9288c7ac2fe15e347350a0a0.pdf', '2012-01-09', 'approved', 1);
INSERT INTO `designer` VALUES(22, 'test@user.com', 'bb60fd7b37a7ec07722f78421d699c80dd7cafdf', 'cdb79b6fc8aa102e1ebf6fc2ebae7c76e6786b14', 'Test Biz', 'Test', 'User', 'Test Address', 'Test City', 'WV', '32154', '234234234', '', 'attach', 'c12b62415da2b696cb5c2b3b1450fe12.png', '2012-01-09', 'approved', 2);
INSERT INTO `designer` VALUES(23, 'turtle@email.com', '5705e7b0f0622969aca6862075ea03fb007e4e5c', 'ebd5f02ccd33e651c574698ff3ce391885741137', 'TMNT', 'Splinter', 'The Rat', 'Underground Sewers', 'NYC', 'NY', '23423', '1234-234-234', '2342342343', 'fax', NULL, '2012-01-10', 'approved', 3);
INSERT INTO `designer` VALUES(24, 'monkey@email.com', '3a8f486a69170a618728ff140cd319b9dac344ef', 'd3dbcb895765d05f8c92c21ca6bdb595a1d35520', 'The Monkies, Inc', 'Fatha Monk', 'None', 'The Jungle', 'Who knows?', 'TX', '32132', '2342342342', '234234234', 'fax', NULL, '2012-01-10', 'approved', 4);
INSERT INTO `designer` VALUES(27, 'grodriguez@cmdagency.com', 'b28c5313ff0b859f8ac02e146eccabb054b9d534', 'ce942384487168f77f97a86036d4850b4428e293', 'grodriguez', 'grodriguez', 'grodriguez', 'grodriguez', 'grodriguez', 'AL', '32121', '3213213212', '', 'fax', NULL, '2012-01-11', 'denied', 7);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `item`
--

INSERT INTO `item` VALUES(1, 1, 'D', '234234', 'This is a test item.', 'This is test notes.', '2012-01-10');
INSERT INTO `item` VALUES(2, 1, 'C', '234-234-DDB', 'This is just another item description\r\n', '', '2012-01-11');
INSERT INTO `item` VALUES(3, 1, 'AA', 'AA-00234--', 'Fusce nec felis mauris, et pretium leo. Nunc in purus malesuada eros sodales vestibulum. Nullam risus nisl, rutrum sit amet commodo feugiat, condimentum ac quam. Sed pretium elementum metus porta imperdiet. Maecenas sit amet neque non lectus feugiat inter', '', '2012-01-11');
INSERT INTO `item` VALUES(4, 1, 'BB', 'BB-234-234', 'Phasellus suscipit aliquam urna, non adipiscing nibh hendrerit malesuada. Proin fermentum augue a ', 'Some notes.', '2012-01-11');
