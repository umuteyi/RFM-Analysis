library("readxl")
library(ggplot2)
library(dplyr)
setwd("/Users/umuteyidogan/Desktop")
rdata <- read_excel("Retail_dataset_B.xlsx")
#As a first I have found the Max and Min dates of the customers to calculate when was the last and first time they buy something from us by using the given dataset
Max_date<- aggregate(rdata$InvoiceDate, by=list(rdata$CustomerID), max)
Max_date$MaxofDate <- as.Date(Max_date$x,format="%Y-%d-%m")

Min_date <- aggregate(rdata$InvoiceDate, by=list(rdata$CustomerID), min)
Max_date$MinofDate <- as.Date(Min_date$x,format="%Y-%d-%m")
# The lists above represents the customers first and last purchases.
refDay <- as.Date("2012-01-01",format="%Y-%d-%m")
refDay
class(refDay)
as.numeric(refDay-rdata$InvoiceDate) #founding the day difference

# Recency (R) : When did the customer make their last purchase?
rfm_recency<- rdata %>% group_by(CustomerID)%>% summarise(Recency = as.numeric(refDay)- as.numeric(max(InvoiceDate))) 
# Frequency (F) : How often does the customer make a purchase?
rfm_frequency <- rdata %>% group_by(CustomerID)%>% summarise (frequency=n())
# Monetary (M) : How much does the customer spend? 
rfm_monetary <- rdata %>% group_by(CustomerID)%>% summarise(Monetary= sum(Quantity))
# Customers with the high F and M are our loyal customers.

rfm <- merge(rfm_recency, rfm_frequency, by="CustomerID")
rfm <- merge(rfm,rfm_monetary, by="CustomerID")

hist(rfm_recency$Recency)
hist(rfm_frequency$frequency)
hist(rfm_monetary$Monetary)
# Calculations
Max_date$LastTransaction <- (as.numeric(refDay)-as.numeric(Max_date$MaxofDate))
Max_date$DayswFirm <- (as.numeric(refDay)-as.numeric(Max_date$MinofDate))
Max_date$YearsWithFirm <- (as.numeric(refDay)-as.numeric(Max_date$MinofDate))/365
# R,F,M values.
Max_date$recency <- Max_date$LastTransaction
Max_date$frequency <- (rfm_frequency$frequency)/ Max_date$YearsWithFirm
Max_date$monetary <- (rfm_monetary $Monetary) / Max_date$YearsWithFirm

Max_date$RecencySorted[order(Max_date$LastTransaction)] <- 1:nrow(Max_date)
Max_date$FrequencySorted[order(Max_date$frequency)] <- 1:nrow(Max_date)
Max_date$MonetarySorted[order(Max_date$monetary)] <- 1:nrow(Max_date)


Max_date$R <- floor((Max_date$RecencySorted)/500)+1
Max_date$F <- floor((Max_date$FrequencySorted)/500)+1
Max_date$M <- floor((Max_date$MonetarySorted)/500)+1


