
--Find list of airport codes in Europe/Moscow timezone
 
select airport_code
from airports where timezone = 'Europe/Moscow';


--Write a query to get the count of seats in various fare condition for every aircraft code?

select aircraft_code,count(seat_no),fare_conditions
from seats 
group by 1,3;


--How many aircrafts codes have at least one Business class seats?

select count(distinct aircraft_code) from seats
having count(fare_conditions = 'Business') >= 1;


--Find out the name of the airport having maximum number of departure flight

SELECT a.Airport_name
FROM Airports a
JOIN (
    SELECT Departure_Airport, COUNT(*) AS DepartureCount
    FROM Flights
    GROUP BY Departure_Airport
) f ON a.Airport_Code = f.Departure_Airport
WHERE f.DepartureCount = (
    SELECT MAX(DepartureCount)
    FROM (
        SELECT Departure_Airport, COUNT(*) AS DepartureCount
        FROM Flights
        GROUP BY 1
    ) subquery);


--Find out the name of the airport having least number of scheduled departure flights


SELECT airport_name
FROM airports
WHERE airport_code IN (
    SELECT departure_airport
    FROM flights
    GROUP BY departure_airport
    HAVING COUNT(*) = (
        SELECT MIN(departure_count)
        FROM (
            SELECT COUNT(*) AS departure_count
            FROM flights
            GROUP BY departure_airport
        ) AS counts
    )
);

--How many flights from ‘DME’ airport don’t have actual departure?


select count(departure_airport) as flight_count from flights
where departure_airport = 'DME' and actual_departure is null;


--Identify flight ids having range between 3000 to 6000


select a.aircraft_code,a.range,f.flight_no
from aircrafts a 
join flights f 
on a.aircraft_code = f.aircraft_code
where a.range BETWEEN 3000 and 6000;



--Write a query to get the count of flights flying between URS and KUF?



SELECT COUNT(*) AS Flight_count
FROM flights
WHERE departure_airport = 'URS' AND arrival_airport = 'KUF';



--Write a query to get the count of flights flying from either from NOZ or KRR?


SELECT COUNT(*) AS Flight_count
FROM flights
WHERE departure_airport IN ('NOZ', 'KRR');


--Write a query to get the count of flights flying from KZN,DME,NBC,NJC,GDX,SGC,VKO,ROV


SELECT departure_airport,COUNT(*) AS Flight_count
FROM flights
WHERE departure_airport IN ('KZN','DME','NBC','NJC','GDX','SGC','VKO','ROV')
group by 1;


--Write a query to extract flight details having range between 3000 and 6000 and flying from DME


SELECT f.Flight_no, a.aircraft_code, range, f.departure_airport
FROM flights f
join aircrafts a 
on a.aircraft_code = f.aircraft_code
WHERE range BETWEEN 3000 AND 6000
AND departure_airport = 'DME';


--Find the list of flight ids which are using aircrafts from “Airbus” company and got cancelled or delayed


SELECT Flight_ID, Model
FROM Flights f
JOIN Aircrafts a 
ON f.Aircraft_code = a.Aircraft_code
WHERE a.Model like '%Airbus%' AND (f.Status = 'Cancelled' OR f.Status = 'Delayed');



--Find the list of flight ids which are using aircrafts from “Boeing” company and got cancelled or delayed


SELECT Flight_ID, Model
FROM Flights f
JOIN Aircrafts a 
ON f.Aircraft_code = a.Aircraft_code
WHERE a.Model like '%Boeing%' AND (f.Status = 'Cancelled' OR f.Status = 'Delayed');




--Which airport(name) has most cancelled flights (arriving)?



with cancelFlight as ( 
select arrival_airport , rank() over(order by (count(flight_no)) desc) as rankCancel
from FLIGHTS f 
join AIRPORTS a
on f.arrival_airport = a.airport_code
where f.status ='Cancelled'
group by 1
order by 2 desc
)
select arrival_airport as Airport_name from cancelFlight
where rankCancel = (select max(rankCancel) from cancelFlight)
order by 1;


--Identify flight ids which are using “Airbus aircrafts”



SELECT f.flight_id, a.model
FROM flights f 
join aircrafts a 
on f.aircraft_code = a.aircraft_code 
WHERE a.model LIKE 'Airbus%';


--Identify date-wise last flight id flying from every airport?


select flight_id, flight_no,to_char(scheduled_departure,'yyyy-mm-dd') AS Scheduled_departure,departure_airport
from flights as f 
group by 1,2,3,4
order by 3 asc;



--Identify list of customers who will get the refund due to cancellation of the flights and how much amount they will get?


 SELECT t.passenger_name, tf.amount AS total_refund
FROM flights f
join ticket_flights tf 
on f.flight_id = tf.flight_id 
JOIN tickets t
on t.ticket_no = tf.ticket_no
where status = 'Cancelled' or actual_departure is null
group by 1,2;



--Identify date wise first cancelled flight id flying for every airport?


select flight_id, flight_no,to_char(scheduled_departure,'yyyy-mm-dd') AS Scheduled_departure,departure_airport
from flights as f 
where status = 'Canceled' or actual_departure is null
group by 1,2,3,4
order by 3 asc;

--Identify list of Airbus flight ids which got cancelled.

select f.flight_id from flights f
join aircrafts a 
on f.aircraft_code = a.aircraft_code
where a.model like '%Airbus%' and (status = 'Cancelled' or actual_departure is null);

--Identify list of flight ids having highest range.


select f.flight_no, range from flights f
join aircrafts a 
on f.aircraft_code = a.aircraft_code
group by 1,2
order by 2 desc;





