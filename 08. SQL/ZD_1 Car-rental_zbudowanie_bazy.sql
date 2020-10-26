CREATE DATABASE car_rental;
USE car_rental;
CREATE TABLE cars(
car_id VARCHAR (20) PRIMARY KEY,
producer VARCHAR (20),
model VARCHAR (20),
year VARCHAR (20),
horse_power VARCHAR (20),
price_per_day INTEGER
)
CREATE TABLE client(
client_id VARCHAR (20) PRIMARY KEY,
name VARCHAR (20),
surname VARCHAR (20),
address VARCHAR (20),
city VARCHAR (20)
)
CREATE TABLE bookings(
booking_id VARCHAR (20) PRIMARY KEY,
client_id VARCHAR (20),
car_id VARCHAR (20),
start_date DATE,
end_date DATE,
total_amount INTEGER
)

ALTER TABLE client MODIFY COLUMN client_id INTEGER AUTO_INCREMENT;
ALTER TABLE cars MODIFY COLUMN car_id INTEGER AUTO_INCREMENT;
ALTER TABLE bookings MODIFY COLUMN booking_id INTEGER AUTO_INCREMENT;


ALTER TABLE bookings MODIFY COLUMN client_id INTEGER;
ALTER TABLE bookings MODIFY COLUMN car_id INTEGER;

ALTER TABLE bookings ADD CONSTRAINT clientbooking_idbooking_id_fk FOREIGN KEY (client_id) REFERENCES client (client_id);
ALTER TABLE bookings ADD CONSTRAINT car_fk FOREIGN KEY (car_id) REFERENCES cars (car_id);





