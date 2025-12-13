# ================================================
#
# Daily Sales Forecasting Project
# Author: Zak Laurence E. Beltran
#
# ================================================
# 04 ARIMAX SHORTLISTED MODELS TEST FORECASTS
# ================================================

# Best RMSE - ARIMAX (0,0,1) X -> Fiesta (col_5), Promo (col_8)

xreg_train <- ts_train[, c(5, 8)]
xreg_test  <- ts_test[,  c(5, 8)]

fitX <- auto.arima(ts_train[,'Sales'], xreg = xreg_train, trace=TRUE, approximation = FALSE)
print(summary(fitX))
checkresiduals(fitX)

fcast_RMSE <- fitX %>%
  forecast(xreg = xreg_test)
autoplot
plot(fcast_RMSE)

# Best MAPE - ARIMAX (0,0,2) X -> Fiesta (col_5), Promo (col_8), Posts (col_9)

xreg_train <- ts_train[, c(5, 8, 9)]
xreg_test  <- ts_test[,  c(5, 8, 9)]

fitX <- auto.arima(ts_train[,'Sales'], xreg = xreg_train, trace=TRUE, approximation = FALSE)
print(summary(fitX))
checkresiduals(fitX)

fcast_MAPE <- fitX %>%
  forecast(xreg = xreg_test)
autoplot
plot(fcast_MAPE)

# MLR Analysis and Backward Elimination Method - ARIMAX (0,0,2) X -> Fiesta (col_5) , Holiday (col_6), Promo (col_8), Posts (col_9)

xreg_train <- ts_train[, c(5, 6, 8, 9)]
xreg_test  <- ts_test[,  c(5, 6, 8, 9)]

fitX <- auto.arima(ts_train[,'Sales'], xreg = xreg_train, trace=TRUE, approximation = FALSE)
print(summary(fitX))
checkresiduals(fitX)

fcast_MLR <- fitX %>%
  forecast(xreg = xreg_test)
autoplot
plot(fcast_MLR)

