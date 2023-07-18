
CREATE DATABASE airline_db;


USE airline_db;

--
-- Table structure for table `airline_bookings`
--

CREATE TABLE `airline_bookings` (
  `book_ref` varchar(255) DEFAULT NULL,
  `book_date` varchar(255) DEFAULT NULL,
  `total_amount` int DEFAULT NULL
);


--
-- Table structure for table `airline_tickets`
--
CREATE TABLE `airline_tickets` (
  `ticket_number` int DEFAULT NULL,
  `book_ref` varchar(255) DEFAULT NULL,
  `pasenger_id` int DEFAULT NULL,
  `pasenger_name` varchar(255) DEFAULT NULL,
  `contact_data` varchar(255) DEFAULT NULL,
 CONSTRAINT `airline_booking_tickets_f1_idx` FOREIGN KEY (`book_ref`) REFERENCES `airline_bookings` (`book_ref`)
);

--
-- Table structure for table `airline_flights`
--

CREATE TABLE `airline_flights` (
  `flight_id` int NOT NULL,
  `flight_no` varchar(255) DEFAULT NULL,
  `scheduled_departure` varchar(255) DEFAULT NULL,
  `scheduled_arrival` varchar(255) DEFAULT NULL,
  `departure_airport` varchar(255) DEFAULT NULL,
  `arrival_airport` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `aircraft_code` varchar(255) DEFAULT NULL,
  `actual_departure` varchar(255) DEFAULT NULL,
  `actual_arrival` varchar(255) DEFAULT NULL,
  CONSTRAINT `airline_aircrafts_flight_f1_idx` FOREIGN KEY (`aircraft_code`) REFERENCES `airline_aircrafts` (`aircraft_code`)
);


--
-- Table structure for table `airline_ticket_flights`
--

CREATE TABLE `airline_ticket_flights` (
  `ticket_number` int DEFAULT NULL,
  `flight_id` int DEFAULT NULL,
  `fare_conditions` varchar(45) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  CONSTRAINT `airline_tickets_flights_f1_idx` FOREIGN KEY (`ticket_number`) REFERENCES `airline_tickets` (`ticket_number`),
  CONSTRAINT `airline_flights_f2_idx` FOREIGN KEY (`flight_id`) REFERENCES `airline_flights` (`flight_id`)
);

--
-- Table structure for table `airline_boarding_passes`
--
CREATE TABLE `airline_boarding_passes` (
  `ticket_number` int DEFAULT NULL,
  `flight_id` int DEFAULT NULL,
  `boarding_no` int DEFAULT NULL,
  `seat_no` varchar(45) DEFAULT NULL,
  CONSTRAINT `airline_tickets_flights_f1_idx` FOREIGN KEY (`ticket_number`) REFERENCES `airline_tickets` (`ticket_number`),
  CONSTRAINT `airline_flights_f2_idx` FOREIGN KEY (`flight_id`) REFERENCES `airline_flights` (`flight_id`)
) ;

--
-- Table structure for table `airline_bookings`
--

CREATE TABLE `airline_bookings` (
  `airport_code` varchar(255) NOT NULL,
  `airport_name` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `coordinates` varchar(255) DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`airport_code`)
) ;


--
-- Table structure for table `airline_aircrafts`
--
CREATE TABLE `airline_aircrafts` (
  `aircraft_code` varchar(255)  NOT NULL,
  `model` varchar(255) DEFAULT NULL,
  `range` bigint DEFAULT NULL,
  PRIMARY KEY (`aircraft_code`)
);


--
-- Table structure for table `airline_seats`
-- 

CREATE TABLE `airline_seats` (
  `aircraft_code` int NOT NULL,
  `seat_no` varchar(45) DEFAULT NULL,
  `fare_conditions` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`seat_no`),
   CONSTRAINT `airline_aircrafts_seats_f1_idx` FOREIGN KEY (`aircraft_code`) REFERENCES `airline_aircrafts` (`aircraft_code`)
) ;





