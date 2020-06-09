-- многотабличные запросы

-- Вывести все заказы, которые оформил сотрудник фирмы по фамилии “Ружанская О.Л.»  в феврале 2010г., 
-- с указанием кода заказа, номера накладной, даты заказа и общей суммы.
SELECT o.employeeID as 'man ID', e.employeeName as 'name', o.orderID as 'orders ID', 
		o.orderDate as 'date', sum(o.orderPrice) as 'price'
FROM orders o, employees e
WHERE e.employeeName = 'Mark Owens'
AND o.orderDate BETWEEN '2016-09-10' AND '2016-09-15'
GROUP BY o.orderDate;


-- Вывести наименование, спецификацию и остатки на складе товаров с наименованием «Мониторы».
SELECT p.productName, se.productLeft, s.stockName
FROM stockestate se, products p, stock s
WHERE se.productID = p.productID
AND se.stockID = s.stockID
AND se.productLeft > 0
ORDER BY p.productName;


-- Вывести (наименование, спецификацию, дату и количество) поставки на склад мониторов, 
-- отсортированные по спецификации и дате в прямом порядке.
SELECT p.productName, d.deliveryData, p.productName, d.productCount
FROM delivery d, stock s, products p
WHERE d.stockID = s.stockID
AND d.productID = p.productID
AND p.productName = 'hand cream';


-- Вывести (наименование, спецификацию, дату поставки, количество и организацию) поставки УП «Белкантон» 
-- на склад товара с наименованием «Телевизоры».
SELECT d.deliveryData, prod.productName, d.productCount, p.providerName
FROM delivery d, stock s, products prod, providers p
WHERE d.stockID = s.stockID
AND d.productID = prod.productID
AND d.providerID = p.providerID
AND prod.productName = 'hand cream';


-- Вывести состав заказа с кодом 13.
SELECT o.orderID as 'ID', c.customerName as 'оформил', o.orderDate as 'дата', 
		o.orderInvoiceNumber as 'номер', o.orderPrice as 'статус', os.statusName as 'статус', o.orderComment as 'комментарий'
FROM orders o, customers c, employees e, orderstatus os
WHERE o.orderID = 1
AND o.customerID = c.customerID
AND o.employeeID = e.employeeID
AND o.statusID = os.statusID;


-- Вывести отсортированный по менеджерам список менеджеров клиентов и коды заказов, которые они сделали. 
SELECT c.customerID, c.customerName, GROUP_CONCAT(o.orderID SEPARATOR ', ')
FROM customers c, orders o
WHERE o.customerID = c.customerID
GROUP BY c.customerID;


-- Вывести отсортированный по менеджерам список всех менеджеров клиентов и коды заказов, которые они сделали. 
SELECT e.employeeID, e.employeeName, GROUP_CONCAT(o.orderID SEPARATOR ', ')
FROM employees e, orders o
WHERE o.employeeID = e.employeeID
GROUP BY e.employeeID;
