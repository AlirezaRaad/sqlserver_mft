USE Pharmaceutical

-- 1st Question: Prescription With drug which has been made in France

-- First Let me Fetch France CountryID.
DECLARE @FranceID int
SELECT @FranceID = country_id FROM country_tbl WHERE country_name = 'France'

SELECT COUNT(*) AS 'Prescription Count' FROM prescription_tbl Pre JOIN order_tbl Ord ON Ord.prescription_id = Pre.prescription_id 
JOIN commercial_tbl Comm ON Comm.commercial_id = Ord.commercial_id JOIN company_tbl Comp ON Comp.company_id = Comm.company_id
WHERE Comp.country_id = @FranceID


----------------------------------------------------------
-- 2nd Question: Insurence Company which had the most Prescription in the past last year.
WITH CTE AS (
	SELECT insurance_tbl.insureance_name ,COUNT(*) AS 'NumberOfPrescription' FROM prescription_tbl
	JOIN insurance_tbl ON prescription_tbl.insureance_id = insurance_tbl.insureance_id
	WHERE prescription_date between DATEADD(YEAR, -1, GETDATE()) AND GETDATE()
	GROUP BY insurance_tbl.insureance_name
)
SELECT * FROM CTE
WHERE NumberOfPrescription > 100


----------------------------------------------------------
-- 3rd Question: Make a Function Or SP to get companyID and return the most expensive drug of the chosen company.
CREATE PROCEDURE sp_MostExpensiveDrug_Company(@companyID int)
AS BEGIN
SELECT TOP 1 Drg.drug_genericName AS 'Most Expensive Drug' FROM commercial_tbl Comm JOIN drug_tbl Drg ON Comm.drug_id = Drg.drug_id
WHERE company_id = @companyID
ORDER BY Comm.commercial_price DESC
END

EXEC sp_MostExpensiveDrug_Company 100


----------------------------------------------------------
-- 4th Question: The Most Expensive drug in each type.
WITH CTE AS(
SELECT DENSE_RANK() OVER (PARTITION BY Drg.[type_id] ORDER BY Comm.commercial_price DESC) AS 'DrugRank', Comm.commercial_name, type_tbl.[type_name]
FROM commercial_tbl Comm 
JOIN drug_tbl Drg ON Comm.drug_id = Drg.drug_id JOIN type_tbl ON type_tbl.[type_id] = Drg.[type_id]
)
SELECT [type_name],commercial_name AS 'Drug Name' FROM CTE
WHERE DrugRank = 1

----------------------------------------------------------
-- 5th Question: Increse The Price of drug by 3% withoud changing the acuall data. Then show just drug name and changed price.
CREATE FUNCTION XpercentIncreaceInPrice (@number float, @percent float)
RETURNS float
AS BEGIN
	RETURN @number * (1 + @percent/100)
END;

SELECT Comm.commercial_name, dbo.XpercentIncreaceInPrice(Comm.commercial_price, 3) 'Increased Price' FROM commercial_tbl Comm
