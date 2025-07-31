-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 26, 2025 at 07:05 AM
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
-- Database: `bulan_lost_and_found`
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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(7, 'Others', 'Miscellaneous lost and found items not listed in specific categories, such as tools or toys');

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
(6, 2, 27, 'sample comment', '2025-05-24 07:39:10', '2025-05-24 07:39:10'),
(15, 2, 27, 'akobodoy', '2025-05-24 22:03:59', '2025-05-24 22:03:59'),
(16, 2, 27, 'asd', '2025-05-24 22:08:55', '2025-05-24 22:08:55'),
(17, 2, 27, 'dsa', '2025-05-24 22:10:59', '2025-05-24 22:10:59'),
(18, 2, 27, 'aaa', '2025-05-25 01:29:23', '2025-05-25 01:29:23'),
(19, 2, 27, 'fff', '2025-05-25 01:31:15', '2025-05-25 01:31:15'),
(20, 2, 27, 'This is comment', '2025-05-25 01:32:39', '2025-05-25 01:32:39');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `owner_phone_number` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `user_id`, `title`, `description`, `category`, `location`, `status`, `contact_info`, `image_url`, `reported_at`, `created_at`, `updated_at`, `category_id`, `owner_phone_number`) VALUES
(24, 2, 'a', 'a', 'Accessories', 'Abad Santos (Kambal)', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/A8SqHK67DWBWUYPOaD0mjvefwMkhjgfHPgu7ImYH.jpg', '2025-04-11 17:22:43', '2025-04-12 00:22:43', '2025-04-20 01:26:26', NULL, NULL),
(25, 2, 'x', 'x', 'Human', 'A. Bonifacio (Tinurilan)', 'Claimed', NULL, 'http://127.0.0.1:8000/storage/images/LP1IzIMULcENVXZ18NXokTe0WlXC2CBNgCbNeCkL.jpg', '2025-04-11 17:31:59', '2025-04-12 00:31:59', '2025-04-24 07:25:17', NULL, NULL),
(27, 2, 'v', 'v', 'Documents', 'A. Bonifacio (Tinurilan)', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/UmU6GEQi6QVmUZw5bfkZGYxlvz0Jy9fFDZnuiAMi.jpg', '2025-04-11 17:36:58', '2025-04-12 00:36:58', '2025-04-12 00:36:58', NULL, NULL),
(31, 6, 'sa user', 'sa user na post kinam', 'Human', 'Aguinaldo (Lipata Dako)', 'Found', NULL, 'http://127.0.0.1:8000/storage/images/41LFPFShRF92IM8Tz3CHXrQSsAaqWzvh9MYsqjsb.jpg', '2025-04-14 02:26:39', '2025-04-14 09:26:39', '2025-04-14 09:26:39', NULL, NULL),
(32, 6, 'Grey bag', 'Grey bag po, last seen in Bonga na iwan po sa tricycle', 'Accessories', 'Bonga', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/wuI1Fmtz5LidXBNWhzoMHQGUYdtR2u2Vy2jGktY3.jpg', '2025-04-14 14:28:40', '2025-04-14 21:28:40', '2025-04-14 21:28:40', NULL, '09811986231'),
(33, 2, 'Bike', 'Black mountain bike, adi po cya dd niyan sa baryo hall eh return ko tabi mamaya sa pulis', 'Others', 'Aquino (Imelda)', 'Found', NULL, 'http://127.0.0.1:8000/storage/images/YYx9mzlCzB3wuXT3mCDiHs0JsFNTTxKlWYtA4zxk.jpg', '2025-04-19 22:38:53', '2025-04-20 05:38:53', '2025-04-20 05:38:53', NULL, NULL),
(34, 2, 'asd', NULL, 'Electronics', NULL, 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/NGmGNlpw4Av21w8JzNC3XQKH4AOjXB9Blq4xpbry.jpg', '2025-05-01 01:01:19', '2025-05-01 08:01:19', '2025-05-01 01:03:56', NULL, NULL),
(35, 6, 'cat', 'yadi po cya niyan sa baryo hall sa butag, may nag return kanina', 'Pets', 'Butag', 'Found', NULL, 'http://127.0.0.1:8000/storage/images/6kGZwZKxQs8WcQbBOuNQYTDen0AebtEBfaNypfZg.jpg', '2025-05-01 15:08:13', '2025-05-01 22:08:13', '2025-05-01 22:08:13', NULL, NULL);

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
(13, '2025_04_26_210508_create_pinned_chats_table', 12);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text DEFAULT NULL,
  `read_status` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(4, 6, 'Laptop', 'Grey Laptop, last seen on calomagon toda', 'Electronics', 'Calomagon', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/IxCiPDyEOvnmFeFZLMgwijrn7JHmSR1b9BsrUnr2.jpg', '2025-04-23 23:40:32', '2025-04-24 06:40:32', '2025-04-24 06:40:32', NULL, NULL, 'pending'),
(6, 6, 'Blue Backpack', 'A blue backpack with a Nike logo, found near the park bench in Zone 5.', 'Accessories', 'Bical', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/J3VxOQs9luQQMCvT77BqYPtCWWGUCyHMBAWWzlH4.jpg', '2025-05-01 16:06:20', '2025-05-01 23:06:20', '2025-05-01 23:06:20', NULL, '09171234567', 'pending');

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
(7, 9, NULL, '2025-05-08 08:54:20', '2025-05-08 08:54:20');

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
('7v5va5XxA2XVOhVyg6gf6luOtDX9pZXYO2p9sd7F', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid3p5aUp1ak4xV255MHhVTjlyOHREakxEcEFNV0VBb0VZS1E1ZHJJZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1748235884),
('eFLMHNpoovmCMjqePRuTM6mQDcItMt4dFPuR3ES9', 6, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUWZNT1I0cFRCd2o2RW8xMlZvZ2hNVjNJajlqUzc3S0lwekxlaGRUWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjY7fQ==', 1748111559),
('jWaoP7SHdHV1soi6DOlIufNMTFSp3AQn3tM2Oqtp', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoic092WmI2WVpFRnpnZnBJNEhQOGFMTVRHeDZBZXM3ZUpIeWZTMHMzZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9pdGVtcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1748133258),
('Ra7groyCGgpbAmnmG1Krs8Gmt0W6TBQsS6fb2Zxu', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVjVwVndKeGQxSXo2NjE1MzNWeDdySU5mekpKSE9XN2I0SGdMak0zWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC92aWV3LWl0ZW0taW5mby1hcy1hZG1pbi8yNyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1748117062);

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
(1, 2, 4, 'asd', NULL, 'Accessories', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/37der6UmD8lgUy2BkV1NODORou9HUbfHswILe85o.jpg', '2025-05-01 02:55:04', '2025-02-19 17:57:35', '2025-05-01 02:55:04'),
(5, 6, 5, 'asd', 'asdasdsd', 'Human', 'Lost', NULL, 'http://127.0.0.1:8000/storage/images/vdBMvvh7oX3Oamdn1UQfxtEvsiHGfxyj9F0uchjI.jpg', NULL, '2025-05-01 22:30:36', '2025-05-01 22:30:36');

-- --------------------------------------------------------

--
-- Table structure for table `trash_notifications`
--

CREATE TABLE `trash_notifications` (
  `id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text DEFAULT NULL,
  `read_status` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `time_deleted` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trash_notifications`
--

INSERT INTO `trash_notifications` (`id`, `title`, `user_id`, `message`, `read_status`, `created_at`, `updated_at`, `time_deleted`) VALUES
(1, 'Item Marked as Resolved', 2, 'The item you reported has been marked as resolved by the administrator. Thank you for using our service!', 0, '2025-04-24 19:57:15', '2025-04-24 19:57:15', '2025-04-24 12:57:15'),
(2, 'Face to Face Verification', 6, 'Hi Edward,  your item (Blue Backpack) needs to be verified face to face. We encourage you to visit the PNP for additional verification of the item you wish to post.', 1, '2025-05-02 02:50:31', '2025-05-02 02:50:31', '2025-05-01 19:50:31');

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

--
-- Dumping data for table `trash_users`
--

INSERT INTO `trash_users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(7, 'Lenit', 'lenit@gmail.com', '2025-05-03 01:25:47', '$2y$12$QHau.MvDLoJhRa7NBjOpGuh8/ynLI5d57PYT4LsjzQLDHcbhoHH/O', 'user', NULL, '2025-05-03 01:28:51', '2025-05-03 01:28:51'),
(8, 'maryjane', 'maryjane@gmail.com', NULL, '$2y$12$ZEl0WwKQt.xGraXA1UYkvegzz09V7Up0v6tp9dciwoks2pQtEP/Jq', 'user', NULL, '2025-05-03 01:48:14', '2025-05-03 01:48:14'),
(10, 'Boggart', 'iamboggart@gmail.com', NULL, '$2y$12$6oMMOJIdNII5SCv5gxFCTewEkwtFlsmHbn1mw9fuXPVkE/Jnc1Pma', 'user', NULL, '2025-05-03 01:52:21', '2025-05-03 01:52:21');

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
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Boggart', 'user@gmail.com', '2025-02-15 16:30:15', '$2y$12$5Pq.xx7ezXf5lEGnQGlIW.wVj8q7z7RfloQO6.C9/sbA.x/PnXxOm', 'user', NULL, '2025-02-15 16:29:19', '2025-02-16 08:05:53'),
(2, 'Jobel Golde', 'jobelgolde12@gmail.com', '2025-02-15 17:30:39', '$2y$12$eFEzZ8j6sTzlCgzFEDeuCueIAVMZxJFQYcVf9U1bl0FfXxLfdsA/S', 'admin', NULL, '2025-02-16 01:30:39', '2025-02-16 08:05:28'),
(5, 'Boggart', 'iamboggart@gmail.com', NULL, '$2y$12$6oMMOJIdNII5SCv5gxFCTewEkwtFlsmHbn1mw9fuXPVkE/Jnc1Pma', 'user', NULL, '2025-04-13 03:17:17', '2025-04-12 21:50:19'),
(6, 'Edward', 'jobelgolde45@gmail.com', NULL, '$2y$12$UNOojylI.4MQGMhJ1mxMJ.yMyqAVp4flmFirH79FvqYir77EXirtW', 'user', NULL, '2025-04-13 03:19:42', '2025-04-12 21:50:13'),
(7, 'Lenit', 'lenit@gmail.com', '2025-05-03 01:25:47', '$2y$12$QHau.MvDLoJhRa7NBjOpGuh8/ynLI5d57PYT4LsjzQLDHcbhoHH/O', 'user', NULL, '2025-05-03 01:24:43', '2025-05-03 01:25:47'),
(8, 'maryjane', 'maryjane@gmail.com', NULL, '$2y$12$ZEl0WwKQt.xGraXA1UYkvegzz09V7Up0v6tp9dciwoks2pQtEP/Jq', 'user', NULL, '2025-05-03 01:38:07', '2025-05-03 01:38:07'),
(9, 'asd', 'asd@gmail.com', NULL, '$2y$12$SmJh2U/C6O7Pg3jQ1fiO4OQGzDbbj1ikddbfUXExfhhE3sX1WsZgy', 'user', NULL, '2025-05-06 22:59:58', '2025-05-06 22:59:58'),
(11, 'qwe', 'qwe@gmail.com', NULL, '$2y$12$xUk3Viy.ngCmypeMjJ8fme20fb4fpkWfN2igMBAqUeSXfWGAyQxIO', 'user', NULL, '2025-05-07 05:34:10', '2025-05-07 05:34:10');

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
  `facebook_links` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`facebook_links`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users_info`
--

INSERT INTO `users_info` (`id`, `user_id`, `profile_pic`, `address`, `bio`, `contact`, `facebook_links`, `created_at`, `updated_at`) VALUES
(1, 4, '/images/profile.png', NULL, 'sample', NULL, NULL, '2025-02-16 20:50:13', '2025-02-16 20:50:13'),
(2, 2, '/images/profile.png', NULL, 'sample bio', NULL, NULL, '2025-04-13 03:17:17', '2025-04-13 03:17:17'),
(3, 6, '/images/profile.png', NULL, NULL, NULL, NULL, '2025-04-13 03:19:42', '2025-04-13 03:19:42'),
(6, 9, '../../../../public/images/profile.jpeg', NULL, NULL, NULL, NULL, '2025-05-06 22:59:58', '2025-05-06 22:59:58'),
(7, 11, '../../../../public/images/profile.jpeg', NULL, NULL, NULL, NULL, '2025-05-07 05:34:10', '2025-05-07 05:34:10');

-- --------------------------------------------------------

--
-- Table structure for table `view_later`
--

CREATE TABLE `view_later` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Indexes for table `trash`
--
ALTER TABLE `trash`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trash_notifications`
--
ALTER TABLE `trash_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

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
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_admin`
--
ALTER TABLE `contact_admin`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pending_requests`
--
ALTER TABLE `pending_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pinned_chats`
--
ALTER TABLE `pinned_chats`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `resolve_cases`
--
ALTER TABLE `resolve_cases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trash`
--
ALTER TABLE `trash`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `trash_notifications`
--
ALTER TABLE `trash_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users_info`
--
ALTER TABLE `users_info`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `view_later`
--
ALTER TABLE `view_later`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

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
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `trash_notifications`
--
ALTER TABLE `trash_notifications`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trash_users_info`
--
ALTER TABLE `trash_users_info`
  ADD CONSTRAINT `trash_users_info_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `trash_users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
