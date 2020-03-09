-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- CSC 343: Group Assignment 2
-- Winter 2020 | UTM
-- SKELETON FILE FOR PART I: SQL
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- ***** DO NOT CHANGE THE FORMAT *****
-- ***** YOU MAY ONLY ADD WHERE *****
-- *****  IT INDICATES TO DO SO *****

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- PREAMBLE
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Parter 1's Name: Mohamed Issa
-- Partner 1's Student Number: 1003489691
-- Partner 1's UtorID: issamoh2

-- Parter 2's Name: [insert name]
-- Partner 2's Student Number: [insert student number]
-- Partner 2's UtorID: [insert University of Toronto Identifier]

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- BEGIN
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- ++++++++++++++++++++
--  Q1
-- ++++++++++++++++++++

SELECT COUNT(*) AS "TotalSeniors"
FROM Person
WHERE date(DateOfBirth) <= "1954-11-14";

-- ++++++++++++++++++++
--  Q2
-- ++++++++++++++++++++

SELECT COUNT(*) AS "Taken"
FROM Take
WHERE date("2019-9-4") = date(Date) AND ShipID IN (SELECT ShipID
		 			FROM Run
		 			WHERE RouteID = 1);
					
-- ++++++++++++++++++++
--  Q3.A
-- ++++++++++++++++++++

SELECT ShipID, Age, Manufacturer 
FROM Ship
WHERE AdvertisingRevenue > 10000;

-- ++++++++++++++++++++
--  Q3.B
-- ++++++++++++++++++++
SELECT FirstName, LastName, YearsOfService, ShipID
FROM Pilot, Person, Ship
WHERE Pilot.SIN = Person.SIN AND (Person.SIN, Ship.ShipID) IN (SELECT *
				                               FROM Operate
							       WHERE ShipID IN (SELECT ShipID 
							       			FROM Ship
							       		   	WHERE AdvertisingRevenue = (SELECT MAX(AdvertisingRevenue) 
																											                                                      FROM Ship)))  
-- ++++++++++++++++++++
--  Q3.C
-- ++++++++++++++++++++

SELECT *
FROM Ship, (SELECT RouteId, SUM(AdvertisingRevenue)
            FROM Ship, Route, Run 
            WHERE Ship.ShipID = Run.ShipID AND Route.RouteID = Run.RouteID
            GROUP BY Route.RouteID) revenues;
-- ++++++++++++++++++++
--  Q4.A
-- ++++++++++++++++++++

SELECT Passenger.Type ,SUM(Fare.Fee) AS revenue
FROM Passenger, Fare
WHERE Passenger.Type = Fare.Type
GROUP BY Passenger.Type;
-- ++++++++++++++++++++
--  Q4.B
-- ++++++++++++++++++++

SELECT Passenger.Type ,SUM(Fare.Fee) AS revenue
FROM Passenger, Fare
WHERE Passenger.Type = Fare.Type
GROUP BY Passenger.Type
HAVING revenue > 500;

-- ++++++++++++++++++++
--  Q4.C
-- ++++++++++++++++++++

SELECT MAX(revenue)
FROM (SELECT Passenger.Type ,SUM(Fare.Fee) AS revenue
	  FROM Passenger, Fare
	  WHERE Passenger.Type = Fare.Type AND Passenger.SIN IN (SELECT SIN FROM Take WHERE date(Take.Date) = date("2019-9-1") )
	  GROUP BY Passenger.Type) REV ;
    
-- ++++++++++++++++++++
--  Q5.A
-- ++++++++++++++++++++

-- Your code goes here (replace this line with your query)

-- ++++++++++++++++++++
--  Q5.B
-- ++++++++++++++++++++

-- Your code goes here (replace this line with your query)

-- ++++++++++++++++++++
--  Q6.A
-- ++++++++++++++++++++

-- Your code goes here (replace this line with your query)

-- ++++++++++++++++++++
--  Q6.B
-- ++++++++++++++++++++

-- Your code goes here (replace this line with your query)

-- ++++++++++++++++++++
--  Q6.C
-- ++++++++++++++++++++

-- Your code goes here (replace this line with your query)

-- ++++++++++++++++++++
--  Q7.A
-- ++++++++++++++++++++

-- Your code goes here (replace this line with your query)

-- ++++++++++++++++++++
--  Q7.B
-- ++++++++++++++++++++

-- Your code goes here (replace this line with your query)

-- ++++++++++++++++++++
--  Q8
-- ++++++++++++++++++++

-- Your code goes here (replace this line with your query)

-- ++++++++++++++++++++
--  Q9
-- ++++++++++++++++++++

-- Your code goes here (replace this line with your query)

-- ++++++++++++++++++++
--  Q10
-- ++++++++++++++++++++

-- Your code goes here (replace this line with your query)

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- END
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
