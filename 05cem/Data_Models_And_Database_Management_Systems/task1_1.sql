-- drop database bsuir_labs;
-- create database bsuir_labs;
USE bsuir_labs;

drop table if exists customers;
drop table if exists orders;
drop table if exists products;
drop table if exists managers;    
drop table if exists suppliers;


CREATE TABLE IF NOT EXISTS customers (
	customersID INT NOT NULL AUTO_INCREMENT,
	customersCompany VARCHAR(40) NOT NULL,
    customersCity VARCHAR(20) NOT NULL,
    customersAdress VARCHAR(60) NOT NULL,
    customersPhoneOrFax VARCHAR(13) NOT NULL,
    customersSurname VARCHAR(20) NOT NULL,
	customersName VARCHAR(20) NOT NULL,
    customersPatronymic VARCHAR(20) NOT NULL,
    customersPosition VARCHAR(20) DEFAULT NULL,
	PRIMARY KEY (customersID));


CREATE TABLE IF NOT EXISTS orders (
	orderID INT NOT NULL AUTO_INCREMENT,
	orderDate DATE NOT NULL,
	ordetDate2 DATE DEFAULT NULL,
	-- номер накладной
	invoiceNumber INT NOT NULL,
    orderPrice INT(10) NOT NULL,
    orderStatus ENUM('оформлен', 'оплачен', 'отгружен', 'аннулирован') DEFAULT 'оформлен',
	PRIMARY KEY (orderID));


CREATE TABLE IF NOT EXISTS products (
	productID INT NOT NULL AUTO_INCREMENT,
	productName VARCHAR(20) NOT NULL,
    productGroup VARCHAR(25) NOT NULL,
    PRIMARY KEY (productID));


-- "склад товаров"
CREATE TABLE IF NOT EXISTS warehouse (
	warehouseID INT NOT NULL AUTO_INCREMENT,
	productID INT NOT NULL,
    productDate DATE NOT NULL,
	productDate2 FLOAT DEFAULT NULL,
    productInvoiceNumber INT NOT NULL,
    productCount INT DEFAULT NULL,
    productPrice FLOAT NOT NULL,
    FOREIGN KEY (productID) REFERENCES products(productID) ON UPDATE CASCADE,
	PRIMARY KEY(warehouseID));


CREATE TABLE IF NOT EXISTS managers (
	managersID INT NOT NULL AUTO_INCREMENT,
	managersSurname VARCHAR(20) NOT NULL,
	managersName VARCHAR(20) NOT NULL,
    managersPatronymic VARCHAR(20) NOT NULL,
    managersPosition VARCHAR(20) NOT NULL,
    managersAdress VARCHAR(50) NOT NULL,
    managersPhone VARCHAR(15) DEFAULT NULL,
    managersFax VARCHAR(15) DEFAULT NULL,
    managersPhoto VARCHAR(30),
    PRIMARY KEY (managersID));


-- поставщики
CREATE TABLE IF NOT EXISTS suppliers (
	supplierID INT NOT NULL AUTO_INCREMENT,
	supplierCompany VARCHAR(20) NOT NULL,
    supplierCity VARCHAR(20) NOT NULL,
    supplierAddress VARCHAR(50) NOT NULL,
    supplierPhone VARCHAR(15) DEFAULT NULL,
    supplierFax VARCHAR(15) DEFAULT NULL,
    supplierName VARCHAR(20) NOT NULL,
    supplierSurname VARCHAR(20) NOT NULL,
    supplierPatronymic VARCHAR(20) NOT NULL,
    supplierPosition VARCHAR(20) NOT NULL,
    PRIMARY KEY (supplierID));


--  ON DELETE RESTRICT ?
ALTER TABLE customers
ADD customersOrderID INT DEFAULT NULL,
ADD FOREIGN KEY (customersOrderID) REFERENCES orders(orderID) ON UPDATE CASCADE;

ALTER TABLE orders
ADD productID INT DEFAULT NULL,
ADD FOREIGN KEY (productID) REFERENCES products(productID) ON UPDATE CASCADE;

ALTER TABLE products
ADD supplierID INT DEFAULT NULL,
ADD FOREIGN KEY (supplierID) REFERENCES suppliers(supplierID) ON UPDATE CASCADE;

ALTER TABLE managers
ADD orderID INT DEFAULT NULL,
ADD CONSTRAINT issued FOREIGN KEY (orderID) REFERENCES orders(orderID) ON UPDATE CASCADE;