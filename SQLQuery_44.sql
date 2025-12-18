create database SQLHANDSONS
Use SQLHANDSONS

  select * from J1 

 SELECT * FROM J1;
SELECT TOP 5 * FROM J1;


 CREATE PROCEDURE sp_TableBookingRestaurants
AS
BEGIN
    SELECT *
    FROM J1;
END;
GO

 EXEC sp_help J1;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Jomato';

USE master;
GO

CREATE PROCEDURE sp_TableBookingRestaurants
AS
BEGIN
    SELECT 
        RestaurantName,
        RestaurantType,
        CuisinesType
    FROM J1
    WHERE TableBooking = 'Yes';
END;
GO


EXEC sp_TableBookingRestaurants;


--Q1. Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.                                                                 
 
CREATE OR ALTER PROCEDURE sp_TableBookingRestaurants
AS
BEGIN
    SELECT 
        RestaurantName,
        RestaurantType,
        CuisinesType
    FROM dbo.J1
    WHERE TableBooking = 'Yes';
END;

EXEC sp_TableBookingRestaurants;




--Q2.2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.                                       
 
BEGIN TRANSACTION;

UPDATE J1
SET CuisinesType = 'Cafeteria'
WHERE CuisinesType LIKE '%Cafe%';

SELECT RestaurantName, CuisinesType
FROM J1
WHERE CuisinesType LIKE '%Cafeteria%';

ROLLBACK;



--Q3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.                      
 
SELECT *
FROM (
    SELECT 
        Area,
        Rating,
        ROW_NUMBER() OVER (ORDER BY Rating DESC) AS RowNum
    FROM J1
) t
WHERE RowNum <= 5;



--Q4. Use the while loop to display the 1 to 50.


DECLARE @i INT = 1;

WHILE @i <= 50
BEGIN
    PRINT @i;
    SET @i = @i + 1;
END;



--Q5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants.                                                    
 
CREATE VIEW TopRatingRestaurants
AS
SELECT TOP 5
    RestaurantName,
    Area,
    Rating
FROM J1
ORDER BY Rating DESC;

SELECT * FROM TopRatingRestaurants;


--Q6. Create a trigger that give an message whenever a new record is inserted.
CREATE TRIGGER trg_InsertMessage
ON J1
AFTER INSERT
AS
BEGIN
    PRINT 'New restaurant record inserted successfully';
END;

INSERT INTO dbo.J1
(RestaurantName, RestaurantType, Rating, No_of_Rating, AverageCost, OnlineOrder, TableBooking, CuisinesType, Area, LocalAddress, Delivery_time)
VALUES
('Test Trigger Cafe', 'Cafe', 4.2, 50, 300, 'Yes', 'Yes', 'Cafe', 'Test Area', 'Test Address', 30);
