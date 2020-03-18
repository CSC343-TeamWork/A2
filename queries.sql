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
WHERE DateOfBirth <= "1954-11-14";

-- ++++++++++++++++++++
--  Q2
-- ++++++++++++++++++++

SELECT COUNT(*) AS "Taken"
FROM Take
WHERE "2019-09-04" = Date AND ShipID IN (SELECT ShipID
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
													    FROM Ship)));  
-- ++++++++++++++++++++
--  Q3.C
-- ++++++++++++++++++++
SELECT RouteId, SUM(AdvertisingRevenue) AS "Total Revenue"
FROM Ship, Route, Run 
WHERE Ship.ShipID = Run.ShipID AND Route.RouteID = Run.RouteID
GROUP BY Route.RouteID;
-- ++++++++++++++++++++
--  Q4.A
-- ++++++++++++++++++++

SELECT Passenger.Type, SUM(Fare.Fee) AS revenue
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

SELECT REV.Type AS Type, MAX(revenue) AS revenue
FROM (SELECT Passenger.Type AS Type ,SUM(Fare.Fee) AS revenue
      FROM Passenger, Fare
      WHERE Passenger.Type = Fare.Type AND Passenger.SIN IN (SELECT SIN FROM Take WHERE Take.Date = "2019-09-01" )
      GROUP BY Passenger.Type) REV ;
    
-- ++++++++++++++++++++
--  Q5.A
-- ++++++++++++++++++++

SELECT pilot.SIN, FirstName, LastName, FLOOR(datediff("2019-11-04 12:00:00", DateOfBirth)/365) AS "Age"
FROM person, pilot
WHERE person.SIN = pilot.SIN AND pilot.SIN IN (SELECT SIN
					       FROM infraction
					       GROUP BY SIN
					       HAVING COUNT(*) < 3) ;


-- ++++++++++++++++++++
--  Q5.B
-- ++++++++++++++++++++

SELECT SIN, SUM(Demerit) AS TotalDemerit, SUM(Fine) AS TotalFine
FROM infraction
GROUP BY SIN
HAVING TotalDemerit > 2
ORDER BY TotalDemerit DESC ;
-- ++++++++++++++++++++
--  Q6.A
-- ++++++++++++++++++++

SELECT ShipID, Manufacturer
FROM Ship
GROUP BY Manufacturer
HAVING COUNT(ShipID) = 1 ;
-- ++++++++++++++++++++
--  Q6.B
-- ++++++++++++++++++++


SELECT Run.RouteID, numofpass.total
FROM (SELECT ShipID, COUNT(SIN) AS total 
      FROM Take
      GROUP BY ShipID) numofpass, Run
WHERE Run.ShipID = numofpass.ShipID AND numofpass.total =  (SELECT MAX(numofpass.total)
							    FROM (SELECT ShipID, COUNT(SIN) AS total 
								  FROM Take
		     						  GROUP BY ShipID) Temp);

-- ++++++++++++++++++++
--  Q6.C
-- ++++++++++++++++++++

SELECT pass.Date, MAX(pass.total_pass) AS "trips taken"
FROM (SELECT Take.Date, COUNT(SIN) AS total_pass
      FROM Take
      GROUP BY Take.Date) pass;

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

SELECT FirstName, LastName, Person.SIN
FROM Pilot, Person
WHERE Pilot.SIN = Person.SIN AND YearsOfService > 5 AND Salary > 75000 AND Pilot.SIN IN (SELECT SIN
											 FROM Infraction
											 GROUP BY SIN
											 HAVING SUM(Demerit) < 9);
-- ++++++++++++++++++++
--  Q9
-- ++++++++++++++++++++

SELECT FirstName, LastName, Sex, Number, Person.SIN
FROM Person, Phone
WHERE Person.SIN = Phone.SIN AND Person.SIN IN (SELECT Take.SIN
						FROM Take, Run, Go
						WHERE Take.ShipID = Run.ShipID AND Run.RouteID = 4);

-- ++++++++++++++++++++
--  Q10
-- ++++++++++++++++++++

-- Your code goes here (replace this line with your query)

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- END
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
