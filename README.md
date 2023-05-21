# Customer Segmentation Analysis

This repository contains code that performs customer segmentation analysis based on the Recency-Frequency-Monetary (RFM) model using the `readxl`, `ggplot2`, and `dplyr` libraries in R.

## Table of Contents
- [Introduction](#introduction)
- [Data](#data)
- [RFM Analysis](#rfm-analysis)
- [Customer Segmentation](#customer-segmentation)

## Introduction
Customer segmentation is a powerful technique used in marketing and business analysis to categorize customers into groups based on their behaviors and characteristics. The RFM model is a commonly used approach for customer segmentation, which considers three key metrics: Recency, Frequency, and Monetary value.

## Data
The analysis uses a retail dataset (`Retail_dataset_B.xlsx`) that contains information about customer transactions, including the invoice dates, customer IDs, quantities, etc. The dataset is read into R using the `read_excel` function from the `readxl` library.

## RFM Analysis
The code performs the following steps to calculate the RFM values for each customer:

1. First, the maximum and minimum dates of customer transactions are determined to identify the last and first purchase dates for each customer.
2. The reference day is set as January 1, 2012.
3. The recency (R) value is calculated by finding the difference in days between the reference day and the customer's last transaction date.
4. The frequency (F) value is determined by counting the number of transactions for each customer.
5. The monetary (M) value is calculated by summing the quantity of products purchased by each customer.
6. The RFM values are stored in separate data frames: `rfm_recency`, `rfm_frequency`, and `rfm_monetary`.

## Customer Segmentation
To segment the customers based on their RFM values, the code performs the following calculations:

1. Additional calculations are performed to determine other relevant metrics, such as the number of days since the last transaction, the number of days with the firm, and the number of years with the firm.
2. The RFM values are standardized by dividing them by 500 and adding 1.
3. The customers are then assigned segments based on the quartiles of their RFM values.
4. The final result is stored in the `Max_date` data frame, which includes the customer ID along with the calculated RFM values and segmentations.

The code also generates histograms to visualize the distributions of the recency, frequency, and monetary values.

Please note that this readme file only explains the purpose and steps involved in the code. For a detailed understanding of the code implementation, refer to the code file itself.

