/*
===============================================================================
DDL Script: Create Gold Layer Tables (Storer- Sales)
===============================================================================
Script Purpose:
    This script creates the business-ready tables in the Gold layer.

    The Gold layer is designed for analytical reporting and BI consumption.
    Data in this layer is sourced from the Silver layer, where data cleaning,
    validation, and standardization have already been completed.

    This script creates:

    1. Gold.Dim_Store:
       - Stores descriptive information about stores.
       - Supports store-level analysis and segmentation.
       - The Store column is used as the primary key because each store
         represents a unique business entity.

    2. Gold.Fact_Sales:
       - Stores daily sales transactions.
       - Supports KPI calculation, sales analysis, and forecasting scenarios.
       - The composite key (Store, SalesDate) is used as the primary key because
         each store has one sales record per day.

    Both tables preserve natural business keys to maintain a simple and
    understandable star schema design.

    The dwh_createDate column is maintained as metadata to support future ETL
    monitoring and incremental loading strategies.

    This script drops existing Gold tables if they already exist and recreates
    them with the required structure.

===============================================================================
*/


-- =====================================================
-- Create Gold.Dim_Store
-- =====================================================

IF OBJECT_ID('Gold.Dim_Store', 'U') IS NOT NULL
    DROP TABLE Gold.Dim_Store;
GO


CREATE TABLE Gold.Dim_Store (

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

    CONSTRAINT PK_Gold_Dim_Store PRIMARY KEY (Store)

);


-- =====================================================
-- Create Gold.Fact_Sales
-- =====================================================

IF OBJECT_ID('Gold.Fact_Sales', 'U') IS NOT NULL
    DROP TABLE Gold.Fact_Sales;
GO


CREATE TABLE Gold.Fact_Sales (

    Store SMALLINT NOT NULL,

    DayOfWeekNum TINYINT,

    SalesDate DATE NOT NULL,

    Sales DECIMAL(12,2) NOT NULL,

    Customers SMALLINT NOT NULL,

    IsOpen BIT,

    Promo BIT,

    StateHoliday VARCHAR(30),

    SchoolHoliday BIT,

    dwh_createDate DATETIME2 DEFAULT SYSDATETIME(),


    CONSTRAINT PK_Gold_Fact_Sales 
    PRIMARY KEY (Store, SalesDate)

);
