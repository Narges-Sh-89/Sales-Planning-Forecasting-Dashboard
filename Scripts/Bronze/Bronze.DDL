
/*
===============================================================================
DDL Script: Create Bronze Layer Tables
===============================================================================
Script Purpose:
    This script creates the required tables in the 'bronze' schema to store 
    raw source data.

    The data pipeline follows a staged ingestion approach where source data is 
    initially prepared in staging tables before being persisted into the 
    Bronze layer tables.

    The Bronze layer preserves the original source structure and provides a 
    reliable foundation for downstream data transformation and analytics 
    processes.

    This script drops existing Bronze tables if they already exist and 
    recreates them with the required schema and column definitions.

    Run this script to initialize or refresh the Bronze layer table structure.
===============================================================================
*/

-- =================================
-- CREATING 'STORE' DOMAIN
-- =================================

-- Creating  Bronze.Stage_Store Table

IF OBJECT_ID('Bronze.Stage_Store','U') IS NOT NULL
    DROP TABLE Bronze.Stage_Store;
GO



CREATE TABLE Bronze.Stage_Store (
    Store NVARCHAR(50),
    StoreType NVARCHAR(10),
    Assortment NVARCHAR(10),
    CompetitionDistance NVARCHAR(50),
    CompetitionOpenSinceMonth NVARCHAR(10),
    CompetitionOpenSinceYear NVARCHAR(10),
    Promo2 NVARCHAR(10),
    Promo2SinceWeek NVARCHAR(10),
    Promo2SinceYear NVARCHAR(10),
    PromoInterval NVARCHAR(50)
);

-- Creating  Table Bronze.Store

IF OBJECT_ID ('Bronze.Store', 'U') IS NOT NULL
	DROP TABLE Bronze.Store;
GO

CREATE TABLE Bronze.Store (
Store SMALLINT,
StoreType CHAR(1), 
Assortment CHAR(1), 
CompetitionDistance INT, 
CompetitionOpenSinceMonth TINYINT, 
CompetitionOpenSinceYear SMALLINT, 
Promo2 BIT,
Promo2SinceWeek TINYINT,
Promo2SinceYear SMALLINT, 
PromoInterval VARCHAR(50)
) ;




-- =================================
-- CREATING 'TRAIN' DOMAIN
-- =================================

-- Creating  Bronze.Stage_Train Table

IF OBJECT_ID('Bronze.Stage_Train','U') IS NOT NULL
    DROP TABLE Bronze.Stage_Train;
GO



CREATE TABLE Bronze.Stage_Train (
    Store NVARCHAR(50),
    DayOfWeek NVARCHAR(10),
    SalesDate NVARCHAR(50),
    Sales NVARCHAR(50),
    Customers NVARCHAR(50),
    IsOpen NVARCHAR(10),
    Promo NVARCHAR(10),
    StateHoliday NVARCHAR(10),
    SchoolHoliday NVARCHAR(10)
);

-- Creating Table Bronze.Train

IF OBJECT_ID ('Bronze.Train', 'U') IS NOT NULL
	DROP TABLE Bronze.Train;
GO

CREATE TABLE Bronze.Train(

Store SMALLINT, 
DayofWeekNum TINYINT, 
SalesDate DATE, 
Sales DECIMAL(12,2),
Customers SMALLINT, 
IsOpen BIT, 
Promo BIT, 
StateHoliday CHAR(1), 
SchoolHoliday BIT
);
