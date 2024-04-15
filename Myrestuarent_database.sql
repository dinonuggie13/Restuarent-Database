
/*Hellen Gulzari
21525039 */



CREATE TABLE orders (
    orderid int NOT NULL PRIMARY KEY,
    tablenumber INT FOREIGN KEY REFERENCES tables(tablenumber),
	employee INT FOREIGN KEY REFERENCES employees(employeeid) NOT NULL ,
    orderdate DATE NOT NULL,   
    ordertype VARCHAR(30),
    ordertime TIME,
    check (ordertype in ('Dine in', 'Takeaway'))
);



select * from orders;


Create Table employees(
employeeid INT NOT NULL PRIMARY KEY,
firstname VARCHAR(30) NOT NULL,
lastname  VARCHAR(30) NOT NULL,
shifttimes VARCHAR(30) NOT NULL,
email VARCHAR(100),
phonenumber VARCHAR(15) NOT NULL, 
homeaddress VARCHAR(100) NOT NULL,
Jobname VARCHAR(30) NOT NULL,
employementstatus VARCHAR(20), 
performance VARCHAR(20),
hiredate date,
check (employementstatus in ('employed', 'umemployed')),
check (performance in ('below-expectation', 'average', 'excellent')),

);

CREATE TABLE employees_audit (
    audit_id INT IDENTITY(1,1) PRIMARY KEY,
    employeeid INT NOT NULL,
    action CHAR(1) NOT NULL,
    audit_data XML NOT NULL,
    audit_date DATETIME NOT NULL
);



CREATE TABLE tables (
tablenumber INT NOT NULL PRIMARY KEY,
tablestatus VARCHAR(20),
tablecapacity INT NOT NULL, 
tabletype varchar(20),
CHECK (tablecapacity in (2,4,6)),
CHECK (tabletype in ('outdoor', 'indoor', 'window')),

);



CREATE TABLE reservations(
reservationid INT PRIMARY KEY NOT NULL, 
tableid INT FOREIGN KEY REFERENCES tables(tablenumber) NOT NULL,
reservationdate DATE NOT NULL,
reservationstatus VARCHAR(20) NOT NULL ,
additionalinformation VARCHAR(100),
CHECK (reservationstatus in('confirmed','pending','cancelled'))


);

drop table reservations;




CREATE TABLE menu(
menuid INT PRIMARY KEY NOT NULL, 
itemname VARCHAR(100),
itemprice DECIMAL(10, 2) NOT NULL,
catagory VARCHAR(100) NOT NULL, 
CHECK (catagory in ('seafood', 'chinese', 'vegetarian', 'vegan')),
);


CREATE TABLE payments(
paymentid int PRIMARY KEY NOT NULL,
customername VARCHAR(100) NOT NULL, 
paymentdate DATE NOT NULL,
paymentmethod VARCHAR(100), 
paymentstatus VARCHAR(100),
paymentsource VARCHAR(100) NOT NULL, 
paymentdestination VARCHAR(100) NOT NULL, 
transactionfee VARCHAR(30),  

);


CREATE TABLE menuorders(
orderid INT NOT NULL, 
menuid INT NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY(orderid, menuid),
FOREIGN KEY(orderid) REFERENCES orders(orderid),
FOREIGN KEY(menuid) REFERENCES menu(menuid)
); 

drop table menuorders;

CREATE TABLE payedorder(
order_id INT, 
payment_id INT, 
payed_amount INT,
PRIMARY KEY(order_id, payment_id), 
FOREIGN KEY(order_id) REFERENCES orders(orderid), 
FOREIGN KEY(payment_id) REFERENCES payments(paymentid)

);
drop table payedorder;


/*learn about indexing */



select * from reservations;


 -- Orders table
INSERT INTO orders (orderid, tablenumber, employee, orderdate, ordertype, ordertime)
VALUES (01,30, 1, '2023-03-20', 'Dine in', '18:45:00'),
       (02,20, 2,'2023-03-19', 'Takeaway', '13:15:00'),
       (03,10, 3,'2023-03-21', 'Dine in', '20:30:00'),
       (04,40, 4, '2023-03-18', 'Takeaway', '16:00:00'),
       (05,50, 5,'2023-03-21', 'Dine in', '19:00:00');

	select * from orders;




-- Employees table
INSERT INTO employees (employeeid,firstname, lastname, shifttimes, email, phonenumber, homeaddress, jobname, employementstatus, performance, hiredate)
VALUES (1,'John', 'Doe', '8am-4pm', 'johndoe@gmail.com', '555-1234', '123 Main St, rotokauri, Whangari', 'Waiter', 'employed', 'average', '2022-05-15'),
       (2,'Jane', 'Smith', '4pm-12am', 'janesmith@gmail.com', '555-5678', '456 Oak St, wembledon, Hamilton', 'waitress', 'employed', 'excellent', '2021-09-01'),
       (3,'Bob', 'Johnson', '8am-4pm', 'bobjohnson@gmail.com', '555-9876', '789 Maple St, Anytown, Australia', 'waiter', 'employed', 'excellent', '2020-02-15'),
       (4,'Emily', 'Wong', '12am-8am', 'emilywong@gmail.com', '555-4321', '321 Elm St, Anytown, Hamilton', 'Waitress', 'employed', 'average', '2021-03-01'),
       (5,'Tom', 'Lee', '12pm-8pm', 'tomlee@gmail.com', '555-8765', '654 Pine St, Anytown, Chrischurch', 'waitress', 'employed', 'excellent', '2020-11-15');

-- Tables table
INSERT INTO tables (tablenumber, tablestatus, tablecapacity, tabletype)
VALUES (10,'Occupied', 2, 'indoor'),
       (20,'Available', 6, 'outdoor'),
       (30,'Occupied', 4, 'window'),
       (40,'Available', 2, 'indoor'),
       (50,'Available', 4, 'outdoor');

delete from tables 
where tablenumber IN (1,2,3,4,5);


-- Reservations table
INSERT INTO reservations (reservationid,tableid, reservationdate, reservationstatus, additionalinformation)
VALUES (001,30, '2023-03-23', 'confirmed', 'Anniversary dinner'),
       (002,20, '2023-03-22', 'pending', 'Large party'),
       (003,10, '2023-03-24', 'confirmed', 'Birthday celebration'),
       (004,40, '2023-03-20', 'cancelled', 'Change of plans'),
       (005,50, '2023-03-25', 'confirmed', 'Family dinner');

--Payment table
INSERT INTO payments (paymentid, customername, paymentdate, paymentmethod, paymentstatus, paymentsource, paymentdestination, transactionfee) 
VALUES 
(111,'John dear', '2022-01-15', 'Credit Card', 'Completed', 'NZ Bank', 'ABC Company', '$2.50'),
(222,'Janent loe', '2022-02-01', 'PayPal', 'Completed', 'PayPal Account', 'XYZ Store', '$1.25'),
(333,'Bobby brown', '2022-02-15', 'ACH Transfer', 'Pending', 'Kiwi Bank', '123 Business', '$0.50'),
(555,'Sarah Lee choy', '2022-03-01', 'Debit Card', 'Completed', 'loyd Bank', '789 Corporation', '$1.00'),
(444,'Tomas Wilson', '2022-03-15', 'Cash', 'Completed', 'NA', '456 Enterprise', '$0.00');



-- Menu table
INSERT INTO menu (menuid, itemname, itemprice, catagory)
VALUES (1,'Grilled Salmon', 18, 'seafood'),
       (2,'Kung Pao Chicken', 13, 'chinese'),
       (3,'Vegetable Curry', 12, 'vegetarian'),
       (4,'Vegan Burger', 10, 'vegan'),
       (5,'Lobster Ravioli', 22, 'seafood');


--conjuction table payedorder
INSERT INTO payedorder(order_id, payment_id, payed_amount)
VALUES (01,111,40); 
INSERT INTO payedorder(order_id, payment_id, payed_amount)
VALUES (02,222,59); 
INSERT INTO payedorder(order_id, payment_id, payed_amount)
VALUES (03,333, 39); 
INSERT INTO payedorder(order_id, payment_id, payed_amount)      
VALUES (04,444,43);
INSERT INTO payedorder(order_id, payment_id, payed_amount)
VALUES (05,555,32); 


--menuorders


INSERT INTO menuorders(orderid, menuid, quantity)
VALUES(01,2,2);

INSERT INTO menuorders(orderid, menuid, quantity)
VALUES(02,1,3);

INSERT INTO menuorders(orderid, menuid, quantity)
VALUES(03,4,1);

INSERT INTO menuorders(orderid, menuid, quantity)
VALUES(04,3,1);

INSERT INTO menuorders(orderid, menuid, quantity)
VALUES(05,5,3);





Select * from tables;
Select * from orders;
select * from reservations;
Select * from menu;
Select * from employees; 
select * from payments;

select * from menuorders;
select * from payedorder;



