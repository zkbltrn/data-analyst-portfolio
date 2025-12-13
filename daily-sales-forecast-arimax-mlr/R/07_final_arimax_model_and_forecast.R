# ================================================
#
# Daily Sales Forecasting Project
# Author: Zak Laurence E. Beltran
#
# ================================================
# 07 FINAL ARIMAX MODEL AND FORECAST
# ================================================

# FINAL MODEL - ARIMAX (0,0,2) - XReg: Fiesta (col_5), Promos (col_8), Posts (col_9)

# Fiesta (col_5) and Promos (col_8) are already collected/given data. Posts (col_9) was forecast using ARIMA
finalxreg_df = read.csv('data/intermediate-output/Final-XReg.csv', header=TRUE, stringsAsFactors=FALSE)
finalxreg <- ts(finalxreg_df, start = c(2025,121), frequency = 365)

acf(sales[,'Sales'])
pacf(sales[,'Sales'])

xreg_sales <- sales[, c(5, 8, 9)]

fitX <- Arima(sales[,'Sales'], xreg = xreg_sales, order = c(0,0,2))
print(summary(fitX))
checkresiduals(fitX)

fcastf <- fitX %>%
  forecast(xreg = finalxreg)
autoplot
plot(fcastf)

autoplot(sales[,'Sales'],xlab ="Year",ylab="Daily Sales") +
  autolayer(sales[,'Sales'],series="Actual Sales") +
  autolayer(fcastf,series="ARIMAX") +
  ggtitle("Forecast obtained from ARIMAX model")

print(fcastf)

final_salesforecast <- as.data.frame(fcastf)
print(final_salesforecast$'Point Forecast')

write.csv(final_salesforecast$'Point Forecast','data/final-output/Forecasted-Sales-14Days.csv')

# All done! :)