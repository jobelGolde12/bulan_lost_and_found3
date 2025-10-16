-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 16, 2025 at 04:38 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lostandfound`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`id`, `user_id`, `title`, `content`, `created_at`, `deleted_at`, `updated_at`) VALUES
(3, 2, 'sample', 'This is a sample announcement', '2025-05-27 23:37:45', NULL, '2025-06-19 05:19:55'),
(4, 2, 'sample', 'This is a sample announcement', '2025-05-27 23:37:46', NULL, '2025-05-27 23:37:46'),
(5, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:50', NULL, '2025-05-27 23:37:50'),
(6, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:52', NULL, '2025-05-27 23:37:52'),
(7, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:54', '2025-10-13 21:16:24', '2025-10-13 21:16:24'),
(8, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:55', '2025-10-13 21:16:17', '2025-10-13 21:16:17'),
(10, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:56', NULL, '2025-05-27 23:37:56'),
(11, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:56', NULL, '2025-05-27 23:37:56'),
(14, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:57', NULL, '2025-05-27 23:37:57'),
(18, 2, 'qwe', 'qweqweqw', '2025-05-28 06:22:21', NULL, '2025-05-28 06:22:21'),
(22, 2, 'Good Day 🌞', 'Hello! 😊 Did you misplace your favorite water bottle or find a lonely phone? Our Lost & Found web app is here to help! 💻 You can easily post lost items or browse found items. Let\'s work together to get everything back where it belongs!', '2025-10-13 13:23:36', '2025-10-13 13:23:53', '2025-10-13 13:23:53'),
(23, 2, 'Good Day 🌞', 'Hello! 😊 Did you misplace your favorite water bottle or find a lonely phone? Our Lost & Found web app is here to help! 💻 You can easily post lost items or browse found items. Let\'s work together to get everything back where it belongs!', '2025-10-13 13:23:42', NULL, '2025-10-13 13:23:42'),
(24, 2, 'Emphasizing Security & Reliability', 'Your Lost & Found is in safe hands! 👮 The Philippine National Police is managing our online system, ensuring a secure and reliable way to reunite you with your lost items. Trust the PNP to help you find what\'s missing! ✨', '2025-10-13 13:31:56', NULL, '2025-10-13 13:31:56');

-- --------------------------------------------------------

--
-- Table structure for table `archived_items`
--

CREATE TABLE `archived_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `original_id` bigint(20) UNSIGNED NOT NULL,
  `archived_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`archived_data`)),
  `archived_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blocked_messages`
--

CREATE TABLE `blocked_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `blocked_user` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blocked_messages`
--

INSERT INTO `blocked_messages` (`id`, `user_id`, `blocked_user`, `created_at`, `updated_at`) VALUES
(1, 2, 13, '2025-06-30 01:22:21', '2025-06-30 01:22:21'),
(4, 2, 9, '2025-07-01 00:07:12', '2025-07-01 00:07:12'),
(5, 2, 7, '2025-07-01 00:07:40', '2025-07-01 00:07:40');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('d435a6cdd786300dff204ee7c2ef942d3e9034e2', 'i:2;', 1760338284),
('d435a6cdd786300dff204ee7c2ef942d3e9034e2:timer', 'i:1760338284;', 1760338284),
('jobelgolde43@gmail.com|127.0.0.1', 'i:1;', 1758431733),
('jobelgolde43@gmail.com|127.0.0.1:timer', 'i:1758431733;', 1758431733),
('login|127.0.0.1|jobelgolde43@gmail.com', 'i:1;', 1758431733),
('login|127.0.0.1|jobelgolde43@gmail.com:timer', 'i:1758431733;', 1758431733);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'Pets', 'Lost and found pets in Bulan, Sorsogon'),
(2, 'Electronics', 'Lost and found electronic devices like phones, laptops, etc.'),
(3, 'Documents', 'Lost and found personal documents like IDs, certificates, etc.'),
(4, 'Accessories', 'Lost and found accessories such as jewelry, bags, watches, etc.'),
(5, 'Clothing', 'Lost and found clothing items like jackets, uniforms, etc.'),
(6, 'Human', 'Lost and found individuals in Bulan, Sorsogon, such as missing children or adults'),
(7, 'Others', 'Miscellaneous lost and found items not listed in specific categories, such as tools or toys'),
(28, 'Keys', 'Lost and found keys including house keys, car keys, padlock keys, etc.'),
(29, 'Wallets/Purses', 'Lost and found wallets, coin purses, or bags with money/cards'),
(30, 'Eyewear', 'Lost and found eyeglasses, sunglasses, or contact lens cases'),
(31, 'Footwear', 'Lost and found shoes, sandals, slippers, or boots'),
(32, 'Gadgets/Accessories', 'Lost and found USBs, chargers, smartwatches, and similar devices'),
(33, 'Books/Stationery', 'Lost and found books, notebooks, pens, and educational materials'),
(34, 'Tools/Equipment', 'Lost and found construction tools, musical instruments, etc.'),
(35, 'Toys/Children\'s Items', 'Lost and found stuffed toys, school items, and similar belongings'),
(36, 'Sports Equipment', 'Lost and found balls, rackets, skateboards, and other sporting gear'),
(37, 'Medical Items', 'Lost and found hearing aids, prosthetics, medicines, and medical records'),
(38, 'Transportation', 'Lost and found bicycles, helmets, vehicle plates, and related items'),
(39, 'Money/Cash', 'Reported lost or found cash, with or without wallet'),
(40, 'Luggage', 'Lost and found suitcases, duffle bags, and travel luggage');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `content` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `item_id`, `content`, `created_at`, `updated_at`) VALUES
(2, 6, 32, 'Hi sir, parang ka hawing yan ng nakita d2 sa butag', '2025-04-16 10:28:07', '2025-04-16 10:28:07'),
(39, 2, 27, 'asd', '2025-05-29 08:48:04', '2025-05-29 08:48:04'),
(41, 2, 27, 'asd', '2025-06-23 01:23:49', '2025-06-23 01:23:49'),
(43, 2, 33, 'Oh! mao yun ang nawara sa aquino.', '2025-09-12 14:34:22', '2025-09-12 14:34:22'),
(44, 2, 50, 'asdasdasda', '2025-10-02 17:25:50', '2025-10-02 17:25:50');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `sender_id`, `receiver_id`, `message`, `created_at`, `updated_at`) VALUES
(1, 2, 8, 'asd', '2025-06-08 05:02:59', '2025-06-08 05:02:59'),
(2, 2, 8, 'asd2', '2025-06-08 05:03:31', '2025-06-08 05:03:31'),
(3, 2, 6, 'Hi', '2025-06-08 05:16:53', '2025-06-08 05:16:53'),
(4, 6, 2, 'Hi din', '2025-06-08 05:17:09', '2025-06-08 05:17:09'),
(5, 2, 6, 'try', '2025-06-08 05:22:41', '2025-06-08 05:22:41'),
(6, 6, 2, 'asd', '2025-06-08 05:23:02', '2025-06-08 05:23:02'),
(7, 6, 2, '123', '2025-06-08 05:38:53', '2025-06-08 05:38:53'),
(8, 2, 6, '321', '2025-06-08 05:39:02', '2025-06-08 05:39:02'),
(9, 6, 2, 'I am edward', '2025-06-08 06:07:15', '2025-06-08 06:07:15'),
(10, 6, 2, 'Hi', '2025-06-08 06:18:01', '2025-06-08 06:18:01'),
(11, 6, 2, 'I am Edward', '2025-06-08 06:18:19', '2025-06-08 06:18:19'),
(12, 2, 6, 'ok', '2025-06-08 06:18:31', '2025-06-08 06:18:31'),
(13, 2, 6, 'asd', '2025-06-08 06:19:24', '2025-06-08 06:19:24'),
(14, 2, 6, 'This is a message from Jobel', '2025-06-08 08:29:42', '2025-06-08 08:29:42'),
(15, 6, 2, 'This is message from edward', '2025-06-08 09:00:11', '2025-06-08 09:00:11'),
(16, 6, 2, 'message 1', '2025-06-08 09:44:51', '2025-06-08 09:44:51'),
(17, 6, 2, 'recieve', '2025-06-08 09:54:40', '2025-06-08 09:54:40'),
(18, 2, 6, 'try3', '2025-06-08 10:05:56', '2025-06-08 10:05:56'),
(19, 6, 2, 'asdass', '2025-06-08 10:07:44', '2025-06-08 10:07:44'),
(20, 2, 6, 'dfgdfgzdfgxgdz', '2025-06-09 08:15:43', '2025-06-09 08:15:43'),
(21, 2, 6, '111', '2025-06-09 08:22:56', '2025-06-09 08:22:56'),
(22, 2, 6, '222', '2025-06-09 08:30:39', '2025-06-09 08:30:39'),
(23, 2, 6, '222', '2025-06-09 08:30:42', '2025-06-09 08:30:42'),
(24, 2, 6, '222', '2025-06-09 08:30:42', '2025-06-09 08:30:42'),
(25, 2, 6, '222', '2025-06-09 08:30:43', '2025-06-09 08:30:43'),
(26, 2, 6, '222', '2025-06-09 08:30:43', '2025-06-09 08:30:43'),
(27, 2, 6, '222', '2025-06-09 08:30:48', '2025-06-09 08:30:48'),
(28, 2, 6, '333', '2025-06-09 08:53:50', '2025-06-09 08:53:50'),
(29, 2, 6, '444', '2025-06-09 08:56:30', '2025-06-09 08:56:30'),
(30, 2, 6, '555', '2025-06-09 09:02:18', '2025-06-09 09:02:18'),
(31, 2, 6, '666', '2025-06-09 09:12:34', '2025-06-09 09:12:34'),
(32, 2, 6, '777', '2025-06-11 06:05:48', '2025-06-11 06:05:48'),
(33, 2, 6, '888', '2025-06-11 06:13:29', '2025-06-11 06:13:29'),
(34, 2, 6, 'asd', '2025-06-13 07:00:46', '2025-06-13 07:00:46'),
(35, 2, 6, 'asd2', '2025-06-12 16:19:20', '2025-06-12 16:19:20'),
(36, 6, 2, 'ok', '2025-06-12 16:23:10', '2025-06-12 16:23:10'),
(37, 2, 6, 'ok22', '2025-06-12 16:24:15', '2025-06-12 16:24:15'),
(38, 6, 2, 'o', '2025-06-12 16:25:04', '2025-06-12 16:25:04'),
(39, 2, 6, 'ok', '2025-06-12 16:26:37', '2025-06-12 16:26:37'),
(40, 6, 2, 'jobel', '2025-06-12 16:28:27', '2025-06-12 16:28:27'),
(41, 2, 6, 'edward', '2025-06-12 16:33:23', '2025-06-12 16:33:23'),
(42, 6, 2, 'jobel', '2025-06-12 16:38:55', '2025-06-12 16:38:55'),
(43, 2, 6, 'o', '2025-06-12 16:40:02', '2025-06-12 16:40:02'),
(44, 2, 6, 'f', '2025-06-12 16:47:22', '2025-06-12 16:47:22'),
(45, 6, 2, '123', '2025-06-14 04:49:40', '2025-06-14 04:49:40'),
(46, 6, 2, 'm', '2025-06-14 04:51:53', '2025-06-14 04:51:53'),
(47, 2, 6, 'y', '2025-06-14 05:03:17', '2025-06-14 05:03:17'),
(48, 6, 2, 'y2', '2025-06-14 16:22:44', '2025-06-14 16:22:44'),
(49, 6, 2, 'y3', '2025-06-14 22:01:24', '2025-06-14 22:01:24'),
(50, 6, 2, 'ttt', '2025-06-14 22:12:03', '2025-06-14 22:12:03'),
(51, 2, 15, 'Maryjane', '2025-06-24 17:35:56', '2025-06-24 17:35:56'),
(52, 2, 6, 'asd', '2025-06-27 15:47:24', '2025-06-27 15:47:24'),
(53, 2, 6, 'asd', '2025-06-27 15:47:30', '2025-06-27 15:47:30'),
(54, 2, 6, 'asd', '2025-06-27 15:51:15', '2025-06-27 15:51:15'),
(55, 2, 6, '1', '2025-06-27 15:51:30', '2025-06-27 15:51:30'),
(56, 2, 6, '11', '2025-06-27 15:51:42', '2025-06-27 15:51:42'),
(57, 2, 6, '111', '2025-06-27 15:51:56', '2025-06-27 15:51:56'),
(58, 2, 6, '345', '2025-06-27 15:52:58', '2025-06-27 15:52:58'),
(59, 2, 6, 'sssssssssssssssssssssssssssssssssssss', '2025-06-27 15:53:03', '2025-06-27 15:53:03'),
(60, 2, 6, 'asd', '2025-06-27 15:54:02', '2025-06-27 15:54:02'),
(61, 2, 6, 'v', '2025-06-27 15:54:05', '2025-06-27 15:54:05'),
(62, 2, 6, 'sdf', '2025-06-27 16:01:26', '2025-06-27 16:01:26'),
(63, 2, 6, 'sss', '2025-06-27 16:01:37', '2025-06-27 16:01:37'),
(64, 2, 6, 'asd', '2025-06-27 16:05:08', '2025-06-27 16:05:08'),
(65, 2, 6, 'a', '2025-06-27 16:07:20', '2025-06-27 16:07:20'),
(66, 2, 6, 'v', '2025-06-27 16:07:57', '2025-06-27 16:07:57'),
(67, 2, 6, 'df', '2025-06-27 16:13:13', '2025-06-27 16:13:13'),
(68, 2, 6, 'c', '2025-06-27 16:18:32', '2025-06-27 16:18:32'),
(69, 2, 6, 'hjk', '2025-06-27 16:18:47', '2025-06-27 16:18:47'),
(70, 2, 6, 'asd', '2025-06-27 16:23:29', '2025-06-27 16:23:29'),
(71, 2, 6, 'bb', '2025-06-27 16:33:14', '2025-06-27 16:33:14'),
(72, 2, 6, 'c', '2025-06-27 16:38:07', '2025-06-27 16:38:07'),
(73, 2, 6, 'x', '2025-06-27 16:48:15', '2025-06-27 16:48:15'),
(74, 6, 2, 'xxx', '2025-06-27 16:48:40', '2025-06-27 16:48:40'),
(75, 6, 2, 'asdaa', '2025-06-27 16:49:42', '2025-06-27 16:49:42'),
(76, 6, 2, 'tt', '2025-06-27 16:54:32', '2025-06-27 16:54:32'),
(77, 2, 6, 'nn', '2025-06-27 16:54:40', '2025-06-27 16:54:40'),
(78, 2, 6, 'asd', '2025-06-27 17:47:30', '2025-06-27 17:47:30'),
(79, 6, 2, 'asdasd', '2025-06-27 17:47:37', '2025-06-27 17:47:37'),
(80, 6, 2, 'q', '2025-06-27 18:17:48', '2025-06-27 18:17:48'),
(81, 6, 2, 'a', '2025-06-27 18:40:36', '2025-06-27 18:40:36'),
(82, 6, 2, 'a', '2025-06-27 18:41:07', '2025-06-27 18:41:07'),
(83, 2, 6, 'hey', '2025-06-27 18:44:41', '2025-06-27 18:44:41'),
(84, 6, 2, 'asdasd', '2025-06-27 18:49:36', '2025-06-27 18:49:36'),
(85, 6, 2, 'a', '2025-06-27 18:49:44', '2025-06-27 18:49:44'),
(86, 2, 6, 'a', '2025-06-27 19:00:19', '2025-06-27 19:00:19'),
(87, 2, 6, 'aa', '2025-06-27 19:00:34', '2025-06-27 19:00:34'),
(88, 2, 6, 'aaa3', '2025-06-27 19:08:37', '2025-06-27 19:08:37'),
(89, 16, 2, 'q', '2025-06-28 03:48:16', '2025-06-28 03:48:16'),
(90, 16, 2, 'qq', '2025-06-28 03:48:44', '2025-06-28 03:48:44'),
(91, 2, 16, 'qa', '2025-06-28 03:51:38', '2025-06-28 03:51:38'),
(92, 2, 16, 'm', '2025-06-28 04:13:44', '2025-06-28 04:13:44'),
(93, 16, 2, 'm2', '2025-06-28 04:22:26', '2025-06-28 04:22:26'),
(94, 16, 2, 'asd', '2025-06-28 04:22:33', '2025-06-28 04:22:33'),
(95, 16, 2, 'a', '2025-06-28 04:22:47', '2025-06-28 04:22:47'),
(96, 16, 2, 'a2', '2025-06-28 04:24:31', '2025-06-28 04:24:31'),
(97, 16, 2, 'a3', '2025-06-28 04:24:40', '2025-06-28 04:24:40'),
(98, 16, 2, 'asd', '2025-06-28 04:28:16', '2025-06-28 04:28:16'),
(99, 16, 2, 'asd2', '2025-06-28 04:28:24', '2025-06-28 04:28:24'),
(100, 2, 16, 'hey', '2025-06-28 04:28:47', '2025-06-28 04:28:47'),
(101, 2, 6, 'asdasdasdasdasd', '2025-06-29 01:35:50', '2025-06-29 01:35:50'),
(102, 2, 6, 'a', '2025-06-29 03:58:09', '2025-06-29 03:58:09'),
(103, 6, 2, 'a2', '2025-06-29 03:58:15', '2025-06-29 03:58:15'),
(104, 2, 6, 'a3', '2025-09-04 16:54:04', '2025-09-04 16:54:04'),
(105, 6, 2, 'a4', '2025-09-04 16:54:53', '2025-09-04 16:54:53'),
(106, 6, 2, 'DGDRTZDRZE', '2025-10-12 23:34:25', '2025-10-12 23:34:25');

-- --------------------------------------------------------

--
-- Table structure for table `contact_admin`
--

CREATE TABLE `contact_admin` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contact_admin`
--

INSERT INTO `contact_admin` (`id`, `name`, `email`, `message`, `created_at`, `updated_at`) VALUES
(1, 'jobel v. golde', 'jobelgolde12@gmail.com', 'a', '2025-03-30 13:42:57', '2025-03-30 13:42:57');

-- --------------------------------------------------------

--
-- Table structure for table `denied_request`
--

CREATE TABLE `denied_request` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `request_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `denied_request`
--

INSERT INTO `denied_request` (`id`, `request_id`, `user_id`, `reason`, `created_at`, `updated_at`) VALUES
(1, '13', '6', 'The item you are trying to post is violate to our policy', '2025-09-11 23:32:26', '2025-09-11 23:32:26'),
(2, '18', '6', 'The information contains profanity', '2025-09-21 08:07:42', '2025-09-21 08:07:42'),
(3, '17', '6', 'Contains scam', '2025-09-21 08:08:33', '2025-09-21 08:08:33'),
(4, '16', '6', 'asdasdas', '2025-09-21 08:08:48', '2025-09-21 08:08:48'),
(5, '15', '6', 'The item you trying to post is already claimed.', '2025-09-21 08:09:44', '2025-09-21 08:09:44'),
(6, '19', '6', 'Uncategorize item', '2025-10-02 16:51:16', '2025-10-02 16:51:16');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `failed_jobs`
--

INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(1, '9099bc10-f80c-4d83-976c-f814562f01a9', 'database', 'default', '{\"uuid\":\"9099bc10-f80c-4d83-976c-f814562f01a9\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\MessageModel\\\";s:2:\\\"id\\\";i:22;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 'Illuminate\\Broadcasting\\BroadcastException: Pusher error: Timestamp expired: Given timestamp (2025-06-09T02:12:03Z) not within 600s of server time (2025-06-08T11:11:54Z)\n. in C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php:164\nStack trace:\n#0 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), \'App\\\\Events\\\\NewM...\', Array)\n#1 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#2 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#7 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#8 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#9 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#11 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#12 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#13 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#27 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#35 {main}', '2025-06-09 09:12:09'),
(2, '8b02a658-3c2f-405d-b5c5-7096d0685d0f', 'database', 'default', '{\"uuid\":\"8b02a658-3c2f-405d-b5c5-7096d0685d0f\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\MessageModel\\\";s:2:\\\"id\\\";i:23;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 'Illuminate\\Broadcasting\\BroadcastException: Pusher error: Timestamp expired: Given timestamp (2025-06-09T02:12:09Z) not within 600s of server time (2025-06-08T11:11:55Z)\n. in C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php:164\nStack trace:\n#0 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), \'App\\\\Events\\\\NewM...\', Array)\n#1 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#2 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#7 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#8 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#9 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#11 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#12 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#13 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#27 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#35 {main}', '2025-06-09 09:12:10'),
(3, 'c0e9d9a3-f527-473f-be09-15f102038321', 'database', 'default', '{\"uuid\":\"c0e9d9a3-f527-473f-be09-15f102038321\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\MessageModel\\\";s:2:\\\"id\\\";i:24;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 'Illuminate\\Broadcasting\\BroadcastException: Pusher error: Timestamp expired: Given timestamp (2025-06-09T02:12:10Z) not within 600s of server time (2025-06-08T11:11:56Z)\n. in C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php:164\nStack trace:\n#0 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), \'App\\\\Events\\\\NewM...\', Array)\n#1 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#2 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#7 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#8 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#9 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#11 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#12 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#13 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#27 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#35 {main}', '2025-06-09 09:12:10'),
(4, '91e63737-1fc6-488c-874c-3c58ac6ccc7e', 'database', 'default', '{\"uuid\":\"91e63737-1fc6-488c-874c-3c58ac6ccc7e\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\MessageModel\\\";s:2:\\\"id\\\";i:25;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 'Illuminate\\Broadcasting\\BroadcastException: Pusher error: Timestamp expired: Given timestamp (2025-06-09T02:12:10Z) not within 600s of server time (2025-06-08T11:11:56Z)\n. in C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php:164\nStack trace:\n#0 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), \'App\\\\Events\\\\NewM...\', Array)\n#1 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#2 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#7 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#8 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#9 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#11 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#12 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#13 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#27 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#35 {main}', '2025-06-09 09:12:10'),
(5, '901edaba-afad-4211-8099-07b09dc6592e', 'database', 'default', '{\"uuid\":\"901edaba-afad-4211-8099-07b09dc6592e\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\MessageModel\\\";s:2:\\\"id\\\";i:26;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 'Illuminate\\Broadcasting\\BroadcastException: Pusher error: Timestamp expired: Given timestamp (2025-06-09T02:12:10Z) not within 600s of server time (2025-06-08T11:11:56Z)\n. in C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php:164\nStack trace:\n#0 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), \'App\\\\Events\\\\NewM...\', Array)\n#1 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#2 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#7 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#8 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#9 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#11 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#12 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#13 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#27 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#35 {main}', '2025-06-09 09:12:10');
INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(6, '19e94896-7d12-4a67-a230-2bd613c5dc0d', 'database', 'default', '{\"uuid\":\"19e94896-7d12-4a67-a230-2bd613c5dc0d\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\MessageModel\\\";s:2:\\\"id\\\";i:27;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 'Illuminate\\Broadcasting\\BroadcastException: Pusher error: Timestamp expired: Given timestamp (2025-06-09T02:12:10Z) not within 600s of server time (2025-06-08T11:11:56Z)\n. in C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php:164\nStack trace:\n#0 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), \'App\\\\Events\\\\NewM...\', Array)\n#1 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#2 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#7 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#8 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#9 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#11 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#12 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#13 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#27 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#35 {main}', '2025-06-09 09:12:10'),
(7, '36861dbb-dd7c-4108-9771-90fc1b4658ba', 'database', 'default', '{\"uuid\":\"36861dbb-dd7c-4108-9771-90fc1b4658ba\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\MessageModel\\\";s:2:\\\"id\\\";i:28;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 'Illuminate\\Broadcasting\\BroadcastException: Pusher error: Timestamp expired: Given timestamp (2025-06-09T02:12:10Z) not within 600s of server time (2025-06-08T11:11:56Z)\n. in C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php:164\nStack trace:\n#0 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), \'App\\\\Events\\\\NewM...\', Array)\n#1 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#2 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#7 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#8 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#9 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#11 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#12 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#13 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#27 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#35 {main}', '2025-06-09 09:12:10'),
(8, '0b468667-7ed8-42ed-a4dc-b0c35b92c8c8', 'database', 'default', '{\"uuid\":\"0b468667-7ed8-42ed-a4dc-b0c35b92c8c8\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\MessageModel\\\";s:2:\\\"id\\\";i:29;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 'Illuminate\\Broadcasting\\BroadcastException: Pusher error: Timestamp expired: Given timestamp (2025-06-09T02:12:10Z) not within 600s of server time (2025-06-08T11:11:56Z)\n. in C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php:164\nStack trace:\n#0 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), \'App\\\\Events\\\\NewM...\', Array)\n#1 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#2 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#7 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#8 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#9 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#11 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#12 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#13 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#27 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#35 {main}', '2025-06-09 09:12:10'),
(9, '82e1d1ca-3fe9-4383-832d-95e9edbdc8fe', 'database', 'default', '{\"uuid\":\"82e1d1ca-3fe9-4383-832d-95e9edbdc8fe\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\MessageModel\\\";s:2:\\\"id\\\";i:30;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 'Illuminate\\Broadcasting\\BroadcastException: Pusher error: Timestamp expired: Given timestamp (2025-06-09T02:12:10Z) not within 600s of server time (2025-06-08T11:11:56Z)\n. in C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php:164\nStack trace:\n#0 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), \'App\\\\Events\\\\NewM...\', Array)\n#1 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#2 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#7 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#8 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#9 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#11 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#12 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#13 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#27 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#35 {main}', '2025-06-09 09:12:10'),
(10, 'fdaaca86-4ac1-4d7a-b8c7-f20ec84c2c06', 'database', 'default', '{\"uuid\":\"fdaaca86-4ac1-4d7a-b8c7-f20ec84c2c06\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\MessageModel\\\";s:2:\\\"id\\\";i:31;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 'Illuminate\\Broadcasting\\BroadcastException: Pusher error: Timestamp expired: Given timestamp (2025-06-09T02:12:35Z) not within 600s of server time (2025-06-08T11:12:21Z)\n. in C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php:164\nStack trace:\n#0 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), \'App\\\\Events\\\\NewM...\', Array)\n#1 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#2 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#7 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#8 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#9 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#11 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#12 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#13 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#27 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#35 {main}', '2025-06-09 09:12:35');
INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(11, 'ace15edd-9743-4bdf-8e0b-31ced1687abb', 'database', 'default', '{\"uuid\":\"ace15edd-9743-4bdf-8e0b-31ced1687abb\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\MessageModel\\\";s:2:\\\"id\\\";i:32;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 'Illuminate\\Broadcasting\\BroadcastException: Pusher error: Timestamp expired: Given timestamp (2025-06-12T23:59:28Z) not within 600s of server time (2025-06-12T08:59:14Z)\n. in C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php:164\nStack trace:\n#0 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), \'App\\\\Events\\\\NewM...\', Array)\n#1 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#2 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#7 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#8 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#9 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#11 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#12 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#13 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#27 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#35 {main}', '2025-06-13 06:59:31'),
(12, '6d7af4e8-b9e7-4e32-aae8-63299d0adb5a', 'database', 'default', '{\"uuid\":\"6d7af4e8-b9e7-4e32-aae8-63299d0adb5a\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\MessageModel\\\";s:2:\\\"id\\\";i:33;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 'Illuminate\\Broadcasting\\BroadcastException: Pusher error: Timestamp expired: Given timestamp (2025-06-12T23:59:32Z) not within 600s of server time (2025-06-12T08:59:17Z)\n. in C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php:164\nStack trace:\n#0 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), \'App\\\\Events\\\\NewM...\', Array)\n#1 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#2 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#7 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#8 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#9 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#11 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#12 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#13 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#27 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#35 {main}', '2025-06-13 06:59:32'),
(13, '2d4d8511-03b3-400a-bc4a-cdc8df2f5f5a', 'database', 'default', '{\"uuid\":\"2d4d8511-03b3-400a-bc4a-cdc8df2f5f5a\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":1:{s:7:\\\"message\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:23:\\\"App\\\\Models\\\\MessageModel\\\";s:2:\\\"id\\\";i:34;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 'Illuminate\\Broadcasting\\BroadcastException: Pusher error: Timestamp expired: Given timestamp (2025-06-13T00:00:51Z) not within 600s of server time (2025-06-12T09:00:35Z)\n. in C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster.php:164\nStack trace:\n#0 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(93): Illuminate\\Broadcasting\\Broadcasters\\PusherBroadcaster->broadcast(Object(Illuminate\\Support\\Collection), \'App\\\\Events\\\\NewM...\', Array)\n#1 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle(Object(Illuminate\\Broadcasting\\BroadcastManager))\n#2 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#3 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#4 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#5 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#6 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#7 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#8 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#9 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#10 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Broadcasting\\BroadcastEvent), false)\n#11 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#12 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#13 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#14 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Broadcasting\\BroadcastEvent))\n#15 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#16 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#17 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#18 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#19 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#20 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#21 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#22 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#23 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(95): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(696): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#27 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#28 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#29 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#30 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#31 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#32 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\xampp\\htdocs\\capstoneFolder\\bulan_lost_and_found\\artisan(13): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#35 {main}', '2025-06-13 07:00:51');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `status` enum('Lost','Found','Claimed') NOT NULL,
  `contact_info` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `reported_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `owner_phone_number` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `user_id`, `title`, `description`, `category`, `location`, `status`, `contact_info`, `image_url`, `reported_at`, `created_at`, `updated_at`, `deleted_at`, `resolved_at`, `category_id`, `owner_phone_number`) VALUES
(24, 2, 'a', 'a', 'Accessories', 'Abad Santos (Kambal)', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/A8SqHK67DWBWUYPOaD0mjvefwMkhjgfHPgu7ImYH.jpg', '2025-04-11 17:22:43', '2025-04-12 00:22:43', '2025-04-20 01:26:26', NULL, NULL, NULL, NULL),
(25, 2, 'x', 'x', 'Human', 'A. Bonifacio (Tinurilan)', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/LP1IzIMULcENVXZ18NXokTe0WlXC2CBNgCbNeCkL.jpg', '2025-04-11 17:31:59', '2025-04-12 00:31:59', '2025-04-24 07:25:17', NULL, NULL, NULL, NULL),
(27, 2, 'v', 'v', 'Documents', 'A. Bonifacio (Tinurilan)', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/UmU6GEQi6QVmUZw5bfkZGYxlvz0Jy9fFDZnuiAMi.jpg', '2025-04-11 17:36:58', '2025-04-12 00:36:58', '2025-04-12 00:36:58', NULL, NULL, NULL, NULL),
(31, 6, 'sa user', 'sa user na post kinam', 'Human', 'Aguinaldo (Lipata Dako)', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/41LFPFShRF92IM8Tz3CHXrQSsAaqWzvh9MYsqjsb.jpg', '2025-04-14 02:26:39', '2025-04-14 09:26:39', '2025-05-26 12:08:12', NULL, NULL, NULL, NULL),
(32, 6, 'Grey bag', 'Grey bag po, last seen in Bonga na iwan po sa tricycle', 'Accessories', 'Bonga', 'Lost', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-04-14 14:28:40', '2025-04-14 21:28:40', '2025-09-12 22:37:50', NULL, NULL, NULL, '09811986231'),
(33, 2, 'Bike', 'Black mountain bike, adi po cya dd niyan sa baryo hall eh return ko tabi mamaya sa pulis', 'Sports Equipment', 'Aquino (Imelda)', 'Found', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-04-19 22:38:53', '2025-04-20 05:38:53', '2025-09-12 22:41:24', NULL, NULL, NULL, NULL),
(34, 2, 'asd', NULL, 'Electronics', NULL, 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/NGmGNlpw4Av21w8JzNC3XQKH4AOjXB9Blq4xpbry.jpg', '2025-05-01 01:01:19', '2025-05-01 08:01:19', '2025-05-01 01:03:56', NULL, NULL, NULL, NULL),
(35, 6, 'cat', 'yadi po cya niyan sa baryo hall sa butag, may nag return kanina', 'Pets', 'Butag', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/6kGZwZKxQs8WcQbBOuNQYTDen0AebtEBfaNypfZg.jpg', '2025-05-01 15:08:13', '2025-05-01 22:08:13', '2025-05-26 12:24:30', NULL, '2025-05-26 12:24:30', NULL, NULL),
(36, 2, 'Mountain Bike', 'Lost black mountain bike in Aquino (Imelda). Please contact if found.', 'Sports Equipment', 'Aquino (Imelda)', 'Lost', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-04-19 04:00:00', '2025-04-19 04:00:00', '2025-09-12 22:41:15', NULL, NULL, NULL, NULL),
(37, 2, NULL, NULL, 'Accessories', NULL, 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/37der6UmD8lgUy2BkV1NODORou9HUbfHswILe85o.jpg', '2025-06-20 06:28:03', '2025-06-19 22:28:03', '2025-06-30 03:14:23', NULL, '2025-06-30 03:14:23', NULL, NULL),
(38, 2, 'Key', 'Key of cabinet', 'Keys', 'Bonga', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/cjmMZ846gubmVz4IPPDCmMhK3eZYly3OM1nivCup.jpg', '2025-06-23 08:06:45', '2025-06-23 00:06:45', '2025-06-23 15:10:51', NULL, '2025-06-23 15:10:51', NULL, '09345237624'),
(39, 2, 'mm', 'm', 'Electronics', 'Abad Santos (Kambal)', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/VcHm2M877QvjNh12C30jQgwTVMI9WqG41NYCpHWg.png', '2025-06-23 08:18:22', '2025-06-23 00:18:22', '2025-06-23 00:18:22', NULL, NULL, NULL, NULL),
(40, 2, 'n', 'nn', 'Electronics', 'Aguinaldo (Lipata Dako)', 'Lost', NULL, 'http://127.0.0.1:8000/images/profile.jpeg', '2025-06-23 08:40:15', '2025-06-23 00:40:15', '2025-06-23 00:40:15', NULL, NULL, NULL, NULL),
(41, 2, 'b', 'bb', 'Books/Stationery', 'Aquino (Imelda)', 'Lost', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-06-23 08:42:40', '2025-06-23 00:42:40', '2025-06-23 00:42:40', NULL, NULL, NULL, NULL),
(42, 6, 'Laptop', 'Grey Laptop, last seen on calomagon toda', 'Electronics', 'Calomagon', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/IxCiPDyEOvnmFeFZLMgwijrn7JHmSR1b9BsrUnr2.jpg', '2025-06-23 23:14:30', '2025-06-23 15:14:30', '2025-06-23 15:14:30', NULL, NULL, NULL, NULL),
(43, 2, 'asd2', 'asd', 'Books/Stationery', 'Aguinaldo (Lipata Dako)', 'Lost', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-09-05 00:16:21', '2025-09-04 16:16:21', '2025-09-04 16:16:21', NULL, NULL, NULL, NULL),
(44, 2, 'qwe', 'qweqwe', 'Toys/Children\'s Items', 'Aguinaldo (Lipata Dako)', 'Found', NULL, 'http://127.0.0.1:8000/storage/images/xrmOWlnqesKSlyEXYiowh3kpnvMSfFxgWfA0bXnB.png', '2025-09-05 00:30:36', '2025-09-04 16:30:36', '2025-09-04 16:30:36', NULL, NULL, NULL, NULL),
(45, 6, 'Key', 'I think it is Rusi motor key, nakita ko po d2 sa road side ng Bonga.', 'Keys', 'Bonga', 'Found', NULL, 'http://127.0.0.1:8000/storage/images/s1P9tQqCFh5eUrscSV7ASyvoFdc5GUHLpejrBNBE.jpg', '2025-09-11 08:47:07', '2025-09-11 00:47:07', '2025-09-12 22:37:08', NULL, NULL, NULL, '09811986323'),
(46, 6, 'Dog', 'White Dog last seen d2 sa Calomagon', '1', 'Calomagon', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/KjtQ97FbRd5z5miCYlqwMC83nzgOZV7VqHPTrlGa.jpg', '2025-09-12 02:48:05', '2025-09-11 18:48:05', '2025-09-11 19:02:17', NULL, '2025-09-11 19:02:17', NULL, '09811986323'),
(47, 6, 'CellPhone', 'RealMe c51', '32', 'Gate', 'Lost', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-09-12 02:52:27', '2025-09-11 18:52:27', '2025-09-11 18:52:27', NULL, NULL, NULL, '09811986323'),
(48, 6, 'asd', 'asdasdas', 'Books/Stationery', 'Abad Santos (Kambal)', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/3fgFKMQgVwYJSsXDmqezpxNBV8Ev3v0HvD9Ubssw.jpg', '2025-09-12 02:53:40', '2025-09-11 18:53:40', '2025-09-11 18:53:40', NULL, NULL, NULL, NULL),
(49, 6, 'Dog', 'White Dog last seen d2 sa Calomagon', '1', 'Calomagon', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/pb82UOR2j7Btr28q1wcBzdZ3srHK08nNdoi60pfO.jpg', '2025-09-12 03:03:38', '2025-09-11 19:03:38', '2025-09-11 19:12:26', NULL, '2025-09-11 19:12:26', NULL, '09811986323'),
(50, 6, 'Dog', 'White Dog last seen d2 sa Calomagon', '1', 'Calomagon', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/8IoADZNBHkzid3nFNTKS4j9FA5jM0jlvx8vR9YWC.jpg', '2025-09-12 03:12:41', '2025-09-11 19:12:41', '2025-09-11 19:12:41', NULL, NULL, NULL, '09811986323'),
(51, 2, 'Michael jordan nike', 'sports ware', '29', 'Aguinaldo (Lipata Dako)', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/T4zkq0eOqkyKMEnqtGWWQLTUZJ90CGvvppgxk6zu.jpg', '2025-09-30 02:29:55', '2025-09-29 18:29:55', '2025-10-09 17:47:12', NULL, '2025-10-09 17:47:12', NULL, NULL),
(52, 6, 'asd', 'asdasdas', 'Toys/Children\'s Items', 'Aquino (Imelda)', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/k1F9WqwdEsOzospPedlMGdT8nlmQEDiMwxNejI9q.png', '2025-10-03 00:51:53', '2025-10-02 16:51:53', '2025-10-02 16:52:08', NULL, '2025-10-02 16:52:08', NULL, NULL),
(53, 2, 'backie', 'Black dog.', 'Pets', 'Bonga', 'Lost', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-10-13 07:01:41', '2025-10-12 23:01:41', '2025-10-12 23:01:41', NULL, NULL, NULL, '09460162977'),
(54, 6, 'Dummy data', 'asdasdasdasdas', '34', 'Cocok-Cabitan', 'Lost', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-10-13 07:40:43', '2025-10-12 23:40:43', '2025-10-12 23:40:43', NULL, NULL, NULL, NULL),
(56, 2, 'Silver Citizen Eco-Drive Watch', 'Men’s stainless-steel watch, black dial, leather strap replaced with brown strap, small scratch at 1 o’clock. Engraved inside: “To J., 2019.”', 'Accessories', 'Antipolo', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/JKQvNexnJ6yvPlRRf4YOrPtmlmIJza5OVkc0Oe14.jpg', '2025-10-14 11:19:30', '2025-10-14 03:19:30', '2025-10-14 03:19:30', NULL, NULL, NULL, '09811986323'),
(57, 2, 'Black Bluetooth Earbuds', 'Small charging case with “Lenovo” logo, one earbud missing rubber tip. Found near Jollibee entrance.', 'Gadgets/Accessories', 'Zone 4 (Central Business District)', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/KpzxyXBTNm0Oh5tOxBJeT5jmtQZOxAK3mIWseTZd.jpg', '2025-10-14 11:25:50', '2025-10-14 03:25:50', '2025-10-14 03:25:50', NULL, NULL, NULL, '09460162977');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(82, 'default', '{\"uuid\":\"a596a8aa-8f40-4d92-9adc-60c77f30d039\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":4:{s:9:\\\"sender_id\\\";i:6;s:11:\\\"receiver_id\\\";i:2;s:7:\\\"message\\\";s:10:\\\"DGDRTZDRZE\\\";s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2025-10-13 07:34:25.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1760340869, 1760340869);

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `created_at`, `updated_at`) VALUES
(105, 'A. Bonifacio (Tinurilan)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(106, 'Abad Santos (Kambal)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(107, 'Aguinaldo (Lipata Dako)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(108, 'Antipolo', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(109, 'Aquino (Imelda)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(110, 'Bical', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(111, 'Beguin', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(112, 'Bonga', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(113, 'Butag', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(114, 'Cadandanan', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(115, 'Calomagon', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(116, 'Calpi', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(117, 'Cocok-Cabitan', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(118, 'Daganas', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(119, 'Danao', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(120, 'Dolos', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(121, 'E. Quirino (Pinangomhan)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(122, 'Fabrica', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(123, 'G. Del Pilar (Tanga)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(124, 'Gate', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(125, 'Inararan', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(126, 'J. Gerona (Biton)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(127, 'J.P. Laurel (Pon-od)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(128, 'Jamorawon', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(129, 'Libertad (Calle Putol)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(130, 'Lajong', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(131, 'Magsaysay (Bongog)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(132, 'Managa-naga', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(133, 'Marinab', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(134, 'Nasuje', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(135, 'Montecalvario', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(136, 'N. Roque (Calayugan)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(137, 'Namo', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(138, 'Obrero', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(139, 'Osmeña (Lipata Saday)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(140, 'Otavi', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(141, 'Padre Diaz', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(142, 'Palale', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(143, 'Quezon (Cabarawan)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(144, 'R. Gerona', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(145, 'Recto', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(146, 'Roxas (Busay)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(147, 'Sagrada', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(148, 'San Francisco (Polot)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(149, 'San Isidro (Cabugaan)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(150, 'San Juan Bag-o', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(151, 'San Juan Daan', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(152, 'San Rafael (Togbongon)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(153, 'San Ramon', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(154, 'San Vicente', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(155, 'Santa Remedios', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(156, 'Santa Teresita (Trece)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(157, 'Sigad', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(158, 'Somagongsong', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(159, 'Taromata', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(160, 'Zone 1 (Ilawod)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(161, 'Zone 2 (Sabang)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(162, 'Zone 3 (Central)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(163, 'Zone 4 (Central Business District)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(164, 'Zone 5 (Canipaan)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(165, 'Zone 6 (Baybay)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(166, 'Zone 7 (Iraya)', '2025-04-10 23:03:15', '2025-04-10 23:03:15'),
(167, 'Zone 8 (Loyo)', '2025-04-10 23:03:15', '2025-04-10 23:03:15');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '2025_02_16_011340_add_info_in_items', 2),
(4, '2025_03_30_051046_create_contact_admin_table', 3),
(5, '2025_04_10_224427_create_resolved_cases_table', 4),
(6, '2025_04_12_195704_update_status_column_in_items_table', 5),
(7, '2025_04_12_200908_create_pending_request_table', 6),
(8, '2025_04_19_000725_create_trash_users_table', 7),
(9, '2025_04_19_015601_create_trash_users_info_table', 8),
(10, '2025_04_19_174238_create_resolve_cases_table', 9),
(11, '2025_04_24_003441_add_updated_at_to_notifications_table', 10),
(12, '2025_04_24_043122_create_trash_notification', 11),
(13, '2025_04_26_210508_create_pinned_chats_table', 12),
(14, '2025_05_26_051406_add_resolved_at_to_items_table', 13),
(15, '2025_06_07_204146_add_updated_at_in_contacts', 14),
(16, '2025_06_07_223803_create_jobs_table', 15),
(17, '2025_06_14_070253_add_foriegn_key_in_users_table', 16),
(18, '2025_06_17_234950_add_softdelete_in_announcements_table', 16),
(19, '2025_06_18_070901_add_softdelete_in_notifications_table', 17),
(20, '2025_06_20_055015_add_softdelete_in_users_table', 18),
(21, '2025_06_20_055957_add_softdelete_in_users_table', 19),
(22, '2025_06_20_061800_add_softdelete_in_users_info', 20),
(23, '2025_06_20_225625_add_softdelete_in_items_table', 21),
(24, '2025_06_29_121507_create_removed_pinned_message_table', 22),
(25, '2025_06_30_010100_add_user_id_in_removed_pinned_message_table', 23),
(26, '2025_06_30_052221_create_removed_pinned_messages_table', 24),
(27, '2025_06_30_090442_create_blocked_messages_table', 25),
(28, '2025_07_04_120441_create_archived_items_table', 26),
(29, '2025_07_09_220440_create_my_permission_table', 27),
(30, '2025_09_12_071301_create_denied_request_table', 28),
(31, '2025_07_09_221412_add_default_values_to_my_permission_table', 29),
(32, '2025_10_15_222953_create_total_found_table', 30),
(33, '2025_10_15_222346_create_total_lost_table', 31),
(34, '2025_10_15_225816_add_date_found_in_total_found_table', 32),
(35, '2025_10_15_225639_add_date_lost_in_total_lost_table', 33);

-- --------------------------------------------------------

--
-- Table structure for table `my_permission`
--

CREATE TABLE `my_permission` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `isPhoneAllow` tinyint(1) NOT NULL DEFAULT 1,
  `isEmailAllow` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `my_permission`
--

INSERT INTO `my_permission` (`id`, `user_id`, `isPhoneAllow`, `isEmailAllow`, `created_at`, `updated_at`) VALUES
(1, 2, 0, 1, '2025-09-04 16:40:14', '2025-09-19 15:30:43');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read_status` tinyint(1) DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `title`, `user_id`, `item_id`, `message`, `read_status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(3, 'Item Marked as Resolved', 6, NULL, 'The item you reported has been marked as resolved by the administrator. Thank you for using our service!', 0, '2025-06-20 22:11:26', '2025-05-26 12:08:12', '2025-06-20 22:11:26'),
(4, 'Item Marked as Resolved', 2, NULL, 'The item you reported has been marked as resolved by the administrator. Thank you for using our service!', 1, '2025-09-11 00:25:49', '2025-05-26 12:24:30', '2025-09-11 00:25:49'),
(8, 'Item Marked as Resolved', 2, NULL, 'The item you reported has been marked as resolved by the administrator. Thank you for using our service!', 1, NULL, '2025-06-23 15:01:29', '2025-09-11 15:33:22'),
(9, 'Item Marked as Resolved', 2, NULL, 'The item you reported has been marked as resolved by the administrator. Thank you for using our service!', 0, NULL, '2025-06-23 15:10:51', '2025-06-23 15:10:51'),
(10, 'Item Marked as Resolved', 2, NULL, 'The item you reported has been marked as resolved by the administrator. Thank you for using our service!', 0, NULL, '2025-06-30 03:14:23', '2025-06-30 03:14:23'),
(11, 'Request Denied', 6, NULL, 'Your item request (Blue Backpack) has been denied. Reason: The description provided was not accurate', 1, '2025-09-11 19:42:39', '2025-09-11 01:22:27', '2025-09-11 19:42:39'),
(12, 'Request Approved', 6, NULL, 'Your item request (Dog) has been approved and is now live on the platform.', 1, '2025-09-11 19:40:22', '2025-09-11 18:48:05', '2025-09-11 19:40:22'),
(13, 'Request Approved', 6, NULL, 'Your item request (CellPhone) has been approved and is now live on the platform.', 1, '2025-09-11 19:44:52', '2025-09-11 18:52:27', '2025-09-11 19:44:52'),
(14, 'Request Approved', 6, NULL, 'Your item request (asd) has been approved and is now live on the platform.', 1, NULL, '2025-09-11 18:53:40', '2025-09-11 18:53:59'),
(15, 'Item Marked as Resolved', 6, NULL, 'The item you reported has been marked as resolved by the administrator. Thank you for using our service!', 1, NULL, '2025-09-11 19:02:17', '2025-09-11 19:03:56'),
(16, 'Request Approved', 6, 16, 'Your item request (Dog) has been approved and is now live on the platform.', 1, NULL, '2025-09-11 19:03:38', '2025-09-11 19:07:24'),
(17, 'Item Marked as Resolved', 6, 49, 'The item you reported has been marked as resolved by the administrator. Thank you for using our service!', 1, NULL, '2025-09-11 19:12:26', '2025-09-11 19:39:19'),
(18, 'Request Approved', 6, 50, 'Your item request (Dog) has been approved and is now live on the platform.', 1, NULL, '2025-09-11 19:12:41', '2025-09-11 19:14:10'),
(19, 'Face to Face Verification', 6, 19, 'Hi Edward,  your item (Bulldog) needs to be verified face to face. We encourage you to visit the PNP for additional verification of the item you wish to post.', 1, '2025-09-11 20:02:25', '2025-09-11 19:52:16', '2025-09-11 20:02:25'),
(20, 'Face to Face Verification', 6, 14, 'Hi Edward,  your item (Dummy data) needs to be verified face to face. We encourage you to visit the PNP for additional verification of the item you wish to post.', 1, NULL, '2025-09-11 20:03:45', '2025-09-11 23:46:22'),
(21, 'Request Denied', 6, 13, 'Your item request (Bulldog) has been denied. Reason: The item you are trying to post is violate to our policy', 1, NULL, '2025-09-11 23:32:26', '2025-09-11 23:32:38'),
(22, 'Request Denied', 6, 18, 'Your item request (asd) has been denied. Reason: The information contains profanity', 0, NULL, '2025-09-21 08:07:42', '2025-09-21 08:07:42'),
(23, 'Request Denied', 6, 17, 'Your item request (asd) has been denied. Reason: Contains scam', 0, NULL, '2025-09-21 08:08:33', '2025-09-21 08:08:33'),
(24, 'Request Denied', 6, 16, 'Your item request (asd) has been denied. Reason: asdasdas', 0, NULL, '2025-09-21 08:08:48', '2025-09-21 08:08:48'),
(25, 'Request Denied', 6, 15, 'Your item request (asd) has been denied. Reason: The item you trying to post is already claimed.', 0, NULL, '2025-09-21 08:09:44', '2025-09-21 08:09:44'),
(26, 'Request Denied', 6, 19, 'Your item request (asd) has been denied. Reason: Uncategorize item', 0, NULL, '2025-10-02 16:51:16', '2025-10-02 16:51:16'),
(27, 'Request Approved', 6, 52, 'Your item request (asd) has been approved and is now live on the platform.', 0, NULL, '2025-10-02 16:51:53', '2025-10-02 16:51:53'),
(28, 'Item Marked as Resolved', 6, 52, 'The item you reported has been marked as resolved by the administrator. Thank you for using our service!', 1, NULL, '2025-10-02 16:52:08', '2025-10-12 23:08:38'),
(29, 'Item Marked as Resolved', 2, 51, 'The item you reported has been marked as resolved by the administrator. Thank you for using our service!', 0, NULL, '2025-10-09 17:47:12', '2025-10-09 17:47:12'),
(30, 'Request Approved', 6, 54, 'Your item request (Dummy data) has been approved and is now live on the platform.', 0, NULL, '2025-10-12 23:40:43', '2025-10-12 23:40:43'),
(31, 'Request Approved', 15, 55, 'Your item request (Silver Citizen Eco-Drive Watch) has been approved and is now live on the platform.', 0, NULL, '2025-10-14 02:03:51', '2025-10-14 02:03:51');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('jobelgolde45@gmail.com', '$2y$12$eJWQlg1tmzwvOUdIEt9i2eTtaIWOlgwCy4orF5rzaQVO1yS.tXUgC', '2025-06-24 16:39:44');

-- --------------------------------------------------------

--
-- Table structure for table `pending_requests`
--

CREATE TABLE `pending_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `status` enum('Lost','Found','Claimed') NOT NULL DEFAULT 'Lost',
  `contact_info` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `reported_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `owner_phone_number` varchar(255) DEFAULT NULL,
  `pending_status` enum('pending','approve') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pinned_chats`
--

CREATE TABLE `pinned_chats` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `message_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pinned_chats`
--

INSERT INTO `pinned_chats` (`id`, `user_id`, `message_id`, `created_at`, `updated_at`) VALUES
(1, 2, NULL, '2025-04-27 04:42:37', '2025-04-27 04:42:37'),
(3, 1, NULL, '2025-04-27 06:56:45', '2025-04-27 06:56:45'),
(4, 6, NULL, '2025-04-27 06:56:48', '2025-04-27 06:56:48'),
(5, 7, NULL, '2025-05-05 08:19:24', '2025-05-05 08:19:24'),
(6, 8, NULL, '2025-05-06 22:48:43', '2025-05-06 22:48:43'),
(7, 9, NULL, '2025-05-08 08:54:20', '2025-05-08 08:54:20'),
(8, 16, 89, '2025-06-28 03:48:33', '2025-06-28 03:48:33'),
(9, 13, NULL, '2025-06-29 15:29:25', '2025-06-29 15:29:25');

-- --------------------------------------------------------

--
-- Table structure for table `removed_pinned_messages`
--

CREATE TABLE `removed_pinned_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `removed_user` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resolve_cases`
--

CREATE TABLE `resolve_cases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `item_id` varchar(255) NOT NULL,
  `resolution_status` enum('Claimed','Returned','Other') NOT NULL DEFAULT 'Claimed',
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `status` enum('Lost','Found','Claimed') NOT NULL,
  `contact_info` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `owner_phone_number` varchar(255) DEFAULT NULL,
  `resolved_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('Y9zq4f4MvGETe94UinUOvdofNOUiQYRfkjxrrpOc', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZ0pLa0o3UHkwU3QyMmpiWlZxU25mamhHalZzeEhERmdqWWZpd3lwRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9kYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO30=', 1760582236);

-- --------------------------------------------------------

--
-- Table structure for table `total_found`
--

CREATE TABLE `total_found` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `total` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `date_found` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `total_found`
--

INSERT INTO `total_found` (`id`, `total`, `created_at`, `updated_at`, `date_found`) VALUES
(1, 1, '2024-04-01 02:00:00', NULL, '2024-04-01'),
(2, 1, '2024-04-15 06:30:00', NULL, '2024-04-15'),
(3, 1, '2024-04-30 02:10:00', NULL, '2024-04-30'),
(4, 1, '2024-05-02 01:30:00', NULL, '2024-05-02'),
(5, 1, '2024-05-16 04:45:00', NULL, '2024-05-16'),
(6, 1, '2024-05-28 07:20:00', NULL, '2024-05-28'),
(7, 1, '2025-04-03 00:30:00', NULL, '2025-04-03'),
(8, 1, '2025-04-14 05:15:00', NULL, '2025-04-14'),
(9, 1, '2025-04-20 07:45:00', NULL, '2025-04-20'),
(10, 1, '2025-04-26 03:20:00', NULL, '2025-04-26');

-- --------------------------------------------------------

--
-- Table structure for table `total_lost`
--

CREATE TABLE `total_lost` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `total` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `date_lost` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `total_lost`
--

INSERT INTO `total_lost` (`id`, `total`, `created_at`, `updated_at`, `date_lost`) VALUES
(1, 1, '2024-04-01 02:00:00', NULL, '2024-04-01'),
(2, 1, '2024-04-15 06:30:00', NULL, '2024-04-15'),
(3, 1, '2024-04-30 01:15:00', NULL, '2024-04-30'),
(6, 1, '2024-05-01 00:00:00', NULL, '2024-05-01'),
(7, 1, '2024-05-05 03:30:00', NULL, '2024-05-05'),
(8, 1, '2024-05-10 06:45:00', NULL, '2024-05-10'),
(9, 1, '2024-05-15 01:15:00', NULL, '2024-05-15'),
(10, 1, '2024-05-20 08:20:00', NULL, '2024-05-20'),
(11, 1, '2024-05-25 05:10:00', NULL, '2024-05-25'),
(12, 1, '2024-05-31 02:05:00', NULL, '2024-05-31'),
(13, 1, '2025-04-05 01:15:00', NULL, '2025-04-05'),
(14, 1, '2025-04-12 03:45:00', NULL, '2025-04-12'),
(15, 1, '2025-04-18 06:20:00', NULL, '2025-04-18'),
(16, 1, '2025-04-22 08:30:00', NULL, '2025-04-22'),
(17, 1, '2025-04-29 02:10:00', NULL, '2025-04-29');

-- --------------------------------------------------------

--
-- Table structure for table `trash`
--

CREATE TABLE `trash` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `lost_found_item_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `status` enum('Lost','Found','Claimed') NOT NULL DEFAULT 'Lost',
  `contact_info` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trash`
--

INSERT INTO `trash` (`id`, `user_id`, `lost_found_item_id`, `title`, `description`, `category`, `status`, `contact_info`, `image_url`, `deleted_at`, `created_at`, `updated_at`) VALUES
(5, 6, 5, 'asd', 'asdasdsd', 'Human', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/vdBMvvh7oX3Oamdn1UQfxtEvsiHGfxyj9F0uchjI.jpg', NULL, '2025-05-01 22:30:36', '2025-05-01 22:30:36');

-- --------------------------------------------------------

--
-- Table structure for table `trash_users`
--

CREATE TABLE `trash_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trash_users_info`
--

CREATE TABLE `trash_users_info` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `profile_pic` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `facebook_links` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user','guest') NOT NULL DEFAULT 'user',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `deleted_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Boggart', 'user@gmail.com', '2025-02-15 16:30:15', '$2y$12$5Pq.xx7ezXf5lEGnQGlIW.wVj8q7z7RfloQO6.C9/sbA.x/PnXxOm', 'user', NULL, NULL, '2025-02-15 16:29:19', '2025-02-16 08:05:53'),
(2, 'Jobel Golde', 'jobelgolde12@gmail.com', '2025-02-15 17:30:39', '$2y$12$eFEzZ8j6sTzlCgzFEDeuCueIAVMZxJFQYcVf9U1bl0FfXxLfdsA/S', 'admin', NULL, NULL, '2025-02-16 01:30:39', '2025-02-16 08:05:28'),
(5, 'Boggart', 'iamboggart@gmail.com', NULL, '$2y$12$6oMMOJIdNII5SCv5gxFCTewEkwtFlsmHbn1mw9fuXPVkE/Jnc1Pma', 'user', NULL, NULL, '2025-04-13 03:17:17', '2025-04-12 21:50:19'),
(6, 'Edward', 'jobelgolde45@gmail.com', '2025-06-24 19:32:25', '$2y$12$UNOojylI.4MQGMhJ1mxMJ.yMyqAVp4flmFirH79FvqYir77EXirtW', 'user', NULL, NULL, '2025-04-13 03:19:42', '2025-06-24 19:32:25'),
(7, 'Lenit', 'lenit@gmail.com', '2025-05-03 01:25:47', '$2y$12$QHau.MvDLoJhRa7NBjOpGuh8/ynLI5d57PYT4LsjzQLDHcbhoHH/O', 'user', NULL, NULL, '2025-05-03 01:24:43', '2025-05-03 01:25:47'),
(8, 'maryjane', 'maryjane@gmail.com', NULL, '$2y$12$ZEl0WwKQt.xGraXA1UYkvegzz09V7Up0v6tp9dciwoks2pQtEP/Jq', 'user', NULL, NULL, '2025-05-03 01:38:07', '2025-05-03 01:38:07'),
(9, 'asd', 'asd@gmail.com', NULL, '$2y$12$SmJh2U/C6O7Pg3jQ1fiO4OQGzDbbj1ikddbfUXExfhhE3sX1WsZgy', 'user', NULL, NULL, '2025-05-06 22:59:58', '2025-05-06 22:59:58'),
(11, 'qwe', 'qwe@gmail.com', NULL, '$2y$12$xUk3Viy.ngCmypeMjJ8fme20fb4fpkWfN2igMBAqUeSXfWGAyQxIO', 'user', '2025-06-20 04:01:40', NULL, '2025-05-07 05:34:10', '2025-06-20 04:01:40'),
(13, 'Kristina Lumabad', 'tina@gmail.com', NULL, '$2y$12$i/cVbnpOZnsex1tAFGois.qy4N8cMK82dKcacTrQtzdwTNH5gVanS', 'user', NULL, NULL, '2025-06-15 19:26:51', '2025-06-15 19:26:51'),
(15, 'maryjane', 'egitwork@gmail.com', '2025-06-24 17:15:26', '$2y$12$QsWVLmexbkZEGUqQROBtTeqcldwYFfkc989K9wMJYEoLDMwPVg.56', 'user', '2025-10-14 02:35:14', NULL, '2025-06-24 17:14:51', '2025-10-14 02:35:14'),
(16, 'capstone', 'capstoneproj1to2@gmail.com', '2025-06-28 03:47:56', '$2y$12$UUGUh0L8m3ScIxOLnEndCuPwN5worhcCnih0HZZtJLENVnqf2yF2e', 'user', NULL, NULL, '2025-06-28 03:47:06', '2025-06-28 03:47:56'),
(18, 'Janiemer', 'jobelgolde1@gmail.com', NULL, '$2y$12$xF1tDpDch9vovE0tDdaQyOPOGpxbkZoAwbRSlnBVxlp7Hr0DmWz4K', 'user', '2025-07-01 15:31:36', NULL, '2025-07-01 15:27:02', '2025-07-01 15:31:36'),
(20, 'Bibat', 'jobelgolde43@gmail.com', '2025-07-01 15:40:39', '$2y$12$4DzAzwvdNwdBQycfWzkaweOBSNDmFsz6mvlL/7SQkxsVcxLr.P2aa', 'user', NULL, NULL, '2025-07-01 15:39:24', '2025-07-01 15:40:39'),
(21, 'Arabella', 'jobelgolde44@gmail.com', '2025-07-01 15:51:29', '$2y$12$FUDUjQXr1cEJB7ySNkjKy.e773WfBypfDU9Z/HjQqCIWX88e3blBy', 'user', NULL, NULL, '2025-07-01 15:49:31', '2025-07-01 15:51:29'),
(22, 'N Prado', 'nprado@sorsu.edu.ph', NULL, '$2y$12$AStVXSAAKQQPdtF24I/yw.ZZKl6ZhM0mJipVYi5nZf1RFUyfSdgzC', 'user', NULL, NULL, '2025-10-06 18:24:25', '2025-10-06 18:24:25'),
(23, 'Christine bibat', 'ruitrg@gmai.com', NULL, '$2y$12$70QdszyXOnKx6Dn7Le6xYuvKc/YWJ0QYycbEENHQG2xZoHO7..C6y', 'user', NULL, NULL, '2025-10-12 22:47:06', '2025-10-12 22:47:06');

-- --------------------------------------------------------

--
-- Table structure for table `users_info`
--

CREATE TABLE `users_info` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `profile_pic` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `facebook_links` varchar(2048) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users_info`
--

INSERT INTO `users_info` (`id`, `user_id`, `profile_pic`, `address`, `bio`, `contact`, `facebook_links`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 4, '/images/profile.png', NULL, 'sample', NULL, NULL, NULL, '2025-02-16 20:50:13', '2025-02-16 20:50:13'),
(2, 2, 'images/fE9C8DgwKG0BtbPDJN5zCLdbwDms9mgZAY5fWMFN.png', 'Bonga, Bulan, Sorsogon', 'Coding is like understanding women.', '09460162977', 'https://www.facebook.com/jobelGolde', NULL, '2025-04-13 03:17:17', '2025-09-09 20:11:49'),
(3, 6, 'images/eOVHYGZxLYK1xFkgJjIiS5Cuq3bPLiTVndJd7qFM.jpg', NULL, NULL, NULL, NULL, NULL, '2025-04-13 03:19:42', '2025-09-06 03:51:04'),
(6, 9, 'http://127.0.0.1:8000/images/profile.jpeg', NULL, NULL, NULL, NULL, NULL, '2025-05-06 22:59:58', '2025-05-06 22:59:58'),
(7, 11, 'images/4Re8iSQKFOilljx6uAoAwn7eoxZ4bKxcoNu424DV.jpg', NULL, NULL, NULL, NULL, '2025-06-20 04:01:40', '2025-05-07 05:34:10', '2025-06-20 04:01:40'),
(9, 13, 'http://127.0.0.1:8000/images/profile.jpeg', NULL, NULL, '09460162977', NULL, NULL, '2025-06-15 19:26:51', '2025-06-15 19:26:51'),
(10, 14, 'http://127.0.0.1:8000/images/profile.jpeg', NULL, NULL, '09124003819', NULL, '2025-06-24 17:11:04', '2025-06-24 16:45:54', '2025-06-24 17:11:04'),
(11, 15, 'http://127.0.0.1:8000/images/profile.jpeg', NULL, NULL, '09124003819', NULL, NULL, '2025-06-24 17:14:51', '2025-06-24 17:14:51'),
(12, 16, 'http://127.0.0.1:8000/images/profile.jpeg', NULL, NULL, '09345636235', NULL, NULL, '2025-06-28 03:47:06', '2025-06-28 03:47:06'),
(16, 20, 'images/profile.jpeg', NULL, NULL, '09345363335', NULL, NULL, '2025-07-01 15:39:25', '2025-07-01 15:39:25'),
(17, 21, 'images/6864740bb680d.jpeg', NULL, NULL, '09345348345', NULL, NULL, '2025-07-01 15:49:31', '2025-07-01 15:49:31'),
(18, 22, '', NULL, NULL, '09123456789', NULL, NULL, '2025-10-06 18:24:25', '2025-10-06 18:24:25'),
(19, 23, '', NULL, NULL, '09460162977', NULL, NULL, '2025-10-12 22:47:06', '2025-10-12 22:47:06');

-- --------------------------------------------------------

--
-- Table structure for table `view_later`
--

CREATE TABLE `view_later` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `view_later`
--

INSERT INTO `view_later` (`id`, `user_id`, `item_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 32, '2025-06-23 12:55:31', '2025-06-23 12:55:31', '2025-06-23 12:55:31'),
(3, 2, 33, '2025-06-23 12:55:52', '2025-06-23 12:55:52', '2025-06-23 12:55:52'),
(4, 2, 32, '2025-06-23 12:59:08', '2025-06-23 12:59:08', '2025-06-23 12:59:08'),
(5, 2, 32, '2025-06-23 13:00:48', '2025-06-23 13:00:48', '2025-06-23 13:00:48'),
(6, 2, 33, '2025-06-24 01:03:44', '2025-06-24 01:03:44', '2025-06-24 01:03:44'),
(7, 2, 32, '2025-06-23 23:17:04', '2025-06-23 23:17:04', '2025-06-23 23:17:04'),
(8, 6, 27, '2025-06-23 15:42:32', '2025-06-23 23:42:32', NULL),
(9, 2, 33, '2025-06-23 17:04:05', '2025-06-24 01:04:05', NULL),
(10, 6, 42, '2025-07-03 03:26:11', '2025-07-03 11:26:11', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `archived_items`
--
ALTER TABLE `archived_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blocked_messages`
--
ALTER TABLE `blocked_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_name_unique` (`name`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `contact_admin`
--
ALTER TABLE `contact_admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `denied_request`
--
ALTER TABLE `denied_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `items_category_id_foreign` (`category_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `my_permission`
--
ALTER TABLE `my_permission`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pending_requests`
--
ALTER TABLE `pending_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pending_requests_user_id_index` (`user_id`),
  ADD KEY `pending_requests_category_id_index` (`category_id`);

--
-- Indexes for table `pinned_chats`
--
ALTER TABLE `pinned_chats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `removed_pinned_messages`
--
ALTER TABLE `removed_pinned_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `resolve_cases`
--
ALTER TABLE `resolve_cases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `resolve_cases_user_id_index` (`user_id`),
  ADD KEY `resolve_cases_category_id_index` (`category_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `last_activity` (`last_activity`);

--
-- Indexes for table `total_found`
--
ALTER TABLE `total_found`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `total_lost`
--
ALTER TABLE `total_lost`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trash`
--
ALTER TABLE `trash`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trash_users`
--
ALTER TABLE `trash_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trash_users_email_index` (`email`);

--
-- Indexes for table `trash_users_info`
--
ALTER TABLE `trash_users_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trash_users_info_user_id_foreign` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `users_info`
--
ALTER TABLE `users_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `view_later`
--
ALTER TABLE `view_later`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_view_later_user` (`user_id`),
  ADD KEY `fk_view_later_item` (`item_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `archived_items`
--
ALTER TABLE `archived_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blocked_messages`
--
ALTER TABLE `blocked_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT for table `contact_admin`
--
ALTER TABLE `contact_admin`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `denied_request`
--
ALTER TABLE `denied_request`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `my_permission`
--
ALTER TABLE `my_permission`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `pending_requests`
--
ALTER TABLE `pending_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `pinned_chats`
--
ALTER TABLE `pinned_chats`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `removed_pinned_messages`
--
ALTER TABLE `removed_pinned_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `resolve_cases`
--
ALTER TABLE `resolve_cases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `total_found`
--
ALTER TABLE `total_found`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `total_lost`
--
ALTER TABLE `total_lost`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `trash`
--
ALTER TABLE `trash`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `trash_users`
--
ALTER TABLE `trash_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `trash_users_info`
--
ALTER TABLE `trash_users_info`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `users_info`
--
ALTER TABLE `users_info`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `view_later`
--
ALTER TABLE `view_later`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `blocked_messages`
--
ALTER TABLE `blocked_messages`
  ADD CONSTRAINT `blocked_messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `contacts_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `contacts_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `removed_pinned_messages`
--
ALTER TABLE `removed_pinned_messages`
  ADD CONSTRAINT `removed_pinned_messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `trash_users_info`
--
ALTER TABLE `trash_users_info`
  ADD CONSTRAINT `trash_users_info_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `trash_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `view_later`
--
ALTER TABLE `view_later`
  ADD CONSTRAINT `fk_view_later_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_view_later_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
