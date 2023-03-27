----------------Create Tables------------------
CREATE TABLE "customers" (
  "customer_id" SERIAL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  "address" VARCHAR(150),
  "email" VARCHAR(100),
  "contact_number" VARCHAR(15),
  "billing_info" VARCHAR(150),
  PRIMARY KEY ("customer_id")
);

CREATE TABLE "concessions" (
  "concession_id" SERIAL,
  "concession_name" VARCHAR(30),
  "concession_perc" NUMERIC(2,2),
  PRIMARY KEY ("concession_id")
);

CREATE TABLE "genre" (
  "genre_id" SERIAL,
  "genre_name" VARCHAR(50),
  PRIMARY KEY ("genre_id")
);

CREATE TABLE "rating" (
  "rating_id" SERIAL,
  "rating" NUMERIC(4,2),
  "rating_source" VARCHAR(100),
  PRIMARY KEY ("rating_id")
);

CREATE TABLE "movies" (
  "movie_id" SERIAL,
  "movie_name" VARCHAR(150),
  "release_date" DATE,
  "genre_id" INTEGER,
  "rating_id" INTEGER,
  PRIMARY KEY ("movie_id"),
  foreign key(genre_id) references genre(genre_id),
  foreign key(rating_id) references rating(rating_id)
);

CREATE TABLE "shows" (
  "show_id" SERIAL,
  "start_time" TIME,
  "end_time" TIME,
  "language" VARCHAR(30),
  "movie_id" INTEGER,
  PRIMARY KEY ("show_id")
);

------------------------------ Alter Table - Add constraints
ALTER TABLE shows
    ADD CONSTRAINT fk_movie_shows FOREIGN KEY (movie_id) REFERENCES movies (movie_id);

  
CREATE TABLE "tickets" (
  "ticket_id" SERIAL,
  "seat_number" CHAR(3),
  "price" NUMERIC(3,2),
  "show_id" INTEGER,
  PRIMARY KEY ("ticket_id")
);

------------------------------- Drop Table
DROP TABLE IF EXISTS
   tickets
CREATE TABLE "tickets" (
  "ticket_id" SERIAL,
  "seat_number" CHAR(3),
  "price" NUMERIC(3,2),
  "show_id" INTEGER,
  PRIMARY KEY ("ticket_id"),
  foreign key(show_id) references shows(show_id)
);
   

CREATE TABLE "bookings" (
  "booking_id" SERIAL,
  "booking_amount" NUMERIC(5,2),
  "customer_id" INTEGER,
  "ticket_id" INTEGER,
  "concession_id" INTEGER,
  PRIMARY KEY ("booking_id"),
  CONSTRAINT "FK_bookings.customer_id"
  FOREIGN KEY ("customer_id") REFERENCES "customers"("customer_id"),
  FOREIGN KEY ("ticket_id") REFERENCES "tickets"("ticket_id"),
  FOREIGN KEY ("concession_id") REFERENCES "concessions"("concession_id")
);
------------------------------------Alter Table to drop column
ALTER TABLE bookings DROP COLUMN booking_amount;
------------------------------------Alter Table to add column
ALTER TABLE bookings ADD COLUMN "booking_amount" NUMERIC(5,2);
------------------------------------Alter table to change data type for column
ALTER TABLE bookings ALTER COLUMN "booking_amount" TYPE NUMERIC(4,2);
------------------------------------Alter table to change column name
ALTER TABLE bookings RENAME booking_amount TO booking_amt;
ALTER TABLE bookings RENAME booking_amt TO booking_amount;



----------------Insert Data --------------------  
INSERT INTO customers(customer_id,first_name,last_name,address,email,contact_number,billing_info) 
	VALUES(1,'Joel','Carter','555 Circle Dr Chicago,IL 60614','joelcarter@gmail.com','555-333-1432','4242-4242-4242-4242 623 05/24');
select * from customers

INSERT INTO customers(customer_id,first_name,last_name,email,address,contact_number,billing_info)
VALUES(2,'George','Washington','gwash@usa.gov', '3200 Mt Vernon Hwy', '142-451-1512', '8452-1512-4512 10/10');

INSERT INTO customers(customer_id,first_name,last_name,email,address,contact_number,billing_info)
VALUES(3,'John','Adams','jadams@usa.gov','1200 Hancock', '252-123-1500', '6513-1313-0002-8051 10/11');

INSERT INTO genre(genre_id,genre_name)
VALUES(1,'Action');
INSERT INTO genre(genre_id,genre_name)
VALUES(2,'Drama');
INSERT INTO genre(genre_id,genre_name)
VALUES(3,'Science Fiction');
INSERT INTO genre(genre_id,genre_name)
VALUES(4,'Horror');
select * from genre

INSERT INTO rating(rating_id,rating,rating_source)
VALUES(1,4.2, 'IMDB');
INSERT INTO rating(rating_id,rating,rating_source)
VALUES(2,4.5,'New York Times');
INSERT INTO rating(rating_id,rating,rating_source)
VALUES(3, 3.0,'Movie Review Times');
select * from rating

INSERT INTO movies(movie_id,movie_name,release_date,genre_id,rating_id)
VALUES(1,'Avengers','01-05-2019',1,2);
INSERT INTO movies(movie_id,movie_name,release_date,genre_id,rating_id)
VALUES(2,'Spider Man','01-05-2012',3,1);
INSERT INTO movies(movie_id,movie_name,release_date,genre_id,rating_id)
VALUES(3,'Cast Away','01-05-2016',4,3);
select * from movies


----------------Modify Data --------------------  
--Udpate table
update movies 
set release_date = '06-09-2015'
where movie_id = 3

select * from movies

--Delete 
delete from movies where movie_id = 3
select * from movies
