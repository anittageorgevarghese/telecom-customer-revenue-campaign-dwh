# Telecom Customer Revenue & Campaign Data Warehouse

## Business Requirements

## 1. Business Objective

Build a centralized Data Warehouse to consolidate telecom customer, recharge and campaign data for analytical reporting.

The warehouse should provide a consistent data model for revenue analysis, customer segmentation and campaign performance reporting.

---

## 2. Business Questions

The solution should help answer the following questions:

### Revenue

* What is the total customer revenue?
* What is the monthly revenue trend?
* How many transactions were completed?
* What is the average transaction value?
* What is the average revenue per active customer (ARPU)?

### Customer

* Which customers generate the highest revenue?
* How many active customers are generating revenue?
* How does revenue vary by customer segment?
* How does revenue vary by region?
* What is the revenue per customer by segment?

### Campaign

* Which campaigns are associated with customer revenue?
* How many customers are associated with each campaign?
* How many transactions are associated with each campaign?
* How does campaign revenue vary by campaign type?
* How does campaign performance vary by channel?

---

## 3. Source Data

The solution uses the following source datasets:

### Customer

Contains customer demographic and profile information.

Key fields:

* customer_id
* msisdn
* gender
* age
* customer_type
* segment
* region
* activation_date
* status

### Campaign

Contains campaign and promotional information.

Key fields:

* campaign_id
* campaign_name
* campaign_type
* start_date
* end_date
* target_segment
* channel
* status

### Recharge

Contains customer recharge transactions.

Key fields:

* transaction_id
* customer_id
* transaction_date
* recharge_amount
* payment_channel
* recharge_type
* campaign_id

---

## 4. Data Warehouse Requirements

The warehouse should:

* Use a dimensional modelling approach.
* Implement a Star Schema.
* Use surrogate keys for warehouse dimensions.
* Retain source business keys.
* Maintain a dedicated Date Dimension.
* Store transactional revenue in a Fact table.
* Support historical and time-based analysis.
* Provide consistent dimensions for BI reporting.

---

## 5. Data Quality Requirements

The ETL process should validate:

* Source-to-target record counts.
* Customer reference integrity.
* Campaign reference integrity.
* Duplicate transactions.
* NULL values in critical fact columns.
* Source-to-target revenu
