use labs234;

INSERT INTO orderStatus (statusName) VALUES
	("processed"),
    ("paid"),
    ("shipped"),
    ("cancelled");


INSERT INTO products (productName) VALUES
	("laundry soap"), ("hand soap"),
	("liquid soap"),  ("shower gel"),
    ("bath foam"),    ("bath salt"),
    ("shampoo"),      ("conditioner"),
    ("toothbrush"),   ("toothpaste"),
    ("dental floss"), ("breath freshener"),
    ("hand cream"),   ("face cream"),
    ("towel"),        ("floor cloth"),
    ("sponge"),       ("cleanser");
   

INSERT INTO company (companyUNP, companyName, companyHead, companyPhoneOrFax, companyAddress) VALUES
	("1w008", "Rodial", "Steven Wiggins", "25 68 9", "New York"),
    ("84s56", "SkinChemists", "Mervyn Logan", "88 92 1", "Los Angeles"),
    ("1h8c4", "Willow Organic Beauty", "Baldric Cain", "90 58 5", "Los Angeles"),
    ("44dw9", "Rimmel", "Andrew Porter", "94 58 2", "New York"),
    ("5wd78", "The Home Depot", "Ronald Welch", "11 05 6", "Houston"),
    ("pd48e", "Leroy Merlin", "Joseph Gaines", "65 95 3", "Chicago"),
    ("d71e4", "Menards", "Harry Lang", "89 52 8", "Chicago"),
    ("w8475", "Sherwin-Williams", "Peter Davidson", "88 29 6", "Dallas"),
    ("d8r51", "Tractor Supply Company", "Tyler Gardner", "84 45 2", "Charlotte"),
    ("f81e4", "Kingfisher", "Griffin Wilcox", "44 51 5", "Chicago"),
    ("fx1sg", "Mr. Bricolage", "David Blair", "58 84 1", "Dallas");
    

INSERT INTO employees (employeeName, employeePosition, employeePhoneOrFax) VALUES
	("Mark Owens", "SEO", "59 02 1"),
    ("Donald Powers", "manager", "40 25 3"),
    ("Clinton Flowers", "manager", "95 85 5"),
    ("Joseph Cameron", "assistant", "49 85 8"),
    ("Trevor Gilmore", "assistant", "75 85 4");


INSERT INTO customers (companyID, customerName, customerPhoneOrFax) VALUES
	("3", "Frank Price", "48 52 5"),
    ("6", "Samuel Riley", "45 14 1"),
    ("2", "Riley Moody", "95 85 8"),
    ("1", "Grant Sparks", "20 55 2"),
    ("3", "Clifford Ramsey", "49 21 5");
    

INSERT INTO providers (companyID, providerName, providerPhoneOrFax) VALUES
	("4", "Frank Cameron", "95 12 2"),
    ("5", "Donald French", "20 85 2"),
    ("7", "Jack Lee", "95 87 4"),
    ("5", "Brian Newton", "45 47 8"),
    ("4", "Paul Thornton", "65 21 0"),
    ("6", "Jack McDaniel", "15 10 7");
    
    
INSERT INTO stock (stockName, stockAddress) VALUES
	("Stock1", "New York"),          ("Mishas stock", "Los Angeles"),
    ("Stockstock", "Los Angeles"),   ("Grooozs stock", "New York"),
    ("Romans stock", "Houston");


INSERT INTO stockEstate (stockID, productID, productPrice, productLeft, productPosition) VALUES
	( 1, 1, 1.2, 20, "r.2, n.127"),   ( 1, 2, 1.6, 24, "r.3, n.29"),
    ( 1, 3, 2.1, 43, "r.3, n.21"),    ( 1, 4, 4.5, 32, "r.4, n.21"),
    ( 1, 7, 4.1, 18, "r.2, n.13"),    ( 1, 8, 3.8, 21, "r.5, n.12"),
    ( 1, 15, 10.2, 7, "r.4, n.12"),   ( 2, 1, 1.5, 12, "r.3, n.13"),
    ( 2, 2, 1.4, 4, "r.3, n.54"),     ( 2, 4, 3.2, 14, "r.4, n.6"),
    ( 3, 10, 5.3, 24, "r.3, n.87"),   ( 3, 11, 5.1, 23, "r.4, n.23"),
    ( 3, 12, 4.2, 32, "r.4, n.23"),   ( 4, 13, 7.3, 54, "r.3, n.54"),
    ( 3, 14, 6.2, 43, "r.4, n.76"),   ( 5, 1, 2.1, 13, "r.4, n.43"),
    ( 5, 2, 1.4, 17, "r.4, n.23"),    ( 5, 3, 2.3, 13, "r.2, n.23"),
    ( 5, 4, 1.9, 29, "r.3, n.34"),    ( 5, 5, 6.1, 24, "r.4, n.23"),
    ( 5, 6, 7.1, 34, "r.2, n.37"),    ( 5, 7, 6.2, 32, "r.3, n.13"),
    ( 5, 8, 5.2, 23, "r.4, n.26"),    ( 5, 9, 3.7, 14, "r.3, n.28"),
    ( 5, 10, 7.4, 24, "r.2, n.13"),   ( 5, 11, 6.1, 16, "r.2, n.71"),
    ( 5, 12, 5.2, 23, "r.4, n.26"),   ( 5, 13, 3.7, 14, "r.3, n.28"),
    ( 5, 14, 7.9, 14, "r.2, n.43"),   ( 5, 15, 6.5, 14, "r.2, n.71"),
    ( 5, 16, 4.2, 21, "r.3, n.26"),   ( 5, 17, 2.7, 18, "r.3, n.28"),
    ( 5, 18, 7.1, 14, "r.2, n.13");
   
   
INSERT INTO delivery (stockID, providerID, productID, productCount, deliveryData, deliveryPrice) VALUES
	(1, 1, 3, 10, "2016-09-10", 2.1),
    (2, 1, 2, 5, "2016-09-11", 1.4),
    (3, 4, 10, 10, "2016-09-02", 5.3),
    (4, 4, 13, 10, "2016-09-10", 7.3),
    (5, 2, 17, 10, "2016-09-01", 2.7);
    

INSERT INTO orders (customerID, employeeID, orderDate, ordetDate2, orderInvoiceNumber, orderPrice, statusID, orderComment) VALUES
	(2, 1, "2016-09-11", "2016-09-12", 42, 21, 3, "done"),
    (3, 1, "2016-09-11", "2016-09-12", 21, 32, 3, "done"),
    (1, 2, "2016-09-01", null, 523, 18, 4, "cancelled"),
    (4, 4, "2016-09-09", "2016-09-10", 133, 21, 4, "done"),
    (2, 3, "2016-09-10", "2016-09-14", 93, 51, 4, "done"),
    (2, 4, "2016-09-10", "2016-09-13", 94, 31, 4, "done"),
    (1, 5, "2016-09-10", "2016-09-17", 73, 12, 4, "done"),
    (1, 3, "2016-09-10", "2016-09-14", 521, 43, 2, "???"),
    (2, 3, "2016-09-10", "2016-09-16", 24, 81, 4, "done"),
    (4, 1, "2016-09-14", "2016-09-15", 325, 24, 4, "done"),
    (4, 2, "2016-09-10", "2016-09-14", 937, 53, 4, "done"),
    (4, 1, "2016-09-10", "2016-09-14", 938, 24, 4, "done"),
    (1, 2, "2016-09-13", "2016-09-17", 34, 63, 4, "done"),
    (3, 2, "2016-09-15", "2016-09-17", 923, 74, 4, "done"),
    (5, 2, "2016-09-10", "2016-09-12", 953, 53, 4, "done");
    
    
INSERT INTO orderinfo (orderID, stockID, orderCount, orderPrice) VALUES
	(1, 1, 10, 21),   (2, 1, 5, 32),
    (1, 2, 5, 18),    (3, 2, 10, 21),
    (1, 5, 5, 51),    (2, 3, 5, 31),
    (2, 4, 5, 12),    (2, 1, 5, 43),
    (2, 4, 5, 81),    (2, 3, 5, 24),
    (3, 1, 5, 53),    (4, 1, 5, 24),
    (3, 2, 5, 63),    (2, 3, 5, 74),
    (4, 1, 10, 53);