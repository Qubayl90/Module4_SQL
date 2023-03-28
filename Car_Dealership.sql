------------------------------------Create Table------------------------
CREATE TABLE "salesperson" (
  "salesperson_id" SERIAL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  "email_address" VARCHAR(50),
  "contact_number" VARCHAR(15),
  PRIMARY KEY ("salesperson_id")
);
CREATE TABLE "customer" (
  "customer_id" SERIAL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  "address" VARCHAR(150),
  "email" VARCHAR(50),
  "contact_number" VARCHAR(15),
  PRIMARY KEY ("customer_id")
);
CREATE TABLE "cars" (
  "car_id" SERIAL,
  "make" VARCHAR(30),
  "model" VARCHAR(30),
  "type_old_new" CHAR(3),
  "price" NUMERIC(7,2),
  "color" VARCHAR(20),
  PRIMARY KEY ("car_id")
);

CREATE TABLE "invoice" (
  "invoice_id" SERIAL,
  "invoice_date" DATE,
  "total_amount" NUMERIC(7,2),
  "customer_id" INTEGER,
  "salesperson_id" INTEGER,
  "car_id" INTEGER,
  PRIMARY KEY ("invoice_id"),
  foreign key(customer_id) references customer(customer_id),
  foreign key(salesperson_id) references salesperson(salesperson_id),
  foreign key(car_id) references cars(car_id)
);
CREATE TABLE "mechanic" (
  "mechanic_id" SERIAL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  "email address" VARCHAR(50),
  "contact_number" VARCHAR(15),
  PRIMARY KEY ("mechanic_id")
);
CREATE TABLE "service_tickets" (
  "service_ticket_id" SERIAL,
  "service_date" DATE,
  "complains" VARCHAR(200),
  "s_bill_amount" NUMERIC(6,2),
  "customer_id" INTEGER,
  "mechanic_id" INTEGER,
  "car_id" INTEGER,
  PRIMARY KEY ("service_ticket_id"),
  foreign key(customer_id) references customer(customer_id),
  foreign key(mechanic_id) references mechanic(mechanic_id),
  foreign key(car_id) references cars(car_id)
);
CREATE TABLE "parts" (
  "part_id" SERIAL,
  "part_description" VARCHAR(150),
  "price" NUMERIC(6,2),
  "available_stock" INTEGER,
  PRIMARY KEY ("part_id")
);
CREATE TABLE "service_parts" (
  "service_ticket_id" INTEGER,
  "part_id" INTEGER,
   foreign key(service_ticket_id) references service_tickets(service_ticket_id),
   foreign key(part_id) references parts(part_id)
);


------------------------ Insert Data -------------------------------- 
INSERT INTO customer(customer_id,first_name,last_name,address,email,contact_number) 
	VALUES(1,'Joel','Carter','555 Circle Dr Chicago,IL 60614','joelcarter@gmail.com','555-333-1432');
INSERT INTO customer(customer_id,first_name,last_name,email,address,contact_number)
	VALUES(2,'George','Washington','gwash@usa.gov', '3200 Mt Vernon Hwy', '142-451-1512');
INSERT INTO customer(customer_id,first_name,last_name,email,address,contact_number)
	VALUES(3,'John','Adams','jadams@usa.gov','1200 Hancock', '252-123-1500');

select * from customer

INSERT INTO salesperson(salesperson_id,first_name,last_name,email_address,contact_number) 
	VALUES(1,'Will','Smith','willsmith@gmail.com','142-025-9213');
INSERT INTO salesperson(salesperson_id,first_name,last_name,email_address,contact_number)
	VALUES(2,'Brad','Pitt','brad@hotmail.com', '135-952-1512');
select * from salesperson

ALTER TABLE public.salesperson RENAME COLUMN "email address" TO email_address;


--------------------- Stored Function to insert data into tables------------------------------------------
----------------------Insert Mechanics
create or replace function add_mechanic(_mechanic_id Integer, _first_name varchar, _last_name varchar, _email_address varchar, _contact_number varchar )
returns void
as $MAIN$
begin 
	insert into mechanic(mechanic_id,first_name,last_name,email_address,contact_number)
	values (_mechanic_id, _first_name, _last_name, _email_address,_contact_number);
end
$MAIN$
language plpgsql;

select add_mechanic(1,'John','Carter','jahnc@gmail.com', '252-123-1500')
select add_mechanic(2,'John','Nash','jahnash@gmail.com', '856-484-7023')
select * from mechanic

-----------------------Insert Parts
create or replace function add_part(_part_id Integer, _part_description varchar, _price numeric, _available_stock integer)
returns void
as $MAIN$
begin 
	insert into parts(part_id,part_description,price,available_stock)
	values (_part_id, _part_description, _price, _available_stock);
end
$MAIN$
language plpgsql;

select add_part(1,'Wheel',120.00,26);
select add_part(2,'Mirror',20.25,95);
select * from parts

-- delete/drop the stored function
drop function add_part;
drop function add_mechanic;


------------------------- Insert Cars ---------------------------
INSERT INTO cars(car_id,make,model,type_old_new,price,color) 
	VALUES(1,'BMW','A6','NEW',12002.00,'White');
INSERT INTO cars(car_id,make,model,type_old_new,price,color) 
	VALUES(2,'Mercedes-Benz','A-Class','OLD',9999.00,'Black');
select * from cars c 

------------------------- Insert Invoice -----------------------
INSERT INTO invoice(invoice_id,invoice_date,total_amount, customer_id,salesperson_id,car_id) 
	VALUES(1,'03-03-2023','12002.00',1,2,1);
INSERT INTO invoice(invoice_id,invoice_date,total_amount, customer_id,salesperson_id,car_id) 
	VALUES(2,'03-04-2023',9999.00,2,2,2);
select * from invoice i 

------------------------- Service Tickets -----------------------
INSERT INTO service_tickets (service_ticket_id,service_date,complains,s_bill_amount, customer_id,mechanic_id,car_id) 
	VALUES(1,'03-03-2023','Engine Noise','562.00',1,1,1);
INSERT INTO service_tickets (service_ticket_id,service_date,complains,s_bill_amount, customer_id,mechanic_id,car_id) 
	VALUES(2,'03-12-2023','Break Failure','156.00',2,2,2);
select * from service_tickets

------------------------- Service Parts -----------------------
INSERT INTO service_parts (service_ticket_id,part_id) 
	VALUES(1,1);
INSERT INTO service_parts (service_ticket_id,part_id) 
	VALUES(1,2);
INSERT INTO service_parts (service_ticket_id,part_id) 
	VALUES(2,2);
select * from service_parts
--------------------------------------------------------------------------------------------------------------------------