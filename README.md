# Data Cleaning and Transformation of Nashville Housing Data using SQL

***

## Project Summary

This project focused on the **end-to-end cleaning and preparation** of the **Nashville Housing Data** dataset. Utilizing **SQL**, transformed raw, inconsistent data into a structured, analysis-ready format.

***

## Key Data Cleaning and Transformation Steps

The core objective was to apply data manipulation and standardization techniques to address common issues like missing values, data inconsistencies, and duplicate records. The following SQL techniques were implemented:

### 1. Handling Missing Data (Imputation)
* **Identified and populated** missing `PropertyAddress` values.
* Implemented a **self-join** on the table, matching records with the same **`ParcelID`** (a unique property tax identifier) to logically infer and fill in the missing addresses.

### 2. Data Splitting
* **Decomposed** address fields (`PropertyAddress` and `OwnerAddress`) into distinct columns: **Street Address**, **City**, and **State**.
* This was achieved using **SQL string functions** (`SUBSTRING`, `POSITION`, `SPLIT_PART`)

### 3. Data Standardization
* **Standardized** the binary `SoldAsVacant` column by converting inconsistent abbreviations ('Y', 'N') into the clear, uniform categorical values ('Yes', 'No').

### 4. Data Quality Assurance (Deduplication)
* **Identified and removed** all strictly duplicate records across the dataset.
* This was accomplished using **SQL Window Functions** (specifically **`ROW_NUMBER()`**) partitioned across a combination of key columns (`ParcelID`, `PropertyAddress`, `SalePrice`, `SaleDate`, `LegalReference`).

***

## Skills Demonstrated

| Category | Skills Demonstrated |
| :--- | :--- |
| **Technical Proficiency** | **SQL** (Self-Joins, String Manipulation, `UPDATE`/`ALTER`, Window Functions like `ROW_NUMBER()`), Data Definition and Manipulation Language (DDL/DML) |
| **Data Analytics** | **Data Cleaning** and Pre-processing, Data Quality Assurance, Data Splitting, Data Standardization. |
| **Analytical & Mathematical** | **Logical Problem Solving**, Deduplication and Relational Logic, Attention to Detail. |
