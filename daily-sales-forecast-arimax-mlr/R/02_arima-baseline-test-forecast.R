# ================================================
#
# Daily Sales Forecasting Project
# Author: Zak Laurence E. Beltran
#
# ================================================
# 02 ARIMA BASELINE TEST FORECAST
# ================================================

fit_ARIMA <- auto.arima(ts_train[,'Sales'], seasonal = FALSE, approximation=FALSE, trace=TRUE)
print(summary(fit_ARIMA))
checkresiduals(fit_ARIMA)

fcast_ARIMA_only <- fit_ARIMA %>%
  forecast(h = 32)
autoplot
plot(fcast_ARIMA_only)
