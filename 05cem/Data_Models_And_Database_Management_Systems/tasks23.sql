drop database if exists labs234;
create database if not exists labs234;


USE labs234;

CREATE TABLE IF NOT EXISTS orders (
	orderID INT NOT NULL AUTO_INCREMENT,
    customerID INT NOT NULL,
    employeeID INT NOT NULL,
	orderDate DATE NOT NULL,
	ordetDate2 DATE DEFAULT NULL,
	orderInvoiceNumber INT NOT NULL,   -- номер накладной
    orderPrice INT(10) NOT NULL,
    statusID INT NOT NULL,
    orderComment VARCHAR(50) DEFAULT NULL,
	PRIMARY KEY (orderID));


CREATE TABLE IF NOT EXISTS orderStatus (
	statusID INT NOT NULL AUTO_INCREMENT,
    statusName VARCHAR(15) NOT NULL,
    PRIMARY KEY (statusID));


CREATE TABLE IF NOT EXISTS customers (
	customerID INT NOT NULL AUTO_INCREMENT,
    companyID INT NOT NULL,
    customerName VARCHAR(30) NOT NULL,
    customerPhoneOrFax VARCHAR(13) DEFAULT NULL,
	PRIMARY KEY (customerID));


CREATE TABLE IF NOT EXISTS company (
	companyID INT NOT NULL AUTO_INCREMENT,
    companyUNP VARCHAR(20) DEFAULT NULL,
    companyName VARCHAR(30) DEFAULT "Unnamed",
    companyHead VARCHAR(30) DEFAULT NULL,
    companyPhoneOrFax VARCHAR(13) DEFAULT NULL,
    companyAddress VARCHAR(30) DEFAULT NULL,
	PRIMARY KEY (companyID));


-- сотрудники
CREATE TABLE IF NOT EXISTS employees (
	employeeID INT NOT NULL AUTO_INCREMENT,
    employeeName VARCHAR(30) NOT NULL,
    employeePosition VARCHAR(13) DEFAULT NULL,
    employeePhoneOrFax VARCHAR(13) DEFAULT NULL,
	PRIMARY KEY (employeeID));
    

-- поставщики
CREATE TABLE IF NOT EXISTS providers (
	providerID INT NOT NULL AUTO_INCREMENT,
    companyID INT NOT NULL,
    providerName VARCHAR(30) NOT NULL,
    providerPhoneOrFax VARCHAR(13) DEFAULT NULL,
	PRIMARY KEY (providerID));


-- продукты
CREATE TABLE IF NOT EXISTS products (
	productID INT NOT NULL AUTO_INCREMENT,
    productName VARCHAR(20) NOT NULL,
	PRIMARY KEY (productID));


-- склад
CREATE TABLE IF NOT EXISTS stock (
	stockID INT NOT NULL AUTO_INCREMENT,
    stockName VARCHAR(20) NOT NULL,
    stockAddress VARCHAR(20) NOT NULL,
	PRIMARY KEY (stockID));
    

CREATE TABLE IF NOT EXISTS stockEstate (
	stockID INT NOT NULL,
    productID INT NOT NULL,
    productPrice FLOAT NOT NULL,
    productLeft FLOAT DEFAULT NULL,
    productPosition VARCHAR(20) NOT NULL);


-- поставка на склад
CREATE TABLE IF NOT EXISTS delivery (
	stockID INT NOT NULL,
    deliveryData DATE NOT NULL,
    providerID INT NOT NULL,
    productID INT NOT NULL,
    productCount FLOAT NOT NULL,
    deliveryPrice FLOAT NOT NULL,
	PRIMARY KEY (stockID, deliveryData));


-- информация о заказанных товарах
CREATE TABLE IF NOT EXISTS orderInfo (
	orderID INT NOT NULL,
    stockID INT NOT NULL,
    orderCount FLOAT NOT NULL,
    orderPrice FLOAT NOT NULL);


-- ADD CONSTRAINT  FOREIGN KEY () REFERENCES () ON UPDATE CASCADE;
ALTER TABLE orders
ADD CONSTRAINT has_status FOREIGN KEY (statusID) REFERENCES orderStatus(statusID) ON UPDATE CASCADE,
ADD CONSTRAINT was_made_by FOREIGN KEY (customerID) REFERENCES customers(customerID) ON UPDATE CASCADE,
ADD CONSTRAINT was_issued_by FOREIGN KEY (employeeID) REFERENCES employees(employeeID) ON UPDATE CASCADE;

ALTER TABLE customers
ADD CONSTRAINT is_from FOREIGN KEY (companyID) REFERENCES company(companyID) ON UPDATE CASCADE;

ALTER TABLE providers
ADD CONSTRAINT is_from_company FOREIGN KEY (companyID) REFERENCES company(companyID) ON UPDATE CASCADE;

ALTER TABLE delivery
ADD CONSTRAINT from_stock FOREIGN KEY (stockID) REFERENCES stock(stockID) ON UPDATE CASCADE,
ADD CONSTRAINT from_provider FOREIGN KEY (providerID) REFERENCES providers(providerID) ON UPDATE CASCADE,
ADD CONSTRAINT is_product FOREIGN KEY (productID) REFERENCES products(productID) ON UPDATE CASCADE;

ALTER TABLE orderInfo
ADD CONSTRAINT is_from_oreder FOREIGN KEY (orderID) REFERENCES orders(orderID) ON UPDATE CASCADE,
ADD CONSTRAINT is_from_stock FOREIGN KEY (stockID) REFERENCES stock(stockID) ON UPDATE CASCADE;

ALTER TABLE stockEstate
ADD CONSTRAINT from_the_stock FOREIGN KEY (stockID) REFERENCES stock(stockID) ON UPDATE CASCADE,
ADD CONSTRAINT has_product FOREIGN KEY (productID) REFERENCES products(productID) ON UPDATE CASCADE;