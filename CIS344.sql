CREATE DATABASE restaurant_reservations;

CREATE TABLE Customers (
	customerId INT NOT NULL UNIQUE AUTO_INCREMENT,
    customerName VARCHAR(45) NOT NULL,
    contactInfo VARCHAR(200),
    PRIMARY KEY (customerId)
);

INSERT INTO Customers (customerName, contactInfo) VALUES
	("Edwardo", "646-123-4567"),
    ("Alex", "test@gmail.com"),
    ("Noel", "347-123-4567");
    
    select * from Customers;

CREATE TABLE Reservations (
	reservationId INT NOT NULL UNIQUE AUTO_INCREMENT,
	customerId INT NOT NULL,
    reservationTime DATETIME NOT NULL,
    numberOfGuests INT NOT NULL,
    specialRequests VARCHAR(200),
    PRIMARY KEY (reservationId),
    FOREIGN KEY (customerId) REFERENCES Customers (customerId)
);

INSERT INTO Reservations (customerId, reservationTime, numberOfGuests, specialRequests) VALUES
	(1, '2024-5-18 08:00:00', 2, "Have roses at the table" ),
    (2, '2024-5-20 05:00:00', 5, "Have a booster seat at the table" ),
    (3, '2024-5-23 07:00:00', 3, "Have a table  by the  window" );

select * from Reservations;

CREATE TABLE DiningPreferences (
	preferenceId INT NOT NULL UNIQUE AUTO_INCREMENT,
	customerId INT NOT NULL,
    favoriteTable VARCHAR(45),
    dietaryRestrictions VARCHAR(200),
    PRIMARY KEY (preferenceId),
	FOREIGN KEY (customerId) REFERENCES Customers (customerId)
);

INSERT INTO DiningPreferences (customerId, favoriteTable, dietaryRestrictions) VALUES
	(1, "regualer  table", "none"),
    (2, "regualer  table", "peanut butter"),
    (3, "window  table", "none");

select * from DiningPreferences;

DELIMITER $$
CREATE PROCEDURE findReservations (IN customer_Id INT)
BEGIN
	SELECT * FROM Reservations WHERE customerId = customer_Id;
END;
DELIMITER;

DELIMITER $$
CREATE PROCEDURE addSpecialRequest(IN reservation_Id INT, IN  newSpecialRequests VARCHAR(200))
BEGIN
	UPDATE Reservations SET specialRequests = newSpecialRequests WHERE reservationId = reservation_Id;
END;
DELIMITER;

DELIMITER $$
CREATE PROCEDURE addReservation(IN customer_Id INT, IN customer_Name VARCHAR(45), IN reservation_Id INT, IN reservation_Time DATETIME, IN number_Of_Guests INT, IN preferenceId INT)
BEGIN
    IF NOT EXISTS (SELECT (customerId + 1) Reservations where customerId = customer_Id) THEN
		INSERT INTO Customers(customerId, customerName)
        VALUES (customer_Id, customer_Name);
        VALUES (reservation_Id, reservation_Time, number_Of_Guests);
        INSERT INTO DiningPreferences (preferenceId, customerId)
        VALUES (preferenceId, customerId);
        
	else
		SELECT "Reservation already made for " + customerName;
    
END;
DELIMITER;