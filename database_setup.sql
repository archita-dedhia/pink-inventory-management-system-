-- Pink Inventory Management System Database Setup

CREATE DATABASE IF NOT EXISTS pink_inventory;
USE pink_inventory;

-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories table for inventory organization
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    parent_category VARCHAR(100) DEFAULT NULL
);

-- Items table
CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(200) NOT NULL,
    category_id INT,
    quantity INT NOT NULL DEFAULT 0,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Activity log table for tracking changes
CREATE TABLE activity_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(50) NOT NULL, -- 'ADD', 'UPDATE', 'DELETE'
    item_id INT,
    item_name VARCHAR(200),
    old_quantity INT,
    new_quantity INT,
    user_id INT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details JSON,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Low stock alerts table
CREATE TABLE stock_alerts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT,
    alert_type VARCHAR(20), -- 'LOW_STOCK', 'OUT_OF_STOCK'
    threshold_value INT,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES items(id)
);

-- Insert default categories
INSERT INTO categories (category_name, parent_category) VALUES 
('Clothing', NULL),
('Electronics', NULL),
('Books', NULL),
('Home & Garden', NULL);

INSERT INTO categories (category_name, parent_category) VALUES 
('Tops', 'Clothing'),
('Pants', 'Clothing'),
('Dresses', 'Clothing'),
('Shoes', 'Clothing');

-- Insert a default admin user (password should be hashed in real implementation)
INSERT INTO users (username, password, email) VALUES 
('admin', 'admin123', 'admin@pinkinventory.com');

-- Sample items
INSERT INTO items (item_name, category_id, quantity, price, description) VALUES 
('Pink Cotton T-Shirt', 5, 15, 25.99, 'Comfortable cotton t-shirt in pink'),
('Blue Jeans', 6, 8, 49.99, 'Classic blue denim jeans'),
('Floral Summer Dress', 7, 3, 79.99, 'Beautiful floral print summer dress'),
('Pink Sneakers', 8, 1, 89.99, 'Stylish pink canvas sneakers'),
('White Button Shirt', 5, 0, 39.99, 'Professional white button-up shirt');
