-- Наполнение базы данных начальными тестовыми данными

INSERT INTO categories (name) VALUES
('Books'),
('Electronics');

INSERT INTO products (name, price, category_id) VALUES
('Fiction Book', 15.99, 1),
('Science Book', 22.50, 1),
('Smartphone', 699.99, 2),
('Laptop', 999.50, 2),
('E-Book Reader', 129.00, 2);

INSERT INTO users (username) VALUES
('alice'),
('bob'),
('max');

INSERT INTO orders (user_id, created_at) VALUES
(1, now()),
(2, now()),
(3, now());

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 3, 1),     -- Smartphone
(1, 1, 2),     -- Fiction Book
(2, 4, 1),     -- Laptop
(3, 5, 1),     -- E-Book Reader
(3, 2, 2);     -- Science Book
