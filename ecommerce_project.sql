CREATE DATABASE ecommerce_project;

USE ecommerce_project;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1,'Rahul Sharma','rahul@gmail.com','Delhi','2024-01-10'),
(2,'Ananya Singh','ananya@gmail.com','Mumbai','2024-02-05'),
(3,'Rohan Verma','rohan@gmail.com','Bangalore','2024-03-12'),
(4,'Sneha Kapoor','sneha@gmail.com','Delhi','2024-04-18'),
(5,'Aman Gupta','aman@gmail.com','Pune','2024-05-20');

INSERT INTO products VALUES
(101,'Laptop','Electronics',70000),
(102,'Smartphone','Electronics',30000),
(103,'Shoes','Fashion',4000),
(104,'Watch','Accessories',5000),
(105,'Headphones','Electronics',2000);

INSERT INTO orders VALUES
(1001,1,'2024-06-01',74000),
(1002,2,'2024-06-05',30000),
(1003,3,'2024-06-08',4000),
(1004,1,'2024-06-10',2000),
(1005,4,'2024-06-12',5000);

INSERT INTO order_items VALUES
(1,1001,101,1,70000),
(2,1001,105,2,2000),
(3,1002,102,1,30000),
(4,1003,103,1,4000),
(5,1004,105,1,2000),
(6,1005,104,1,5000);

SELECT * FROM customers;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT c.customer_name, o.order_id, o.order_date, o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

SELECT c.customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

SELECT p.category, SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

SELECT c.customer_name, o.order_id
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.city = 'Delhi';

SELECT category, AVG(price) AS avg_price
FROM products
GROUP BY category;
