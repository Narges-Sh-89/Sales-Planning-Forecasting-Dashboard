/*
===============================================================================
DDL Script: Create Silver Layer Tables
===============================================================================
Script Purpose:
    This script creates the required tables in the 'silver' schema.

    The Silver layer stores cleaned and standardized data transformed from the
    Bronze layer. It provides structured and consistent datasets that are
    prepared for analytical processing and downstream modeling.

    Data stored in this layer maintains the business meaning of the source data
    while applying necessary data type standardization and data quality rules.

    This script drops existing Silver tables if they already exist and recreates
    them with the required schema and column definitions.

    Run this script to initialize or refresh the Silver layer table structure.
===============================================================================
*/



-- Creating  Silver.Dim_Store Table

IF OBJECT_ID ('Silver.Dim_Store', 'U') IS NOT NULL
	DROP TABLE Silver.Dim_Store;
GO

CREATE TABLE Silver.Dim_Store (
    
    Store SMALLINT NOT NULL,
    StoreType VARCHAR(10), 
    Assortment VARCHAR(20), 
    CompetitionDistance INT, 
    CompetitionOpenSinceMonth TINYINT, 
    CompetitionOpenSinceYear SMALLINT, 
    Promo2 BIT,
    Promo2SinceWeek TINYINT,
    Promo2SinceYear SMALLINT, 
    PromoInterval VARCHAR(50),
    dwh_createDate DATETIME2 DEFAULT SYSDATETIME(),

    CONSTRAINT PK_Dim_Store PRIMARY KEY (Store)
) ;


-- Creating  Silver.Fact_Sales Table


IF OBJECT_ID ('Silver.Fact_Sales', 'U') IS NOT NULL
	DROP TABLE Silver.Fact_Sales;
GO

CREATE TABLE Silver.Fact_Sales(

    Store SMALLINT NOT NULL, 
    DayOfWeekNum TINYINT, 
    SalesDate DATE, 
    Sales DECIMAL(12,2) NOT NULL,
    Customers SMALLINT NOT NULL, 
    IsOpen BIT NOT NULL, 
    Promo BIT NOT NULL, 
    StateHoliday VARCHAR(30), 
    SchoolHoliday BIT NOT NULL, 
    dwh_createDate DATETIME2 DEFAULT SYSDATETIME(),

CONSTRAINT PK_Fact_Sales PRIMARY KEY (Store, SalesDate)
);
