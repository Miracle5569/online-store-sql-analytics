-- SQL-запросы аналитики

-- Общая сумма заказов по пользователям
SELECT username, SUM(price * quantity) AS total_spent
FROM users
JOIN orders ON users.id = orders.user_id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id
GROUP BY username;

-- Количество проданных товаров
SELECT products.name AS product_name, SUM(order_items.quantity) AS total_quantity
FROM products
JOIN order_items ON products.id = order_items.product_id
GROUP BY products.name
ORDER BY total_quantity DESC;

-- Средняя сумма заказа
SELECT SUM(price * quantity) / COUNT(DISTINCT orders.id) AS avg_order_sum
FROM orders
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id;

-- Пользователи, потратившие больше среднего
SELECT username, SUM(price * quantity) AS total_spent
FROM users
JOIN orders ON users.id = orders.user_id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id
GROUP BY username
HAVING SUM(price * quantity) > (
  SELECT AVG(user_total)
  FROM (
    SELECT SUM(price * quantity) AS user_total
    FROM orders
    JOIN order_items ON orders.id = order_items.order_id
    JOIN products ON order_items.product_id = products.id
    GROUP BY orders.user_id
  ) sub
);

-- Ранжирование заказов по сумме
SELECT orders.id AS order_id, users.username, SUM(price * quantity) AS total_sum,
       RANK() OVER (ORDER BY SUM(price * quantity) DESC) AS order_rank
FROM orders
JOIN users ON users.id = orders.user_id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id
GROUP BY orders.id, users.username
