-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 30, 2018 at 03:21 PM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bankdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `acc_no` char(10) NOT NULL,
  `holder` decimal(8,0) NOT NULL,
  `balance` decimal(13,2) NOT NULL,
  `status` enum('frozen','closed','unapproved','active') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`acc_no`, `holder`, `balance`, `status`) VALUES
('1234567788', '12345678', '54000.35', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `addr_line1` text NOT NULL,
  `addr_line2` text,
  `city` varchar(30) NOT NULL,
  `state` varchar(30) NOT NULL,
  `pincode` char(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `addr_line1`, `addr_line2`, `city`, `state`, `pincode`) VALUES
(4, '201, kalpyog hsg. soc.', 'sahkar nagar, opp. to mane gas', 'thane', 'maharashtra', '400606');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` decimal(8,0) NOT NULL,
  `f_name` varchar(30) NOT NULL,
  `m_name` varchar(30) DEFAULT NULL,
  `l_name` varchar(30) NOT NULL,
  `perm_addr` bigint(20) UNSIGNED NOT NULL,
  `cors_addr` bigint(20) UNSIGNED DEFAULT NULL,
  `mobile` char(10) NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 NOT NULL,
  `gender` enum('male','female','other') NOT NULL,
  `dob` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `f_name`, `m_name`, `l_name`, `perm_addr`, `cors_addr`, `mobile`, `email`, `gender`, `dob`) VALUES
('12345678', 'Akshat', 'Girdhari', 'Raut', 4, 4, '7715887414', 'aks13raut@gmail.com', 'male', '1999-06-13');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `tid` bigint(20) UNSIGNED NOT NULL,
  `from_acc` char(10) NOT NULL,
  `to_acc` char(10) NOT NULL,
  `amount` decimal(13,2) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `pswd` varbinary(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `pswd`) VALUES
(5, 'aks13raut@gmail.com', 0x9aed13e7efe479ba5fbf227221cefeb9);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`acc_no`),
  ADD KEY `holder` (`holder`);

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `customer_ibfk_3` (`perm_addr`),
  ADD KEY `customer_ibfk_2` (`cors_addr`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD UNIQUE KEY `tid` (`tid`),
  ADD KEY `from_acc` (`from_acc`),
  ADD KEY `to_acc` (`to_acc`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `tid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`holder`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `customer_ibfk_2` FOREIGN KEY (`cors_addr`) REFERENCES `address` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `customer_ibfk_3` FOREIGN KEY (`perm_addr`) REFERENCES `address` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`from_acc`) REFERENCES `account` (`acc_no`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`to_acc`) REFERENCES `account` (`acc_no`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
