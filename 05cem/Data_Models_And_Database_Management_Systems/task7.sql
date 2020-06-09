-- Вывести реквизиты организаций (название, УНП и юр.адрес), которые являются поставщиками.
SELECT DISTINCT c.companyName, c.companyUNP, c.companyAddress
FROM company c
JOIN providers p
WHERE c.companyID = p.companyID;


-- Вывести наименования товаров, которые еще не поставлялись на склад.
SELECT productName, stockID
FROM stockestate se
LEFT JOIN products p
USING (productID)
WHERE stockID is null;


-- Вывести  наименование товаров, на складе остатки которых 100 и меньше.
SELECT productName AS 'name', SUM(productLeft) AS 'count'
FROM stockestate se LEFT JOIN products p USING (productID)
GROUP BY productName
HAVING SUM(productLeft) < 30 ; 


-- Определить наименование организаций, сделавших более 2 заказов.
SELECT com.companyName
FROM orders o 
LEFT JOIN customers cus USING (customerID)
LEFT JOIN company com USING (companyID)
GROUP BY com.companyName
HAVING COUNT(o.orderID) > 2;


-- Определить организации, менеджеры которых сделали заказы на товар с кодом склада 12.
SELECT com.companyName
FROM orders o 
LEFT JOIN customers cus USING (customerID)
LEFT JOIN company com USING (companyID)
LEFT JOIN orderinfo oi USING (orderID)
GROUP BY com.companyName
HAVING COUNT(orderID) > 2;


-- Получить спецификацию монитора, имеющегося  в наличии на складе, цена которого минимальна*. 
SELECT p.productName AS 'product', s.stockName AS 'has min'
FROM stockestate se
LEFT JOIN stock s USING (stockID)
LEFT JOIN products p USING (productID)
WHERE p.productID = 13
AND se.productPrice = (SELECT MIN(productPrice)
						FROM stockestate
                        WHERE productID = 13);
