# Telecom Customer Revenue & Campaign Data Warehouse

## Data Model

## 1. Architecture

The solution follows a layered Data Warehouse architecture:

```text
Source Data
    ↓
Staging Layer
    ↓
Dimensional Data Warehouse
    ↓
Analytics Layer
    ↓
BI Dashboard
```

---

## 2. Data Warehouse Model

The warehouse follows a **Star Schema** design.

### Fact Table

**FACT_CUSTOMER_REVENUE**

**Grain:**

One row represents one customer recharge transaction.

**Measures:**

* revenue_amount
* transaction_count

**Foreign Keys:**

* date_key
* customer_key
* campaign_key

**Business Identifier:**

* transaction_id

---

## 3. Dimension Tables

### DIM_DATE

Stores calendar information used for time-based analysis.

**Key:**

* date_key

**Attributes:**

* full_date
* day
* month
* month_name
* quarter
* year
* week

**Used for:**

* Daily revenue
* Monthly revenue
* Quarterly revenue
* Yearly revenue
* Time-based reporting

---

### DIM_CUSTOMER

Stores customer master information.

**Key:**

* customer_key

**Business Key:**

* customer_id

**Attributes:**

* msisdn
* gender
* age
* customer_type
* segment
* region
* activation_date
* status
* created_date

**Used for:**

* Customer segmentation
* Revenue by customer
* Revenue by region
* Customer activity analysis

---

### DIM_CAMPAIGN

Stores campaign information.

**Key:**

* campaign_key

**Business Key:**

* campaign_id

**Attributes:**

* campaign_name
* campaign_type
* start_date
* end_date
* target_segment
* channel
* status

**Used for:**

* Campaign revenue analysis
* Campaign transaction analysis
* Campaign customer analysis
* Channel performance

---

## 4. Star Schema

The logical relationship is:

```text
                 DIM_DATE
                    |
                    |
DIM_CUSTOMER --- FACT_CUSTOMER_REVENUE --- DIM_CAMPAIGN
```

The fact table stores customer recharge transactions and connects them with descriptive dimensions for analytical reporting.

---

## 5. Staging Layer

The staging layer contains source-oriented tables:

* STG_CUSTOMER
* STG_CAMPAIGN
* STG_RECHARGE

The staging layer is used to receive and prepare source data before loading the dimensional warehouse.

---

## 6. ETL Flow

### Extract

Customer, campaign and recharge data are received into staging tables.

### Transform

Source data is mapped to warehouse dimensions.

Business keys are used to identify the corresponding dimension records, while surrogate keys are used in the fact table.

### Load

Dimension tables are loaded first.

The fact table is then populated using surrogate keys from the dimensions.

Campaign mapping is optional at the fact level so that recharge transactions are not unnecessarily excluded when a campaign reference is unavailable.

---

## 7. Key Design

The warehouse uses surrogate keys for dimensions:

* date_key
* customer_key
* campaign_key

Source/business identifiers are retained separately:

* customer_id
* campaign_id
* transaction_id

This separates warehouse keys from source-system identifiers and supports dimensional modelling.

---

## 8. Analytical Use Cases

The model supports:

1. Total revenue analysis
2. Monthly revenue trends
3. ARPU analysis
4. Average transaction value
5. Campaign performance
6. Customer revenue analysis
7. Customer segment performance
8. Regional revenue analysis
9. Transaction-level reporting

---

## 9. Data Quality

The warehouse includes validation checks for:

* Source-to-target record counts
* Unmatched customer references
* Unmatched campaign references
* Duplicate transactions
* NULL values in critical fact fields
* Source-to-target revenue reconciliation
* Fact table grain validation
