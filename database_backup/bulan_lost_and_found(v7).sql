-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 07, 2025 at 01:21 AM
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
(3, 2, 'sample', 'This is a sample announcement', '2025-05-27 23:37:45', '2025-10-20 20:48:36', '2025-10-20 20:48:36'),
(4, 2, 'sample', 'This is a sample announcement', '2025-05-27 23:37:46', '2025-10-20 20:48:29', '2025-10-20 20:48:29'),
(5, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:50', '2025-10-20 20:48:19', '2025-10-20 20:48:19'),
(6, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:52', '2025-10-26 18:22:37', '2025-10-26 18:22:37'),
(7, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:54', '2025-10-13 21:16:24', '2025-10-13 21:16:24'),
(8, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:55', '2025-10-13 21:16:17', '2025-10-13 21:16:17'),
(10, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:56', '2025-10-20 20:47:35', '2025-10-20 20:47:35'),
(11, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:56', '2025-10-20 20:48:11', '2025-10-20 20:48:11'),
(14, 2, 'asd', 'asdasdasd', '2025-05-27 23:37:57', '2025-10-20 20:47:28', '2025-10-20 20:47:28'),
(18, 2, 'qwe', 'qweqweqw', '2025-05-28 06:22:21', NULL, '2025-10-26 18:23:23'),
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
(5, 2, 7, '2025-07-01 00:07:40', '2025-07-01 00:07:40'),
(7, 2, 16, '2025-10-23 19:24:21', '2025-10-23 19:24:21'),
(8, 6, 9, '2025-10-23 19:24:49', '2025-10-23 19:24:49'),
(9, 26, 27, '2025-10-23 19:25:18', '2025-10-23 19:25:18'),
(10, 26, 7, '2025-10-23 19:26:11', '2025-10-23 19:26:11'),
(11, 6, 7, '2025-10-24 17:32:51', '2025-10-24 17:32:51');

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
('0a57cb53ba59c46fc4b692527a38a87c78d84028', 'i:3;', 1761274628),
('0a57cb53ba59c46fc4b692527a38a87c78d84028:timer', 'i:1761274628;', 1761274628),
('22d200f8670dbdb3e253a90eee5098477c95c23d', 'i:1;', 1761277826),
('22d200f8670dbdb3e253a90eee5098477c95c23d:timer', 'i:1761277826;', 1761277826),
('7719a1c782a1ba91c031a682a0a2f8658209adbf', 'i:1;', 1761275119),
('7719a1c782a1ba91c031a682a0a2f8658209adbf:timer', 'i:1761275119;', 1761275119),
('887309d048beef83ad3eabf2a79a64a389ab1c9f', 'i:1;', 1761018616),
('887309d048beef83ad3eabf2a79a64a389ab1c9f:timer', 'i:1761018616;', 1761018616),
('adcgolpeo@sorsu.edu.ph|192.168.1.7', 'i:1;', 1761279350),
('adcgolpeo@sorsu.edu.ph|192.168.1.7:timer', 'i:1761279350;', 1761279350),
('b6692ea5df920cad691c20319a6fffd7a4a766b8', 'i:2;', 1761281284),
('b6692ea5df920cad691c20319a6fffd7a4a766b8:timer', 'i:1761281284;', 1761281284),
('bc33ea4e26e5e1af1408321416956113a4658763', 'i:1;', 1761020010),
('bc33ea4e26e5e1af1408321416956113a4658763:timer', 'i:1761020010;', 1761020010),
('capstoneproj1to2@gmail.com|192.168.1.5', 'i:1;', 1761692553),
('capstoneproj1to2@gmail.com|192.168.1.5:timer', 'i:1761692553;', 1761692553),
('cb4e5208b4cd87268b208e49452ed6e89a68e0b8', 'i:1;', 1761280347),
('cb4e5208b4cd87268b208e49452ed6e89a68e0b8:timer', 'i:1761280347;', 1761280347),
('da4b9237bacccdf19c0760cab7aec4a8359010b0', 'i:2;', 1761281177),
('da4b9237bacccdf19c0760cab7aec4a8359010b0:timer', 'i:1761281177;', 1761281177),
('f1f836cb4ea6efb2a0b1b99f41ad8b103eff4b59', 'i:1;', 1761282960),
('f1f836cb4ea6efb2a0b1b99f41ad8b103eff4b59:timer', 'i:1761282960;', 1761282960),
('fc074d501302eb2b93e2554793fcaf50b3bf7291', 'i:2;', 1762070313),
('fc074d501302eb2b93e2554793fcaf50b3bf7291:timer', 'i:1762070313;', 1762070313),
('login|192.168.1.5|capstoneproj1to2@gmail.com', 'i:1;', 1761692553),
('login|192.168.1.5|capstoneproj1to2@gmail.com:timer', 'i:1761692553;', 1761692553),
('login|192.168.1.7|adcgolpeo@sorsu.edu.ph', 'i:1;', 1761279350),
('login|192.168.1.7|adcgolpeo@sorsu.edu.ph:timer', 'i:1761279350;', 1761279350);

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
(43, 2, 33, 'Oh! mao yun ang nawara sa aquino.', '2025-09-12 14:34:22', '2025-09-12 14:34:22'),
(44, 2, 50, 'asdasdasda', '2025-10-02 17:25:50', '2025-10-02 17:25:50'),
(57, 2, 74, 'Cute', '2025-10-20 20:10:38', '2025-10-20 20:10:38'),
(59, 2, 77, 'asd', '2025-10-27 13:39:41', '2025-10-27 13:39:41');

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
  `updated_at` timestamp NULL DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `sender_id`, `receiver_id`, `message`, `created_at`, `updated_at`, `read_at`) VALUES
(1, 2, 1, 'eyJpdiI6IldiR2Zjd0tFSjhWM3IyTXNLUGwrTVE9PSIsInZhbHVlIjoiaXd3RXlucnBRSThjUi9MQjY5Kzh5NTVQYjYzRXpkQnkybXdBVlBGVHdzVT0iLCJtYWMiOiI1MzY4ZjRlYTAxMDA0MmNhZDA1YmJmY2NlZmQ4ZWFlNDZlZTZhY2NjMDNlOTgzMGIzYmFmMzMzNzdlZDM0M2EyIiwidGFnIjoiIn0=', '2025-10-27 23:17:38', '2025-10-27 23:17:38', NULL),
(3, 2, 1, 'eyJpdiI6InNqd2dNTEJGcEw4UXZCQ29Dc2VNTHc9PSIsInZhbHVlIjoiLzVzU084WnphbGFXMFp0d3FYYi9Zdz09IiwibWFjIjoiZjJlMmI2YTEyZDFhYzQ2M2ZlM2QwYzFmOGJhNzMzOTgyNTI5ZWEzZTAzYjcwMWE2YTAyYTg1ZmE3NDRhN2ZiOSIsInRhZyI6IiJ9', '2025-10-28 00:05:16', '2025-10-28 00:05:16', NULL),
(5, 2, 6, 'eyJpdiI6InRWUlNtOXQxTUE2NlZpazJzRmUyUnc9PSIsInZhbHVlIjoiMmE1MkNOQ2g1YXVXTDhXalAzYzI4UU1VNVNTUldTWVJIdUljVXgzNVBURml5MUowc2dFU2ZLQ3VMamJ0VkV2TnM1L0RhUFJqNFRSa1I2d3d1TUs2ZEkyd3JLemI5UFVFY0tyUXJ1YzZuQWxvblFwYTdyaWROaDZocTdRclAzOWRYYTlFRUc0dUpJUDg0cm9pdTJlQjNKR1JSTXdsc1N5TGJvWmpRN0JsNXdUZk1yNC8xUHBXaE1qWWJ0SFE3VUpwdXoyN3Zjd0EzdjBQaTRaY0ZvNG9DQ3kvRWMyTGEzUFBkUUp5SUsrNUNIUjM5OEtQTEtCSW5ZT3g4Z0NjVmt3Q2hUc1dPTW9qdDFPQXJ2N0Fhb1dybEtkaEVHblYxR0tucExBbElVWXFuVzQ9IiwibWFjIjoiOWQ5MTA5ZGY1ODFiMzI1ODI0NTBlYmJmZGYxOTZlM2RjOGY0OTIyZjhlZDBjNzFjMGVhODg4MGM5ZThhM2U0NCIsInRhZyI6IiJ9', '2025-10-28 15:43:49', '2025-11-02 16:10:47', '2025-11-02 16:10:47'),
(6, 2, 6, 'eyJpdiI6Ilp4Q2Npa3UzTDNxbjdBU3NpWmpvTGc9PSIsInZhbHVlIjoiSmFlSUZ6b3JISEF2a3pIdm1rcStVZz09IiwibWFjIjoiMjEwMDg5Mzg5NzI0ZmM4NDFmOTZiYjczMTQ0ZDU1NjlmZDc4YWEwMGFlMGQ4ZDNlNDgwMzcxNjY4NjUyYzY2ZCIsInRhZyI6IiJ9', '2025-11-05 00:06:46', '2025-11-05 00:08:54', '2025-11-05 00:08:54');

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
(6, '19', '6', 'Uncategorize item', '2025-10-02 16:51:16', '2025-10-02 16:51:16'),
(7, '31', '30', 'n', '2025-10-23 20:06:10', '2025-10-23 20:06:10');

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
  `owner_phone_number` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `user_id`, `title`, `description`, `category`, `location`, `status`, `contact_info`, `image_url`, `reported_at`, `created_at`, `updated_at`, `deleted_at`, `resolved_at`, `category_id`, `owner_phone_number`, `date`) VALUES
(24, 2, 'a', 'a', 'Accessories', 'Abad Santos (Kambal)', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/A8SqHK67DWBWUYPOaD0mjvefwMkhjgfHPgu7ImYH.jpg', '2025-04-11 17:22:43', '2025-04-12 00:22:43', '2025-04-20 01:26:26', NULL, NULL, NULL, NULL, NULL),
(25, 2, 'x', 'x', 'Human', 'A. Bonifacio (Tinurilan)', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/LP1IzIMULcENVXZ18NXokTe0WlXC2CBNgCbNeCkL.jpg', '2025-04-11 17:31:59', '2025-04-12 00:31:59', '2025-04-24 07:25:17', NULL, NULL, NULL, NULL, NULL),
(31, 6, 'sa user', 'sa user na post kinam', 'Human', 'Aguinaldo (Lipata Dako)', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/41LFPFShRF92IM8Tz3CHXrQSsAaqWzvh9MYsqjsb.jpg', '2025-04-14 02:26:39', '2025-04-14 09:26:39', '2025-05-26 12:08:12', NULL, NULL, NULL, NULL, NULL),
(32, 6, 'Grey bag', 'Grey bag po, last seen in Bonga na iwan po sa tricycle', 'Accessories', 'Bonga', 'Lost', NULL, '/storage/images/Opg66JgrEJ7BfbGOkhsebDvPhn8SS67o8n0IQKdw.png', '2025-04-14 14:28:40', '2025-04-14 21:28:40', '2025-10-23 19:08:59', NULL, NULL, NULL, '09811986231', NULL),
(33, 2, 'Bike', 'Black mountain bike, adi po cya dd niyan sa baryo hall eh return ko tabi mamaya sa pulis', 'Sports Equipment', 'Aquino (Imelda)', 'Found', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-04-19 22:38:53', '2025-04-20 05:38:53', '2025-09-12 22:41:24', NULL, NULL, NULL, NULL, NULL),
(35, 6, 'cat', 'yadi po cya niyan sa baryo hall sa butag, may nag return kanina', 'Pets', 'Butag', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/6kGZwZKxQs8WcQbBOuNQYTDen0AebtEBfaNypfZg.jpg', '2025-05-01 15:08:13', '2025-05-01 22:08:13', '2025-05-26 12:24:30', NULL, '2025-05-26 12:24:30', NULL, NULL, NULL),
(36, 2, 'Mountain Bike', 'Lost black mountain bike in Aquino (Imelda). Please contact if found.', 'Sports Equipment', 'Aquino (Imelda)', 'Lost', NULL, '/storage/images/y3YdvGUr26bHTFhXQKB1cFrp3upIJIWcC2utap8M.png', '2025-04-19 04:00:00', '2025-04-19 04:00:00', '2025-10-23 19:12:25', NULL, NULL, NULL, NULL, NULL),
(37, 2, NULL, NULL, 'Accessories', NULL, 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/37der6UmD8lgUy2BkV1NODORou9HUbfHswILe85o.jpg', '2025-06-20 06:28:03', '2025-06-19 22:28:03', '2025-06-30 03:14:23', NULL, '2025-06-30 03:14:23', NULL, NULL, NULL),
(38, 2, 'Key', 'Key of cabinet', 'Keys', 'Bonga', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/cjmMZ846gubmVz4IPPDCmMhK3eZYly3OM1nivCup.jpg', '2025-06-23 08:06:45', '2025-06-23 00:06:45', '2025-06-23 15:10:51', NULL, '2025-06-23 15:10:51', NULL, '09345237624', NULL),
(42, 6, 'Laptop', 'Grey Laptop, last seen on calomagon toda', 'Electronics', 'Calomagon', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/IxCiPDyEOvnmFeFZLMgwijrn7JHmSR1b9BsrUnr2.jpg', '2025-06-23 23:14:30', '2025-06-23 15:14:30', '2025-06-23 15:14:30', NULL, NULL, NULL, NULL, NULL),
(45, 6, 'Key', 'I think it is Rusi motor key, nakita ko po d2 sa road side ng Bonga.', 'Keys', 'Bonga', 'Found', NULL, 'http://127.0.0.1:8000/storage/images/s1P9tQqCFh5eUrscSV7ASyvoFdc5GUHLpejrBNBE.jpg', '2025-09-11 08:47:07', '2025-09-11 00:47:07', '2025-09-12 22:37:08', NULL, NULL, NULL, '09811986323', NULL),
(46, 6, 'Dog', 'White Dog last seen d2 sa Calomagon', '1', 'Calomagon', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/KjtQ97FbRd5z5miCYlqwMC83nzgOZV7VqHPTrlGa.jpg', '2025-09-12 02:48:05', '2025-09-11 18:48:05', '2025-09-11 19:02:17', NULL, '2025-09-11 19:02:17', NULL, '09811986323', NULL),
(47, 6, 'CellPhone', 'RealMe c51', '32', 'Gate', 'Lost', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-09-12 02:52:27', '2025-09-11 18:52:27', '2025-09-11 18:52:27', NULL, NULL, NULL, '09811986323', NULL),
(49, 6, 'Dog', 'White Dog last seen d2 sa Calomagon', '1', 'Calomagon', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/pb82UOR2j7Btr28q1wcBzdZ3srHK08nNdoi60pfO.jpg', '2025-09-12 03:03:38', '2025-09-11 19:03:38', '2025-09-11 19:12:26', NULL, '2025-09-11 19:12:26', NULL, '09811986323', NULL),
(50, 6, 'Dog', 'White Dog last seen d2 sa Calomagon', '1', 'Calomagon', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/8IoADZNBHkzid3nFNTKS4j9FA5jM0jlvx8vR9YWC.jpg', '2025-09-12 03:12:41', '2025-09-11 19:12:41', '2025-09-11 19:12:41', NULL, NULL, NULL, '09811986323', NULL),
(51, 2, 'Michael jordan nike', 'sports ware', '29', 'Aguinaldo (Lipata Dako)', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/T4zkq0eOqkyKMEnqtGWWQLTUZJ90CGvvppgxk6zu.jpg', '2025-09-30 02:29:55', '2025-09-29 18:29:55', '2025-10-09 17:47:12', NULL, '2025-10-09 17:47:12', NULL, NULL, NULL),
(53, 2, 'backie', 'Black dog.', 'Pets', 'Bonga', 'Lost', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-10-13 07:01:41', '2025-10-12 23:01:41', '2025-10-12 23:01:41', NULL, NULL, NULL, '09460162977', NULL),
(56, 2, 'Silver Citizen Eco-Drive Watch', 'Men’s stainless-steel watch, black dial, leather strap replaced with brown strap, small scratch at 1 o’clock. Engraved inside: “To J., 2019.”', 'Accessories', 'Antipolo', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/JKQvNexnJ6yvPlRRf4YOrPtmlmIJza5OVkc0Oe14.jpg', '2025-10-14 11:19:30', '2025-10-14 03:19:30', '2025-10-14 03:19:30', NULL, NULL, NULL, '09811986323', NULL),
(57, 2, 'Black Bluetooth Earbuds', 'Small charging case with “Lenovo” logo, one earbud missing rubber tip. Found near Jollibee entrance.', 'Gadgets/Accessories', 'Zone 4 (Central Business District)', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/KpzxyXBTNm0Oh5tOxBJeT5jmtQZOxAK3mIWseTZd.jpg', '2025-10-14 11:25:50', '2025-10-14 03:25:50', '2025-10-14 03:25:50', NULL, NULL, NULL, '09460162977', NULL),
(58, 2, 'a', 'a', 'Toys/Children\'s Items', 'A. Bonifacio (Tinurilan)', 'Claimed', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-10-18 04:41:27', '2025-10-17 20:41:27', '2025-10-17 20:41:39', NULL, '2025-10-17 20:41:39', NULL, NULL, NULL),
(62, 2, 'a', 'a', 'Toys/Children\'s Items', 'Abad Santos (Kambal)', 'Claimed', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-10-18 11:12:08', '2025-10-18 03:12:08', '2025-10-18 17:39:37', NULL, '2025-10-18 17:39:37', NULL, NULL, NULL),
(74, 26, 'Cat', 'White with black pattern cat, with yellow collar', 'Pets', 'Aquino (Imelda)', 'Found', NULL, '/storage/images/570XCU8aY1MF9bcD7in7xc69e5GHKIQqvOdeSpx7.jpg', '2025-10-21 04:10:16', '2025-10-20 20:10:16', '2025-10-22 22:50:46', NULL, NULL, NULL, NULL, NULL),
(75, 28, 'Tumbler', 'Blue Aquaflask with stickers', 'Others', 'Zone 2 (Sabang)', 'Found', NULL, 'http://192.168.1.20:8000/storage/images/KOuDxjm5fgqu8QSUaCR9dqSWmmWZ8uhCzzRG6s9r.jpg', '2025-10-24 03:07:03', '2025-10-23 19:07:03', '2025-10-23 19:07:03', NULL, NULL, NULL, NULL, NULL),
(76, 27, 'Wallet', 'White wallet with phone keychain holder', 'Wallets/Purses', 'Obrero', 'Lost', NULL, '/storage/images/SWDct1CZTGX4sDh4ajQ8mAwB0ZPx2UskvN4iNjAO.jpg', '2025-10-24 03:13:18', '2025-10-23 19:13:18', '2025-10-28 14:38:16', NULL, NULL, NULL, '09235565845', NULL),
(77, 28, 'Wristwatch', 'Silver Wristwatch (Casio)', 'Accessories', 'Zone 4 (Central Business District)', 'Lost', NULL, '/storage/images/YNxIdh49uaPj4w7mA0w8QoscS6EqaX3uMuGz3D8W.jpg', '2025-10-24 03:56:35', '2025-10-23 19:56:35', '2025-10-28 14:37:47', NULL, NULL, NULL, '09389941634', NULL),
(86, 2, 'Black leather wallet', 'Black leather wallet containing IDs, ATM card, and some cash. Last seen near the barangay basketball court around 5 PM. If found, please contact me. Reward will be given.', 'Documents', 'Bonga', 'Lost', NULL, 'http://192.168.1.5:8000/storage/images/uhWBSDII9JVUG7Y6rbU4uSnS734wMHwSfiT5XYW9.jpg', '2025-10-28 22:34:48', '2025-10-28 14:34:48', '2025-10-28 14:34:48', NULL, NULL, NULL, '09811986323', NULL),
(87, 36, 'Missing Smartphone', 'Silver iPhone 13. Lost somewhere near the barangay hall parking lot around 5 PM.', 'Electronics', 'J. Gerona (Biton)', 'Lost', NULL, 'http://192.168.1.7:8000/storage/images/wvvVc8P6uo3c6jJUDxXps5UU3f2kC86ZlXBEZLOn.jpg', '2025-11-05 07:44:13', '2025-11-04 23:44:13', '2025-11-04 23:44:13', NULL, NULL, NULL, '09460162977', NULL);

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
(114, 'default', '{\"uuid\":\"c455f235-3e26-4b14-bfba-333f8ad5941b\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":4:{s:9:\\\"sender_id\\\";i:2;s:11:\\\"receiver_id\\\";i:6;s:7:\\\"message\\\";s:568:\\\"eyJpdiI6InRWUlNtOXQxTUE2NlZpazJzRmUyUnc9PSIsInZhbHVlIjoiMmE1MkNOQ2g1YXVXTDhXalAzYzI4UU1VNVNTUldTWVJIdUljVXgzNVBURml5MUowc2dFU2ZLQ3VMamJ0VkV2TnM1L0RhUFJqNFRSa1I2d3d1TUs2ZEkyd3JLemI5UFVFY0tyUXJ1YzZuQWxvblFwYTdyaWROaDZocTdRclAzOWRYYTlFRUc0dUpJUDg0cm9pdTJlQjNKR1JSTXdsc1N5TGJvWmpRN0JsNXdUZk1yNC8xUHBXaE1qWWJ0SFE3VUpwdXoyN3Zjd0EzdjBQaTRaY0ZvNG9DQ3kvRWMyTGEzUFBkUUp5SUsrNUNIUjM5OEtQTEtCSW5ZT3g4Z0NjVmt3Q2hUc1dPTW9qdDFPQXJ2N0Fhb1dybEtkaEVHblYxR0tucExBbElVWXFuVzQ9IiwibWFjIjoiOWQ5MTA5ZGY1ODFiMzI1ODI0NTBlYmJmZGYxOTZlM2RjOGY0OTIyZjhlZDBjNzFjMGVhODg4MGM5ZThhM2U0NCIsInRhZyI6IiJ9\\\";s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2025-10-28 23:43:49.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1761695033, 1761695033),
(115, 'default', '{\"uuid\":\"07b39baf-dde0-4b5c-8b5f-fb1e73568973\",\"displayName\":\"App\\\\Events\\\\NewMessageSent\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:25:\\\"App\\\\Events\\\\NewMessageSent\\\":4:{s:9:\\\"sender_id\\\";i:2;s:11:\\\"receiver_id\\\";i:6;s:7:\\\"message\\\";s:200:\\\"eyJpdiI6Ilp4Q2Npa3UzTDNxbjdBU3NpWmpvTGc9PSIsInZhbHVlIjoiSmFlSUZ6b3JISEF2a3pIdm1rcStVZz09IiwibWFjIjoiMjEwMDg5Mzg5NzI0ZmM4NDFmOTZiYjczMTQ0ZDU1NjlmZDc4YWEwMGFlMGQ4ZDNlNDgwMzcxNjY4NjUyYzY2ZCIsInRhZyI6IiJ9\\\";s:10:\\\"created_at\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2025-11-05 08:06:46.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\"}}', 0, NULL, 1762330009, 1762330009);

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
(35, '2025_10_15_225639_add_date_lost_in_total_lost_table', 33),
(36, '2025_10_18_043632_add_date_in_items_table', 34),
(37, '2025_10_18_233611_create_target_resolved_cases_table', 35),
(38, '2025_10_19_150628_add_location_in_total_lost_table', 36),
(39, '2025_10_19_150613_add_location_in_total_found_table', 37);

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
(1, 2, 0, 1, '2025-09-04 16:40:14', '2025-09-19 15:30:43'),
(2, 26, 0, 0, '2025-10-23 19:08:30', '2025-10-23 19:08:39');

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
(80, 'Face to Face Verification', 36, 42, 'Hi Jobel V. Golde,  your item (Missing Smartphone) needs to be verified face to face. We encourage you to visit the PNP for additional verification of the item you wish to post.', 0, NULL, '2025-11-04 23:34:34', '2025-11-04 23:34:34'),
(81, 'Face to Face Verification', 36, 42, 'Hi Jobel V. Golde,  your item (Missing Smartphone) needs to be verified face to face. We encourage you to visit the PNP for additional verification of the item you wish to post.', 0, NULL, '2025-11-04 23:44:05', '2025-11-04 23:44:05'),
(82, 'Request Approved', 36, 87, 'Your item request (Missing Smartphone) has been approved and is now live on the platform.', 0, NULL, '2025-11-04 23:44:13', '2025-11-04 23:44:13');

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

--
-- Dumping data for table `pending_requests`
--

INSERT INTO `pending_requests` (`id`, `user_id`, `title`, `description`, `category`, `location`, `status`, `contact_info`, `image_url`, `reported_at`, `created_at`, `updated_at`, `category_id`, `owner_phone_number`, `pending_status`) VALUES
(22, 21, 'asd', 'asdas', 'Gadgets/Accessories', 'Aguinaldo (Lipata Dako)', 'Lost', NULL, 'http://127.0.0.1:8000/images/noImage.jpg', '2025-10-16 05:55:19', '2025-10-15 21:55:19', '2025-10-15 21:55:19', NULL, '09811986323', 'pending'),
(25, 6, 'Wallet', 'Hskdjska', 'Wallets/Purses', 'Managa-naga', 'Lost', NULL, 'http://10.92.89.232:8000/images/noImage.jpg', '2025-10-21 04:09:18', '2025-10-20 20:09:18', '2025-10-20 20:09:18', NULL, NULL, 'pending'),
(36, 6, 'asd', 'asd', 'Tools/Equipment', 'Abad Santos (Kambal)', 'Lost', NULL, 'http://192.168.1.5:8000/images/noImage.jpg', '2025-10-25 01:13:03', '2025-10-24 17:13:03', '2025-10-24 17:13:03', NULL, NULL, 'pending'),
(38, 6, 'asd', 'asd', 'Electronics', 'Abad Santos (Kambal)', 'Lost', NULL, 'http://192.168.1.5:8000/images/noImage.jpg', '2025-10-25 01:18:38', '2025-10-24 17:18:38', '2025-10-24 17:18:38', NULL, NULL, 'pending'),
(39, 26, 'sdeaf', 'rftg', 'Electronics', 'A. Bonifacio (Tinurilan)', 'Found', NULL, 'http://10.92.89.232:8000/images/noImage.jpg', '2025-10-27 02:40:01', '2025-10-26 18:40:01', '2025-10-26 18:40:01', NULL, '09123456789', 'pending'),
(40, 6, 'Lost wallet in Purok 2', 'Black leather wallet containing IDs, ATM card, and some cash. Last seen near the barangay basketball court around 5 PM. If found, please contact me. Reward will be given.', 'Documents', 'Bonga', 'Lost', NULL, 'http://192.168.1.5:8000/storage/images/6UOcUrZqvTrttIXG3DYa3brRrPElW8dMWrFDCTpV.jpg', '2025-10-28 11:45:47', '2025-10-28 03:45:47', '2025-10-28 03:45:47', NULL, '09811986233', 'pending'),
(41, 34, 'Motorcycle Helmet', 'Here is a concise summary of the found motorcycle helmet\'s description:\r\n\r\nThe mud-splattered, orange and black motorcycle helmet was found half-buried in a dense forest. Its faded condition suggests it has been there a while, and a small fern is growing from the top, symbolizing nature\'s slow process of reclaiming it.', 'Sports Equipment', 'Dolos', 'Found', NULL, 'http://192.168.1.5:8000/storage/images/8maFmkcj8JbmRjrjdpot93sr6K0WdTweEkTpVFzJ.png', '2025-10-28 23:22:09', '2025-10-28 15:22:09', '2025-10-28 15:22:09', NULL, '09456453455', 'pending');

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
('8GaO0pcx9pZGqUuIIWpshxg0W82x6qi0oeKg8okX', NULL, '192.168.1.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTDlKcUdybzZTc2VUWmlNNTg5UEF1UU5aeXdXWThNbDE4Yml3VlJmbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly8xOTIuMTY4LjEuNDo4MDAwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1762474853),
('BdKTmxghSakmUQN2xashSzK9IEo9OZperZdAm3Ui', NULL, '192.168.1.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNGdzM1lUdFhrdlV1UzJHUUZianBpZzRTZkYxT3FwNFNRQUp4N2FJZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly8xOTIuMTY4LjEuNDo4MDAwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1762474854),
('hz5ys3aVA41uCbMqbkM9E19xx1kdWjDmbKWeMOaB', 2, '10.113.38.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoicFA4WGQ2RDNoY2ZsTkRzcnkySGVubDJ2RW1aSUJ5VzNwb0lnTkpBeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xMC4xMTMuMzguMjMyOjgwMDAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YTowOnt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9', 1762330407),
('LRlXUDHFNNNlBvIf0yKZx9TdmzcoS0ccgirtnfq9', 6, '10.113.38.232', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYVY2cWd5VnlGYm5kNG94OThrU3RVTEdtTlpwZHFTNTI4cWg4V3htMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xMC4xMTMuMzguMjMyOjgwMDAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTo2O30=', 1762330296);

-- --------------------------------------------------------

--
-- Table structure for table `target_resolved_cases`
--

CREATE TABLE `target_resolved_cases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `target_value` int(11) NOT NULL DEFAULT 100,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `target_resolved_cases`
--

INSERT INTO `target_resolved_cases` (`id`, `target_value`, `created_at`, `updated_at`) VALUES
(1, 100, '2025-10-19 00:00:10', '2025-10-28 20:07:44');

-- --------------------------------------------------------

--
-- Table structure for table `total_found`
--

CREATE TABLE `total_found` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `total` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `date_found` date DEFAULT NULL,
  `location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `total_found`
--

INSERT INTO `total_found` (`id`, `total`, `created_at`, `updated_at`, `date_found`, `location`) VALUES
(1, 1, '2024-04-01 02:00:00', NULL, '2024-04-01', 'Bonga'),
(2, 1, '2024-04-15 06:30:00', NULL, '2024-04-15', 'Butag'),
(3, 1, '2024-04-30 02:10:00', NULL, '2024-04-30', 'Bical'),
(4, 1, '2024-05-02 01:30:00', NULL, '2024-05-02', 'Dolos'),
(5, 1, '2024-05-16 04:45:00', NULL, '2024-05-16', 'Bonga'),
(6, 1, '2024-05-28 07:20:00', NULL, '2024-05-28', 'Bonga'),
(7, 1, '2025-04-03 00:30:00', NULL, '2025-04-03', 'Calpi'),
(8, 1, '2025-04-14 05:15:00', NULL, '2025-04-14', 'Jamorawon'),
(9, 1, '2025-04-20 07:45:00', NULL, '2025-04-20', 'Lajong'),
(10, 1, '2025-04-26 03:20:00', NULL, '2025-04-26', 'Marinab');

-- --------------------------------------------------------

--
-- Table structure for table `total_lost`
--

CREATE TABLE `total_lost` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `total` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `date_lost` date DEFAULT NULL,
  `location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `total_lost`
--

INSERT INTO `total_lost` (`id`, `total`, `created_at`, `updated_at`, `date_lost`, `location`) VALUES
(1, 1, '2024-04-01 02:00:00', NULL, '2024-04-01', 'Marinab'),
(2, 1, '2024-04-15 06:30:00', NULL, '2024-04-15', 'Bonga'),
(3, 1, '2024-04-30 01:15:00', NULL, '2024-04-30', 'Bonga'),
(6, 1, '2024-05-01 00:00:00', NULL, '2024-05-01', ''),
(7, 1, '2024-05-05 03:30:00', NULL, '2024-05-05', ''),
(8, 1, '2024-05-10 06:45:00', NULL, '2024-05-10', ''),
(9, 1, '2024-05-15 01:15:00', NULL, '2024-05-15', ''),
(10, 1, '2024-05-20 08:20:00', NULL, '2024-05-20', ''),
(11, 1, '2024-05-25 05:10:00', NULL, '2024-05-25', ''),
(12, 1, '2024-05-31 02:05:00', NULL, '2024-05-31', ''),
(13, 1, '2025-04-05 01:15:00', NULL, '2025-04-05', ''),
(14, 1, '2025-04-12 03:45:00', NULL, '2025-04-12', ''),
(15, 1, '2025-04-18 06:20:00', NULL, '2025-04-18', ''),
(16, 1, '2025-04-22 08:30:00', NULL, '2025-04-22', ''),
(17, 1, '2025-04-29 02:10:00', NULL, '2025-04-29', ''),
(18, 1, '2025-10-17 20:41:39', '2025-10-17 20:41:39', '2025-10-18', ''),
(19, 1, '2025-10-18 03:06:24', '2025-10-18 03:06:24', '2025-10-18', ''),
(20, 1, '2025-10-18 03:12:08', '2025-10-18 03:12:08', '2025-10-18', ''),
(21, 1, '2025-10-19 05:25:39', '2025-10-19 05:25:39', '2025-10-19', ''),
(22, 1, '2025-10-19 22:38:59', '2025-10-19 22:38:59', '2025-10-20', 'Bonga'),
(23, 1, '2025-10-20 04:46:44', '2025-10-20 04:46:44', '2025-10-20', 'Abad Santos (Kambal)'),
(24, 1, '2025-10-23 19:13:18', '2025-10-23 19:13:18', '2025-10-24', 'Obrero'),
(25, 1, '2025-10-23 19:56:35', '2025-10-23 19:56:35', '2025-10-24', 'Zone 4 (Central Business District)'),
(26, 1, '2025-10-23 20:11:58', '2025-10-23 20:11:58', '2025-10-24', 'Zone 1 (Ilawod)'),
(27, 1, '2025-10-23 20:32:55', '2025-10-23 20:32:55', '2025-10-24', 'Antipolo'),
(28, 1, '2025-10-23 20:48:45', '2025-10-23 20:48:45', '2025-10-24', 'Abad Santos (Kambal)'),
(29, 1, '2025-10-23 21:16:29', '2025-10-23 21:16:29', '2025-10-24', 'Abad Santos (Kambal)'),
(30, 1, '2025-10-24 16:39:27', '2025-10-24 16:39:27', '2025-10-25', 'Abad Santos (Kambal)'),
(31, 1, '2025-10-24 17:09:25', '2025-10-24 17:09:25', '2025-10-25', 'A. Bonifacio (Tinurilan)'),
(32, 1, '2025-10-27 15:31:59', '2025-10-27 15:31:59', '2025-10-27', 'Abad Santos (Kambal)'),
(33, 1, '2025-10-27 15:36:33', '2025-10-27 15:36:33', '2025-10-27', 'Aguinaldo (Lipata Dako)'),
(34, 1, '2025-10-28 14:34:48', '2025-10-28 14:34:48', '2025-10-21', 'Bonga'),
(35, 1, '2025-11-04 23:44:13', '2025-11-04 23:44:13', '2025-11-05', 'J. Gerona (Biton)');

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
(2, 'Chief PNP', 'jobelgolde12@gmail.com', '2025-02-15 17:30:39', '$2y$12$eFEzZ8j6sTzlCgzFEDeuCueIAVMZxJFQYcVf9U1bl0FfXxLfdsA/S', 'admin', NULL, NULL, '2025-02-16 01:30:39', '2025-10-19 13:27:55'),
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
(20, 'Jobel Golde', 'jobelgolde43@gmail.com', '2025-07-01 15:40:39', '$2y$12$AhjoOOd5w78RPa6QZ/zSuORbrDZ997gqt8A9iEJGukC0onhVPoDLq', 'user', NULL, 'ohCCFyoE0jao9OgkytsnfBgRlxU8DlISnp9qoES0J7AYoYNJLaGAEjve7Hj3', '2025-07-01 15:39:24', '2025-10-19 05:46:35'),
(21, 'Arabella', 'jobelgolde44@gmail.com', '2025-07-01 15:51:29', '$2y$12$kvoV/WenBmt9BN2MwUIYEO/S8gNmJZAiZVq1sChkUeIlt2POdASdq', 'user', NULL, 'WzusCpaM0P8mL1c0P5dKkgP4j7r4bVApIIIxsGPsa4FExma4b8Bn75Jo2GRx', '2025-07-01 15:49:31', '2025-10-15 21:44:04'),
(22, 'N Prado', 'nprado@sorsu.edu.ph', NULL, '$2y$12$AStVXSAAKQQPdtF24I/yw.ZZKl6ZhM0mJipVYi5nZf1RFUyfSdgzC', 'user', NULL, NULL, '2025-10-06 18:24:25', '2025-10-06 18:24:25'),
(23, 'Christine bibat', 'ruitrg@gmai.com', NULL, '$2y$12$70QdszyXOnKx6Dn7Le6xYuvKc/YWJ0QYycbEENHQG2xZoHO7..C6y', 'user', NULL, NULL, '2025-10-12 22:47:06', '2025-10-12 22:47:06'),
(24, 'Maryjane', 'goldejhermaine1@gmail.com', '2025-10-19 05:08:43', '$2y$12$zqLLWs1lujvuX3I.bFnSOuaxgMoIUbhGBSvuevV49uTpnpEKmmQpW', 'user', NULL, NULL, '2025-10-19 05:03:02', '2025-10-19 05:08:43'),
(25, 'Arabella', 'hahahne@gmail.com', NULL, '$2y$12$Z6NjzP/DLReDUeLqkJe32eD8fjf/O8DEUwhp0cPjGFA5iS4S3Go7W', 'user', NULL, NULL, '2025-10-20 19:17:41', '2025-10-20 19:17:41'),
(26, 'Arabella', 'arabellagolpeo65@gmail.com', '2025-10-20 19:49:16', '$2y$12$tpb7G51BYMep.Gtlfdf0ju2PyaD8bbRDkAWtKOSJ2AvChXH6Elitu', 'user', NULL, NULL, '2025-10-20 19:19:23', '2025-10-20 19:49:16'),
(27, 'Christine', 'christinejoymoro@gmail.com', '2025-10-20 20:12:30', '$2y$12$sSk0/gXx8Xy2mbX4Se1CAOUR.4dl7NBhCtImu3r4R4GMt84sS5NQ.', 'user', NULL, NULL, '2025-10-20 20:11:18', '2025-10-20 20:12:30'),
(28, 'Kristina', 'kristinalumabad0613@gmail.com', '2025-10-23 18:56:39', '$2y$12$crRIKlfeP2afkFKuFxjnv.rmM8.fankgdOGmssH/ZmSSzbRo1yDlW', 'user', NULL, '664rYB8eYMqO9oWbM0eY5idNAJMmsEcTq2AjrmAIKMmjGVQn2oQJ8GHpE4Vo', '2025-10-23 18:14:40', '2025-10-23 18:56:39'),
(29, 'Arabella', 'arabellagolpeo65432@gmail.com', NULL, '$2y$12$pGbCtSuNHhE/rRw.lMI4BunsxVcqbyXH4rYNogpAeQX1ycxaA5i8q', 'user', NULL, NULL, '2025-10-23 19:03:27', '2025-10-23 19:03:27'),
(30, 'Bella', 'adgolpeo@sorsu.edu.ph', '2025-10-23 19:49:26', '$2y$12$mr.V5nFyLK4CSvWFHarFGO0emEOgilr/Vrccln91pX9IPpGGtxh2a', 'user', '2025-10-23 20:12:30', NULL, '2025-10-23 19:48:05', '2025-10-23 20:12:30'),
(31, 'asd', 'asd2@gmail.com', NULL, '$2y$12$8VEv1BKpabJfMBhHSFPIB.cC6aZudBTw0Eo3BrCm9DrjG..IXd9pq', 'user', NULL, NULL, '2025-10-23 20:27:41', '2025-10-23 20:27:41'),
(32, 'jobel v. golde2', 'jobel.golde2@sorsu.edu.ph', '2025-10-23 20:31:27', '$2y$12$cuI8Aw5vZKAjrzge/PI9kO.WG0ynkQEHWFxDinhBD/BPnbu4KvZiK', 'user', '2025-10-23 20:34:24', NULL, '2025-10-23 20:30:17', '2025-10-24 04:42:54'),
(33, 'asd2', 'jobel.golde3@sorsu.edu.ph', '2025-10-23 20:47:25', '$2y$12$dIBR5vx.vKjM0BSEV1sBL.renLSkD/VR.FdzWuVaukawxf8FAqedW', 'user', '2025-10-23 20:49:17', NULL, '2025-10-23 20:43:15', '2025-10-24 05:07:31'),
(34, 'Roger', 'jobel.golde@sorsu.edu.ph', '2025-10-23 21:15:00', '$2y$12$hcpu32dULMFufHrp0f.vKOwzWtg6zByMBP65tNhd0P7D2d7wsxuQW', 'user', NULL, NULL, '2025-10-23 21:07:49', '2025-10-28 23:04:23'),
(35, 'asd asd', 'iamjobelle@gmail.com', NULL, '$2y$12$GN5mFlxGE7kKdI6LKREQ8eDFRbdQWvaR5Ugb3xKWTX9t0I4hoJa1u', 'user', NULL, NULL, '2025-10-27 00:26:55', '2025-10-27 00:26:55'),
(36, 'Jobel V. Golde', 'jobelvaldezgolde@gmail.com', '2025-11-01 23:57:57', '$2y$12$myV9ftjLN9Xw4iJCMZYA0.ePNplUoStlH23iBbNU6nXM1ZM.iSz1C', 'user', NULL, NULL, '2025-11-01 23:56:46', '2025-11-01 23:57:57');

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
(2, 2, 'images/fE9C8DgwKG0BtbPDJN5zCLdbwDms9mgZAY5fWMFN.png', 'Bonga, Bulan, Sorsogon', 'Coding is like understanding women.', '09460162977', 'https://www.facebook.com/jobelGolde', NULL, '2025-04-13 03:17:17', '2025-10-28 15:15:22'),
(3, 6, 'images/2qAPRVRbtcSFHNGBKElwr7ssSeKe54bLbgSY2wEe.jpg', NULL, NULL, NULL, NULL, NULL, '2025-04-13 03:19:42', '2025-10-19 03:25:03'),
(6, 9, 'http://127.0.0.1:8000/images/profile.jpeg', NULL, NULL, NULL, NULL, NULL, '2025-05-06 22:59:58', '2025-05-06 22:59:58'),
(7, 11, 'images/4Re8iSQKFOilljx6uAoAwn7eoxZ4bKxcoNu424DV.jpg', NULL, NULL, NULL, NULL, '2025-06-20 04:01:40', '2025-05-07 05:34:10', '2025-06-20 04:01:40'),
(9, 13, 'http://127.0.0.1:8000/images/profile.jpeg', NULL, NULL, '09460162977', NULL, NULL, '2025-06-15 19:26:51', '2025-06-15 19:26:51'),
(10, 14, 'http://127.0.0.1:8000/images/profile.jpeg', NULL, NULL, '09124003819', NULL, '2025-06-24 17:11:04', '2025-06-24 16:45:54', '2025-06-24 17:11:04'),
(11, 15, 'http://127.0.0.1:8000/images/profile.jpeg', NULL, NULL, '09124003819', NULL, NULL, '2025-06-24 17:14:51', '2025-06-24 17:14:51'),
(12, 16, 'http://127.0.0.1:8000/images/profile.jpeg', NULL, NULL, '09345636235', NULL, NULL, '2025-06-28 03:47:06', '2025-06-28 03:47:06'),
(16, 20, 'images/profile.jpeg', NULL, NULL, '09345363335', NULL, NULL, '2025-07-01 15:39:25', '2025-07-01 15:39:25'),
(17, 21, 'images/6864740bb680d.jpeg', NULL, NULL, '09345348345', NULL, NULL, '2025-07-01 15:49:31', '2025-07-01 15:49:31'),
(18, 22, '', NULL, NULL, '09123456789', NULL, NULL, '2025-10-06 18:24:25', '2025-10-06 18:24:25'),
(19, 23, '', NULL, NULL, '09460162977', NULL, NULL, '2025-10-12 22:47:06', '2025-10-12 22:47:06'),
(20, 24, 'images/4KELVjrXQjYPI2zHTf7NEa5E6hrsdAClVXhBYLYT.jpg', 'Bonga, Bulan, Sorsogon', NULL, '09124003819', NULL, NULL, '2025-10-19 05:03:02', '2025-10-19 05:15:40'),
(21, 25, '', NULL, NULL, '09636045120', NULL, NULL, '2025-10-20 19:17:41', '2025-10-20 19:17:41'),
(22, 26, 'images/uTbSI65fmrZ1BKEeEodVQ39lXOGeq4QUxuj85QeH.png', 'Oyango, Bulan, Sorsogon', 'hehe', NULL, NULL, NULL, '2025-10-20 19:19:23', '2025-10-20 20:10:57'),
(23, 27, 'images/C04GH0eMAkkSOMS6qIKadbFYC1ug92Wd3Sphl5oZ.jpg', NULL, NULL, NULL, NULL, NULL, '2025-10-20 20:11:18', '2025-10-20 20:14:42'),
(24, 28, 'images/vghqdkHzQRbtfKgwFJVn5jJ1er6m2VSH0Gr8e5rU.jpg', NULL, NULL, '09389941634', NULL, NULL, '2025-10-23 18:14:40', '2025-10-23 19:10:13'),
(25, 29, '', NULL, NULL, '09636045120', NULL, NULL, '2025-10-23 19:03:27', '2025-10-23 19:03:27'),
(26, 30, '', NULL, NULL, '09636045120', NULL, NULL, '2025-10-23 19:48:05', '2025-10-23 19:48:05'),
(27, 31, '', NULL, NULL, '09460162977', NULL, NULL, '2025-10-23 20:27:41', '2025-10-23 20:27:41'),
(28, 32, '', NULL, NULL, '09460162977', NULL, NULL, '2025-10-23 20:30:17', '2025-10-23 20:30:17'),
(29, 33, '', NULL, NULL, '09460162977', NULL, NULL, '2025-10-23 20:43:15', '2025-10-23 20:43:15'),
(30, 34, '', NULL, NULL, '09460162977', NULL, '2025-10-23 21:20:17', '2025-10-23 21:07:49', '2025-10-23 21:20:17'),
(31, 35, '', NULL, NULL, '09460162977', NULL, NULL, '2025-10-27 00:26:55', '2025-10-27 00:26:55'),
(32, 34, 'images/33rbEXl6iqleQa8ykSZmVu4GziYBBUCepof1XEJP.jpg', NULL, NULL, NULL, NULL, NULL, '2025-10-28 15:14:41', '2025-10-28 15:24:03'),
(33, 36, 'images/Hb6nCUP9JYY8i69RXKP4n5PmdRXHsD8B0dwSTnFA.jpg', 'Bonga, Bulan, Sorsogon', '\"Returning what is not ours is not just an act of honesty—it is a reflection of integrity and respect for others.\"', '09811986323', NULL, NULL, '2025-11-01 23:56:46', '2025-11-02 00:04:20');

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
(9, 2, 33, '2025-06-23 17:04:05', '2025-06-24 01:04:05', NULL),
(10, 6, 42, '2025-07-03 03:26:11', '2025-07-03 11:26:11', NULL),
(13, 2, 57, '2025-10-19 09:49:59', '2025-10-19 09:49:59', '2025-10-19 09:49:59'),
(14, 2, 57, '2025-10-19 09:50:10', '2025-10-19 09:50:10', '2025-10-19 09:50:10'),
(15, 2, 57, '2025-10-19 09:52:02', '2025-10-19 09:52:02', '2025-10-19 09:52:02'),
(16, 2, 57, '2025-10-19 09:52:14', '2025-10-19 09:52:14', '2025-10-19 09:52:14'),
(17, 2, 57, '2025-10-19 09:52:22', '2025-10-19 09:52:22', '2025-10-19 09:52:22'),
(18, 2, 57, '2025-10-19 09:52:40', '2025-10-19 09:52:40', '2025-10-19 09:52:40'),
(19, 2, 57, '2025-10-19 09:53:07', '2025-10-19 09:53:07', '2025-10-19 09:53:07'),
(20, 2, 57, '2025-10-19 09:56:07', '2025-10-19 09:56:07', '2025-10-19 09:56:07'),
(21, 2, 57, '2025-10-19 09:56:19', '2025-10-19 09:56:19', '2025-10-19 09:56:19'),
(22, 2, 57, '2025-10-19 09:56:28', '2025-10-19 09:56:28', '2025-10-19 09:56:28'),
(23, 2, 57, '2025-10-19 09:56:38', '2025-10-19 09:56:38', '2025-10-19 09:56:38'),
(24, 2, 57, '2025-10-19 09:56:43', '2025-10-19 09:56:43', '2025-10-19 09:56:43'),
(25, 2, 57, '2025-10-19 09:56:50', '2025-10-19 09:56:50', '2025-10-19 09:56:50'),
(26, 2, 57, '2025-10-19 09:58:42', '2025-10-19 09:58:42', '2025-10-19 09:58:42'),
(27, 6, 57, '2025-10-19 10:00:03', '2025-10-19 10:00:03', '2025-10-19 10:00:03'),
(28, 6, 57, '2025-10-19 10:05:39', '2025-10-19 10:05:39', '2025-10-19 10:05:39'),
(29, 6, 57, '2025-10-19 10:05:45', '2025-10-19 10:05:45', '2025-10-19 10:05:45'),
(30, 6, 57, '2025-10-19 10:05:53', '2025-10-19 10:05:53', '2025-10-19 10:05:53'),
(31, 6, 57, '2025-10-19 10:07:58', '2025-10-19 10:07:58', '2025-10-19 10:07:58'),
(32, 6, 56, '2025-10-19 10:06:00', '2025-10-19 10:06:00', '2025-10-19 10:06:00'),
(33, 6, 56, '2025-10-19 10:07:56', '2025-10-19 10:07:56', '2025-10-19 10:07:56'),
(34, 6, 57, '2025-10-19 02:08:03', '2025-10-19 10:08:03', NULL),
(36, 26, 74, '2025-10-20 20:16:34', '2025-10-21 04:16:34', NULL),
(37, 28, 77, '2025-10-23 20:12:01', '2025-10-24 04:12:01', NULL);

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
-- Indexes for table `target_resolved_cases`
--
ALTER TABLE `target_resolved_cases`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `contact_admin`
--
ALTER TABLE `contact_admin`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `denied_request`
--
ALTER TABLE `denied_request`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `my_permission`
--
ALTER TABLE `my_permission`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `pending_requests`
--
ALTER TABLE `pending_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

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
-- AUTO_INCREMENT for table `target_resolved_cases`
--
ALTER TABLE `target_resolved_cases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `total_found`
--
ALTER TABLE `total_found`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `total_lost`
--
ALTER TABLE `total_lost`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `users_info`
--
ALTER TABLE `users_info`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `view_later`
--
ALTER TABLE `view_later`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

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
