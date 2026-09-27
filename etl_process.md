# Telecom Customer Revenue & Campaign Data Warehouse

## ETL Process

## 1. ETL Overview

The pipeline follows a layered ETL approach:

```text
Source CSV Files
      ↓
Staging Layer
      ↓
Dimension Loading
      ↓
Fact Loading
      ↓
Data Quality Validation
      ↓
Analytics
      ↓
BI Reporting
```

The pipeline processes three source datasets:

* Customer
* Campaign
* Recharge

---

## 2. Source Data

The source data is provided as CSV files.

### Customer

Contains customer master and demographic information.

File:

```text
data/customers.csv
```

### Campaign

Contains campaign and promotional information.

File:

```text
data/campaigns.csv
```

### Recharge

Contains customer recharge transactions.

File:

```text
data/recharges.csv
```

---

## 3. Staging Layer

The staging layer provides a landing area for source data before it is loaded into the Data Warehouse.

The following staging tables are used:

* STG_CUSTOMER
* STG_CAMPAIGN
* STG_RECHARGE

The staging layer keeps the source-oriented structure and prepares data for warehouse processing.

---

## 4. Dimension Loading

Dimension tables are loaded before the fact table.

### DIM_DATE

A calendar dimension is generated for the required reporting period.

It provides attributes such as:

* Date
* Day
* Month
* Month Name
* Quarter
* Year
* Week

### DIM_CUSTOMER

Customer records are loaded from `STG_CUSTOMER`.

The warehouse generates a surrogate key:

```text
customer_key
```

The source `customer_id` is retained as the business key.

### DIM_CAMPAIGN

Campaign records are loaded from `STG_CAMPAIGN`.

The warehouse generates a s
