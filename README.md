
### 🔹 Stage Layer
- Raw ingestion layer
- All columns stored as `NVARCHAR`
- Designed for schema flexibility and fault-tolerant loading
- Handles inconsistent or unstructured CSV inputs

### 🔸 Bronze Layer
- Cleaned and structured dataset
- Strong data typing applied (INT, BIT, DATE, DECIMAL, etc.)
- Ready for analytical processing and reporting

---

## 🧱 Data Domains

### 📦 Store Domain
Contains store-level metadata:
- Store type
- Assortment
- Competition details
- Promotion configuration

### 🛒 Sales (Train) Domain
Contains transactional sales data:
- Daily sales
- Customers
- Promotions
- Holiday flags

---

## ⚙️ ETL Process

The pipeline is implemented using **SQL Server Stored Procedures** and follows a structured workflow:

1. Truncate Stage tables
2. Load raw data using `BULK INSERT.`
3. Store raw data in Stage layer (NVARCHAR format)
4. Transform and clean data
5. Load into Bronze layer
6. Apply data type conversions using `TRY_CAST.`
7. Normalize categorical and boolean fields
8. Track row counts at each stage
9. Measure execution time per process
10. Implement error handling using `TRY...CATCH.`


## ETL Challenges & Solutions

### Handling Quoted Values in Source Data

During the ingestion process, some source CSV files contained quoted values (`"`) that affected the data import process and caused parsing issues.

To ensure accurate ingestion:
- The raw files were first loaded into staging tables.
- Data was reviewed and handled before being inserted into the Bronze layer.
- The staging layer provided better control over raw data ingestion and helped preserve data quality.
---

## 🚀 Key Features

### ⚡ Bulk Data Ingestion
Efficient loading of CSV files using `BULK INSERT`

### 🧹 Data Cleaning & Standardization
- Removal of unwanted characters
- Handling of null and missing values
- Standardization of categorical fields

### 🔄 Safe Type Conversion
- Uses `TRY_CAST` to prevent pipeline failures
- Ensures robust transformation from raw to structured data

### 📊 Logging & Monitoring
- Row count tracking for Stage and Bronze layers
- Execution time measurement for each ETL step
- Batch-level execution tracking

### ♻️ Re-runnable Pipeline
- Fully idempotent design using `TRUNCATE + RELOAD`
- Safe to execute multiple times without duplication

### 🛡️ Error Handling
- Implemented `TRY...CATCH` blocks
- Captures error message, number, and line for debugging

---

## 📈 Business Use Cases

The final dataset enables:

- Sales performance analysis
- Store benchmarking
- Promotion effectiveness analysis
- Time-based trend analysis
- Input for forecasting models

---

## 🧠 Skills Demonstrated

- SQL Server (Advanced Level)
- ETL Pipeline Design
- Data Warehousing Concepts
- Stored Procedures Development
- Bulk Data Processing
- Data Cleaning & Transformation
- Logging & Monitoring Mechanisms
- Analytical Data Modeling

---

## 🔮 Future Enhancements

- Implementation of Silver Layer (Feature Engineering)
- Business KPI modeling (Gold Layer)
- Power BI dashboard integration
- Time-series forecasting preparation
- Incremental loading (CDC-based approach)

---

## 📌 Key Design Principles

- Separation of raw and transformed data
- Fault-tolerant ingestion design
- Re-runnable ETL pipelines
- Scalable layered architecture

---

## 📂 Dataset

Rossmann Store Sales Dataset
