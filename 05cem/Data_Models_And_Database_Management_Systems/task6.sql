-- запросы с группировкой

-- Определить количества заказов в базе данных.
SELECT COUNT(*) FROM orders;


-- Выполнить расчет количества позиций и общую стоимость товаров входящих в заказ, зарегистрированный под кодом номер 3.
SELECT COUNT(oi.orderID) AS 'количество', SUM(oi.orderCount * oi.orderPrice) AS 'стоимость'
FROM orderinfo oi, orders o
WHERE oi.orderID = 3;


-- Выполнить расчет количества поставленного на склад товара с кодом 4 менеджером поставщика с кодом 3.
SELECT SUM(productCount) AS 'количество'
FROM delivery
WHERE stockID = 3
AND providerID = 4;


-- Выполнить расчет общей стоимости поставленной продукции в феврале 2010г. менеджерами поставщика.
SELECT providerID, SUM(productCount * deliveryPrice) AS 'стоимость'
FROM delivery
WHERE deliveryData BETWEEN '2016-09-01' AND '2016-09-15'
GROUP BY providerID;


-- Вывести количество заказов, сделанных всеми менеджерами клиентов, отсортированными в алфавитном порядке по менеджеру.
SELECT c.customerName AS 'who', COUNT(orderID) AS 'count'
FROM orders o, customers c
WHERE o.customerID = c.customerID
GROUP BY c.customerID
ORDER BY c.customerName;


-- Вывести наименования товаров на складе, остатки которых меньше 500.
SELECT p.productName AS 'product', SUM(se.productLeft) AS 'count'
FROM stockestate se, products p
WHERE se.productID = p.productID
GROUP BY se.productID
ORDER BY p.productName;


-- Вывести список менеджеров клиентов общая сумма заказов, которых составила 10000 и более денежных единиц.
SELECT c.customerName AS 'who', SUM(orderPrice) AS 'how much'
FROM orders o, customers c
WHERE o.customerID = c.customerID
AND o.orderPrice < 50
GROUP BY c.customerID
ORDER BY c.customerName;