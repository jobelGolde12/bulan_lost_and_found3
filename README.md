# ONLINE LOST AND FOUND SYSTEM FOR BULAN, SORSOGON
## Capstone project created by:
#### Jobel Golde  
#### Arabella Dwaines Golpeo  
#### Christine Joy Bibat  
#### Kristina Lumabad  

---

## 📌 Overview
The **Online Lost and Found System for Bulan, Sorsogon** is a web-based application designed to help residents efficiently report, search, and claim lost and found items within the community.  
This system improves communication, transparency, and accessibility by providing a centralized platform for reporting and tracking items.

---

## 🛠️ Tech Stack
- **[Laravel](https://laravel.com/)** – Backend framework for building robust APIs and handling business logic  
- **[Vue.js](https://vuejs.org/)** – Reactive frontend JavaScript framework for a dynamic UI  
- **[Inertia.js](https://inertiajs.com/)** – Bridges Laravel and Vue for smooth SPA-like navigation  
- **[Bootstrap](https://getbootstrap.com/)** – Responsive UI components and styling  
- **[ECharts](https://echarts.apache.org/)** – Interactive charts and visualizations  
- **[Pusher](https://pusher.com/)** – Real-time notifications and updates  

---

## ✨ Features
- 🔍 **Search & Match System** – Easily match lost and found items by category, location, or keywords  
- 📤 **Report Lost/Found Items** – Submit details with photos and descriptions  
- 📊 **Analytics Dashboard** – Visual reports using **ECharts**  
- 📩 **Real-time Notifications** – Stay updated with **Pusher** integration  
- 👥 **User Management** – Track members and beneficiaries with role-based access  
- 📱 **Responsive Design** – Works across desktop and mobile with **Bootstrap**  

---

## 🚀 Installation

### Prerequisites
- PHP >= 8.1  
- Composer  
- Node.js & npm  
- MySQL or SQLite database  

### Steps
```bash
# Clone the repository
git clone https://github.com/your-username/online-lost-and-found.git

# Navigate into the project folder
cd online-lost-and-found

# Install backend dependencies
composer install

# Install frontend dependencies
npm install && npm run dev

# Set up environment file
cp .env.example .env
php artisan key:generate

# Run migrations
php artisan migrate --seed

# Start development server
php artisan serve
