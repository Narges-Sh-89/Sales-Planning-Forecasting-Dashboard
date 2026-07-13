# Rossmann Store Sales Analytics & Forecasting Project

## 🏗️ Data Warehouse Architecture

This project implements a layered Data Warehouse architecture using SQL Server and follows a Medallion approach:

```
Stage → Bronze → Silver → Gold → Power BI
```

Each layer has a specific responsibility to ensure data quality, scalability, and analytical readiness.

---

# 🥉 Stage Layer

The Stage layer is responsible for raw data ingestion from CSV files.

Key characteristics:

* Raw ingestion layer
* All columns stored as `NVARCHAR`
* Designed for schema flexibility and fault-tolerant loading
* Handles inconsistent CSV structures
* Preserves original source data before transformation

---

# 🟤 Bronze Layer

The Bronze layer stores structured raw data after initial ingestion.

Key characteristics:

* Strong data typing applied (`INT`, `BIT`, `DATE`, `DECIMAL`, etc.)
* Basic cleaning and type conversion applied
* Source data preserved in a structured format
* Uses `TRY_CAST` for safe data conversion
* Provides reliable input for downstream transformations

---

# ⚪ Silver Layer

The Silver layer performs data cleaning, validation, and standardization.

Main activities:

* Data quality checks
* Handling missing values
* Removal of invalid records
* Standardization of categorical attributes
* Business rule implementation

Examples:

### Sales Data Cleaning

* Removed records where:

  * Store was open (`IsOpen = 1`)
  * Sales value was zero

* Retained records where:

  * Store was closed (`IsOpen = 0`)
  * Sales value was zero

because these records represent valid non-operational days.

### Standardization Examples

Store attributes:

* Store Type:

  * Type A
  * Type B
  * Type C
  * Type D

Assortment:

* Basic
* Extra
* Extended

Holiday information:

* No Holiday
* Public Holiday
* Easter Holiday
* Christmas Holiday

---

# 🟡 Gold Layer

The Gold layer contains business-ready analytical tables designed for BI reporting.

The final star schema consists of:

```
              Dim_Date
                  |
                  |
Dim_Store ---- Fact_Sales
```

## Dimension Tables

### Dim_Date

Contains calendar attributes:

* Date
* Year
* Quarter
* Month
* ISO Week Number
* Day information
* Weekend indicator

### Dim_Store

Contains store-level information:

* Store type
* Assortment
* Competition information
* Promotion configuration

## Fact Table

### Fact_Sales

Contains daily transactional information:

* Sales
* Customers
* Promotions
* Holiday indicators

Primary key:

```
(Store, SalesDate)
```

---

# 📦 Data Domains

## Store Domain

Contains store-level metadata:

* Store characteristics
* Competition details
* Promotion configuration

## Sales Domain

Contains transactional sales information:

* Daily sales
* Customer count
* Promotion activities
* Holiday effects

---

# ⚙️ ETL Process

The pipeline is implemented using SQL Server Stored Procedures.

Workflow:

1. Load raw CSV files using `BULK INSERT`
2. Store raw data in Stage layer
3. Convert and structure data into Bronze layer
4. Apply cleaning and validation rules in Silver layer
5. Standardize business attributes
6. Load analytical tables into Gold layer
7. Track row counts after each loading step
8. Measure execution time
9. Handle failures using `TRY...CATCH`
10. Maintain re-runnable ETL execution

---

# ETL Challenges & Solutions

## Handling Quoted Values in Source CSV Files

Some source CSV files contained quoted values that caused parsing issues during ingestion.

Solution:

* Raw files were first loaded into staging tables.
* Data was reviewed before transformation.
* Stage layer provided better control over ingestion.

---

## Data Quality Management

Implemented checks for:

* Duplicate records
* Missing key values
* Invalid sales records
* Referential integrity
* Standardized categorical values

---

# 🧹 Data Cleaning & Standardization

Implemented transformations include:

* Removal of unwanted characters
* NULL handling
* Boolean normalization
* Categorical standardization
* Safe data type conversion using `TRY_CAST`
* Business rule enforcement

---

# 📊 Data Quality Validation

The Gold layer was validated before BI consumption.

Validation checks:

### Row Count Validation

Compared Silver and Gold record counts.

### Primary Key Validation

Verified:

* Unique Store records
* Unique `(Store, SalesDate)` combinations

### NULL Validation

Checked critical columns:

* Store
* SalesDate
* Sales
* Customers

### Referential Integrity

Validated:

* Fact Sales → Dim Store
* Fact Sales → Dim Date

### Business Rule Validation

Confirmed:

* No open stores with zero sales
* Closed-store zero sales records correctly retained

---

# 📈 Business Use Cases

The final analytical dataset enables:

* Sales performance analysis
* Store benchmarking
* Promotion effectiveness analysis
* Holiday impact analysis
* Time-based trend analysis
* Forecasting model preparation

---

# 🧠 Skills Demonstrated

* SQL Server
* Advanced SQL Querying
* ETL Pipeline Design
* Medallion Architecture
* Data Warehousing Concepts
* Stored Procedure Development
* Data Cleaning & Transformation
* Data Quality Validation
* Star Schema Modeling
* BI Data Preparation
* Logging and Monitoring

---

# 🔮 Future Enhancements

Planned improvements:

* Power BI dashboard development
* Advanced KPI modeling
* Sales forecasting models
* Incremental loading strategy
* Automated pipeline scheduling

---

# 📌 Key Design Principles

* Separation of raw and analytical data layers
* Clear responsibility for each ETL layer
* Fault-tolerant ingestion design
* Re-runnable pipelines
* Business-ready analytical modeling

---

# 📂 Dataset

Rossmann Store Sales Dataset
