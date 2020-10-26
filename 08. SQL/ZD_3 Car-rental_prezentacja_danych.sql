USE car_rental;

DESCRIBE cars;
SELECT * FROM cars;
SELECT * FROM cars WHERE year > 2015;

DESCRIBE bookings;
SELECT * FROM bookings WHERE total_amount BETWEEN 1000 AND 2555;

DESCRIBE client;
SELECT client_id FROM client WHERE surname LIKE 'N%' AND name LIKE '%ej';

SELECT c.name, b.total_amount FROM client c JOIN bookings b 
ON c.client_id = b.client_id WHERE total_amount > 1000;

SELECT * FROM bookings WHERE start_date >20200712 AND 20200720;

SELECT c.city, b.start_date, ca.horse_power, b.total_amount,  
FROM client c, bookings b, cars ca WHERE
c.client_id = b.client_id 
AND ca.car_id = b.car_id
AND start_date >20200712 AND 20200720
AND horse_power <120
ORDER BY total_amount DESC;

SELECT c.city, b.total_amount FROM clients c
JOIN bookings b ON c.client_id = b.client_id
JOIN cars r ON b.car_id = r.car_id
WHERE b.start_date >= '2020-07-12'
AND b.end_date <= '2020-07-20'
AND r.horse_power <= 120
ORDER BY b.total_amount DESC;

SELECT * FROM bookings;
SELECT * FROM client;
SELECT * FROM cars;



SELECT COUNT(*), r.car_id, r.horse_power, r.price_per_day, b.total_amount FROM cars r 
JOIN bookings b ON r.car_id = b.car_id
WHERE price_per_day >= 300
GROUP BY horse_power
ORDER BY horse_power; 

SELECT COUNT(b.car_id) FROM bookings b
JOIN cars r ON b.car_id = r.car_id
WHERE r.price_per_day >= 300
GROUP BY r.horse_power
ORDER BY r.horse_power;

SELECT SUM(b.total_amount), b.booking_id FROM bookings b 
WHERE start_date >= 20200714
AND end_date <= 20200718;

SELECT 
c.client_id,
c.name AS 'Imie', c.surname AS 'Nazwisko',
AVG(b.total_amount) AS 'Srednia_wartosc_rezerwacji', 
COUNT(car_id) AS 'Liczba_wypozyczonych_samochodow' 
FROM bookings b JOIN client c ON b.client_id = c.client_id
GROUP BY b.client_id HAVING COUNT(car_id) > 1 
ORDER BY Liczba_wypozyczonych_samochodow DESC;
