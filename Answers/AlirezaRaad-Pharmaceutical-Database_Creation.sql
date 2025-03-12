--Creating DataBase And Switch On it.
--DROP DATABASE Pharmaceutical
CREATE DATABASE Pharmaceutical;
GO
USE Pharmaceutical;
------------First Step-----------------------
-- First I will make all the tables WITHOUT any relations.

CREATE TABLE type_tbl ([type_id] int PRIMARY KEY IDENTITY(1,1), [type_name] nvarchar(MAX) NOT NULL);

CREATE TABLE drug_tbl (drug_id int PRIMARY KEY IDENTITY(10,1), drug_genericName nvarchar(MAX) NOT NULL, [type_id] int);

CREATE TABLE country_tbl (country_id int PRIMARY KEY IDENTITY(1000,1), country_name nvarchar(50));

CREATE TABLE order_tbl (order_id int PRIMARY KEY IDENTITY(1000,1), prescription_id int, 
						commercial_id int, order_mesure int);

CREATE TABLE commercial_tbl (commercial_id int PRIMARY KEY IDENTITY(1000,1), commercial_name nvarchar(100), 
							company_id int, drug_id int, commercial_price money);

CREATE TABLE company_tbl (company_id int PRIMARY KEY IDENTITY(100,1), company_name nvarchar(100), country_id int);

CREATE TABLE prescription_tbl (prescription_id int PRIMARY KEY IDENTITY(10,1), prescription_name nvarchar(100),
			prescription_family nvarchar(20), prescription_date datetime, insureance_id int);

CREATE TABLE insurance_tbl (insureance_id int PRIMARY KEY IDENTITY(10,1), insureance_name nvarchar(25));

------------Second Step-----------------------
-- Now I give the table the desired relations.

ALTER TABLE drug_tbl ADD CONSTRAINT FK_Drug_Type FOREIGN KEY ([type_id]) REFERENCES type_tbl([type_id]);

ALTER TABLE commercial_tbl ADD CONSTRAINT FK_Commercial_Drug FOREIGN KEY (drug_id) REFERENCES drug_tbl(drug_id);

ALTER TABLE commercial_tbl ADD CONSTRAINT FK_Commercial_company FOREIGN KEY (company_id) REFERENCES company_tbl(company_id);

ALTER TABLE company_tbl ADD CONSTRAINT FK_Company_Country FOREIGN KEY (country_id) REFERENCES country_tbl(country_id);

ALTER TABLE order_tbl ADD CONSTRAINT FK_Order_Commercial FOREIGN KEY (commercial_id) REFERENCES commercial_tbl(commercial_id);

ALTER TABLE order_tbl ADD CONSTRAINT FK_Order_prescription_tbl FOREIGN KEY (prescription_id) REFERENCES prescription_tbl(prescription_id);

ALTER TABLE prescription_tbl ADD CONSTRAINT FK_prescription_insurence FOREIGN KEY (insureance_id) REFERENCES insurance_tbl(insureance_id);


