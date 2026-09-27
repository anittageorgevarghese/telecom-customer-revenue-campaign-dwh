# Telecom Customer Revenue & Campaign Data Warehouse

## Project Overview

This project demonstrates the design and implementation of a SQL-based Telecom Customer Revenue & Campaign Data Warehouse.

The solution uses a dimensional modelling approach to organize customer, campaign, and recharge transaction data for analytical reporting.

The warehouse is designed to support revenue analysis, customer segmentation, campaign performance analysis, and data quality validation.

---

## Business Objective

The objective is to build a centralized Data Warehouse that transforms source-oriented telecom data into a structured analytical model.

The solution enables business users to analyze:

* Customer revenue
* Monthly revenue trends
* Transaction volumes
* Average Transaction Value
* Revenue per active customer (ARPU)
* Customer segment performance
* Regional revenue
* Campaign performance
* Campaign channel performance

---

## Architecture

The ETL pipeline follows a layered Data Warehouse architecture:

```text
Source CSV Files
       |
       v
Staging Layer
       |
       v
Dimension Tables
       |
       v
Fact Table
       |
       v
Data Quality Validation
       |
       v
Analytics Layer
       |
       v
BI Reporting
```

---

## Data Warehouse Model

The warehouse follows a **Star Schema** design.

### Fact Table

**FACT_CUSTOMER_REVENUE**

**Grain:**

> One row represents one customer recharge transaction.

**Measures:**

* `revenue_amount`
* `transaction_count`

**Foreign Keys:**

* `date_key`
* `customer_key`
* `campaign_key`

**Business Identifier:**

* `transaction_id`

### Dimension Tables

#### DIM_DATE

Contains calendar attributes used for time-based analysis.

Key attributes:

* `date_key`
* `full_date`
* `day`
* `month`
* `month_name`
* `quarter`
* `year`
* `week`

#### DIM_CUSTOMER

Contains customer demographic and profile information.

Key attributes:

* `customer_key`
* `customer_id`
* `msisdn`
* `gender`
* `age`
* `customer_type`
* `segment`
* `region`
* `activation_date`
* `status`

#### DIM_CAMPAIGN

Contains campaign and promotional information.

Key attributes:

* `campaign_key`
* `campaign_id`
* `campaign_name`
* `campaign_type`
* `start_date`
* `end_date`
* `target_segment`
* `channel`
* `status`

---

## Star Schema

```text
                       DIM_DATE
                           |
                           |
                           v
DIM_CUSTOMER ---> FACT_CUSTOMER_REVENUE <--- DIM_CAMPAIGN
```

The fact table stores measurable business events, while the dimension tables provide descriptive context for analysis.

---

## Source Data

The project uses CSV-based source data for:

### Customer

Contains customer profile information such as:

* Customer ID
* MSISDN
* Gender
* Age
* Customer Type
* Segment
* Region
* Activation Date
* Status

### Campaign

Contains campaign information such as:

* Campaign ID
* Campaign Name
* Campaign Type
* Start Date
* End Date
* Target Segment
* Channel
* Status

### Recharge

Contains customer recharge transactions such as:

* Transaction ID
* Customer ID
* Transaction Date
* Recharge Amount
* Payment Channel
* Recharge Type
* Campaign ID

---

## ETL Process

The ETL process is divided into the following stages:

### 1. Database Creation

Creates the Data Warehouse database.

```text
01_create_database.sql
```

### 2. Staging

Creates staging tables for receiving source data.

```text
02_create_staging_tables.sql
```

### 3. Dimension Creation

Creates the dimensional tables used for analytical reporting.

```text
03_create_dimensions.sql
```

### 4. Fact Creation

Creates the customer revenue fact table.

```text
04_create_facts.sql
```

### 5. Dimension Loading

Loads source data into the dimension tables.

```text
05_load_dimensions.sql
```

### 6. Fact Loading

Loads recharge transactions into the fact table using dimension surrogate keys.

```text
06_load_facts.sql
```

### 7. Data Quality Validation

Performs validation and reconciliation checks.

```text
07_validation.sql
```

### 8. Analytics

Provides analytical SQL queries for business reporting.

```text
08_analytics.sql
```

---

## Data Quality Checks

The project includes SQL-based data quality validation for:

* Source-to-target record counts
* Customer reference integrity
* Campaign reference integrity
* Duplicate transactions
* NULL values in critical fact columns
* Source-to-target revenue reconciliation
* Fact table grain validation

Example reconciliation:

```text
Staging Revenue
       |
       v
Warehouse Revenue
       |
       v
Revenue Difference
```

The expected revenue difference should be zero when all valid source transactions ar
