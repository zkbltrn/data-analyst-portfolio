# ================================================
#
# Daily Sales Forecasting Project
# Author: Zak Laurence E. Beltran
#
# ================================================
# 01 DATA TRAIN AND TEST SPLIT
# ================================================

library('ggplot2')
library('forecast')
library('tseries')
library('tidyverse')

# CONFIGURE TIME SERIES
sales_df = read.csv('data/collected-data/DailySales-and-XReg-6Months-Data.csv', header=TRUE, stringsAsFactors=FALSE)
sales <- ts(sales_df, start = c(2024,306), frequency = 365)
plot(sales[,'Sales'])

# SPLIT TIME SERIES TO TRAIN AND TEST DATA
ts_train <- window(sales,start=c(2024,306),end=c(2025,90))
ts_test  <- window(sales,start=c(2025,90))
autoplot(ts_train[,'Sales'],xlab="Year",series="Train set") + 
  autolayer(ts_test[,'Sales'],series = "Test set") +
  ggtitle("Data split 1")

# CHECK ACF AND TEST KPSS
acf(ts_train[,'Sales'])
pacf(ts_train[,'Sales'])
kpss.test(ts_train[,'Sales'])

