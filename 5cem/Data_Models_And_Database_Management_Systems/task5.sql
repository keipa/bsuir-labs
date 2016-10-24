use labs234;

-- Построить запрос, формирующий вывод всех данных обо всех организациях.
SELECT * FROM company;


-- Построить запрос, формирующий вывод  названия, УНП и фамилии руководителя всех  организаций, 
-- отсортированные в алфавитном порядке по названию организации.
SELECT companyName as 'название', companyUNP as 'УНП', companyHead as 'руководитель'
FROM company
ORDER BY companyName ASC;

-- простые запросы

-- Вывести все данные об организации с названием «ООО «Гранит»»
SELECT * FROM company
WHERE companyName = "OAO Rimmel";


-- Вывести все данные об организациях, являющихся ООО (Обществом с ограниченной ответственностью).
SELECT * FROM company
WHERE companyName like "%OOO%";


-- Сформировать список (содержащий спецификацию, отпускную цену, остаток) товаров на складе по коду каталога 101, 
-- остатки которых более 100 единиц.
SELECT s.stockName as 'stock', p.productName as 'product', 
		se.productLeft as 'left', se.productPrice as 'price', se.productPosition as 'where'
FROM stockestate se, stock s, products p
WHERE p.productName = "shampoo"
AND se.productLeft > 20;


-- Получить список, содержащий отпускную стоимость всех товаров на складе по коду каталога 500 
-- 		и отсортированный в обратном порядке по отпускной стоимости.
SELECT distinct se.productPrice as 'price', se.productLeft as 'left', p.productName as 'product'
FROM stockestate se, stock s, products p
WHERE p.productName = 'shower gel'
ORDER BY se.productPrice DESC
