-- Now Its Time To polluting our database with data.
USE Pharmaceutical;

-- 1. First Ill Add some Type of medicine

INSERT INTO type_tbl ([type_name]) 
VALUES ('Antibiotic'), ('Painkiller'), ('Antidepressant'), ('Antiviral'), ('Antihistamine'), ('Diuretic');


--------------------------------------------------------------

-- 2. Now Ill Add 2-3 Drug For each type of medicine that I added.
INSERT INTO drug_tbl (drug_genericName, [type_id]) VALUES 
-- Antibiotics
('Amoxicillin', 1), ('Ciprofloxacin', 1), ('Doxycycline', 1), 
-- Painkillers
('Ibuprofen', 2), ('Acetaminophen', 2), ('Naproxen', 2), 
-- Antidepressants
('Sertraline', 3), ('Fluoxetine', 3), ('Citalopram', 3), 
-- Antivirals
('Acyclovir', 4), ('Oseltamivir', 4), ('Ribavirin', 4), 
-- Antihistamines
('Loratadine', 5), ('Cetirizine', 5), ('Diphenhydramine', 5), 
-- Diuretics
('Furosemide', 6), ('Hydrochlorothiazide', 6), ('Spironolactone', 6);


--------------------------------------------------------------
-- 3. Now I'll Insert Some Countries 
INSERT INTO country_tbl (country_name) VALUES 
('USA'), ('Germany'), ('India'), ('Canada'), ('Iran'), ('France'), ('China'), ('Japan'), ('Australia');


--------------------------------------------------------------
-- 4. Now I'll Insert companies data. NOTE: All Countries Dont have Pharmaceutical company.
INSERT INTO company_tbl (company_name, country_id) VALUES 
-- USA
('Pfizer',1000), ('Johnson & Johnson',1000), ('AbbVie',1000),
-- Germany
('Bayer',1001), ('Merck KGaA',1001),
-- Canada
('Apotex',1003),
--China
('Shanghai Pharmaceuticals',1006),
-- Australia
('CSL Limited',1008), ('Mayne Pharma',1008),
-- Japan
('Takeda Pharmaceutical',1007),
-- France
('Sanofi', 1005), ('Servier', 1005);


--------------------------------------------------------------
-- 5. Now Its Time to Add the drug To each Company with Different drug and price.
INSERT INTO commercial_tbl (commercial_name, company_id, drug_id, commercial_price) VALUES 
-- Pfizer (USA)
('Amoxicillin Pfizer', 100, 10, 15.99),
('Ibuprofen Pfizer', 100, 13, 9.99),
('Sertraline Pfizer', 100, 16, 24.99),
('Acyclovir Pfizer', 100, 19, 19.99),
('Loratadine Pfizer', 100, 22, 12.99),

-- Johnson & Johnson (USA)
('Ciprofloxacin J&J', 101, 11, 18.49),
('Acetaminophen J&J', 101, 14, 11.49),
('Fluoxetine J&J', 101, 17, 21.99),
('Oseltamivir J&J', 101, 20, 29.99),
('Cetirizine J&J', 101, 23, 14.99),

-- AbbVie (USA) - fewer drugs but higher prices
('Doxycycline AbbVie', 102, 12, 22.99),
('Naproxen AbbVie', 102, 15, 14.99),
('Citalopram AbbVie', 102, 18, 26.99),

-- Bayer (Germany) - only specific drugs
('Ibuprofen Bayer', 103, 13, 10.49),
('Acyclovir Bayer', 103, 19, 20.99),

-- Merck KGaA (Germany) - specializes in antidepressants
('Sertraline Merck', 104, 16, 23.99),
('Fluoxetine Merck', 104, 17, 20.99),
('Citalopram Merck', 104, 18, 22.49),

-- Apotex (Canada) - generic but cheap
('Amoxicillin Apotex', 105, 10, 13.99),
('Ibuprofen Apotex', 105, 13, 8.49),
('Loratadine Apotex', 105, 22, 10.99),

-- Shanghai Pharmaceuticals (China) - variety but lower pricing
('Doxycycline Shanghai', 106, 12, 18.99),
('Acetaminophen Shanghai', 106, 14, 10.99),
('Oseltamivir Shanghai', 106, 20, 27.99),
('Furosemide Shanghai', 106, 25, 17.99),

-- CSL Limited (Australia) - exclusive high-end drugs
('Diphenhydramine CSL', 107, 24, 30.99),
('Furosemide CSL', 107, 25, 28.99),

-- Mayne Pharma (Australia) - common drugs but competitive pricing
('Ibuprofen Mayne', 108, 13, 9.49),
('Ribavirin Mayne', 108, 21, 11.99),

-- Takeda Pharmaceutical (Japan) - specialized
('Ribavirin Takeda', 109, 21, 32.99),
('Furosemide Takeda', 109, 25, 18.49),

-- Sanofi (France)
('Sanofi Amoxicillin', 110, 10, 12.50),
('Sanofi Ibuprofen', 110, 13, 8.99),     
('Sanofi Sertraline', 110, 16, 22.75),   
('Sanofi Acyclovir', 110, 19, 15.30),    
('Sanofi Furosemide', 110, 25, 10.50),

-- Servier (France)
('Servier Amoxicillin', 111, 10, 14.20),
('Servier Naproxen', 111, 15, 9.50),      
('Servier Fluoxetine', 111, 17, 20.00),   
('Servier Loratadine', 111, 22, 7.80),    
('Servier Spironolactone', 111, 27, 12.99); 



--------------------------------------------------------------
-- 6. Now Lets Make 5 insurence companies.
INSERT INTO insurance_tbl (insureance_name) VALUES 
('UnitedHealthcare'), ('Allianz'), ('ICICI Lombard'), ('Manulife Financial'), ('AXA');


--------------------------------------------------------------
-- 7. Now its time to add prescription(an insurence company have +100)
DECLARE @randomDate DATE; -- Create A Random Date Variable to later be assign From 2020 to 2025 for the Prescriptions Date
DECLARE @randomInsurenceID int; -- Crete A Variable For The InsurenceId

-- NOW I want to add enough data to have one insurence company to have +100 prescriptions
DECLARE @LargersInsurence int = 0 -- ONE TIME ASSIGNMENT JUST TO ENTER THE WHILE LOOP.

-- Now its Time for looping and adding random data.

WHILE @LargersInsurence < 110 -- Check to See If the Largest insurence company have how many insurence
BEGIN
	SELECT @randomDate = DATEADD(DAY, (ABS(CHECKSUM(NEWID())) % (DATEDIFF(DAY, '2020-01-01', '2025-01-01'))) , '2020-01-01'); -- Assign Random DATE to the Variable
	SELECT @randomInsurenceID = insureance_id FROM insurance_tbl ORDER BY NEWID(); -- Assign Random Insurence ID to the variable


	WITH CTE_Pre AS(
		SELECT drug_tbl.drug_genericName + ' Prescription' AS 'prescription_name', type_tbl.[type_name] AS 'prescription_family' FROM drug_tbl
		JOIN type_tbl ON drug_tbl.[type_id] = type_tbl.[type_id])
		INSERT INTO prescription_tbl (prescription_name, prescription_family, prescription_date, insureance_id)
		SELECT TOP 1 *, @randomDate AS 'prescription_date', @randomInsurenceID AS 'insureance_id' FROM CTE_Pre ORDER BY NEWID();


	SELECT TOP 1 @LargersInsurence = COUNT(*) FROM prescription_tbl
	GROUP BY insureance_id
	ORDER BY COUNT(*) DESC;
END


--------------------------------------------------------------
-- 8. Now it time to pollute the orders table
DECLARE @adder int
DECLARE @random_number int

SELECT @adder = COUNT(*) FROM prescription_tbl 
SET @adder += 350 --To Fetch All Prescription and 350 more

WHILE @adder > 0
BEGIN
	SELECT @random_number = ABS(CHECKSUM(NEWID())) % 100 + 1; -- Generate Random Number For Order Mesure

	INSERT INTO order_tbl (prescription_id, commercial_id, order_mesure)
	SELECT (SELECT TOP 1 prescription_id ID FROM prescription_tbl  ORDER BY NEWID()) AS 'prescription_id',
	(SELECT TOP 1 commercial_id ID2 FROM commercial_tbl ORDER BY NEWID()) AS 'commercial_id',
	(SELECT ABS(CHECKSUM(NEWID())) % 100 + 1) AS 'order_mesure';

	SET @adder -= 1

END