# ================================================
#
# Daily Sales Forecasting Project
# Author: Zak Laurence E. Beltran
#
# ================================================
# 05 FINAL SELECTION OF ARIMAX MODEL
# ================================================

# PLOT ALL MODELS' TEST FORECASTS
actual_ts <- ts(ts_test[,'Sales'], start = 1, frequency = 1)
rmse_ts     <- ts(fcast_RMSE$mean,     start = 1, frequency = 1)
mape_ts <- ts(fcast_MAPE$mean,     start = 1, frequency = 1)
mlr_ts    <- ts(fcast_MLR$mean,     start = 1, frequency = 1)

autoplot(actual_ts,
         xlab   = "Days",
         ylab   = "Sales",
         series = "Actual Sales") +
  autolayer(rmse_ts,
            series = "Best RMSE",
            PI     = FALSE) +
  autolayer(mape_ts,
            series = "Best MAPE",
            PI     = FALSE) +
  autolayer(mlr_ts,
            series = "MLR Method",
            PI     = FALSE) 

# RESIDUALS OF EACH MODEL

actual <- ts_test[,"Sales"]

res_MAPE <- actual - fcast_MAPE$mean
res_RMSE <- actual - fcast_RMSE$mean
res_MLR <- actual - fcast_MLR$mean
res_ARIMA_only <- actual - fcast_ARIMA_only$mean

k1 <- cbind(res_MAPE,res_RMSE,res_MLR,res_ARIMA_only)
colnames(k1) <- c("Best MAPE","Best RMSE",
                  "MLR Method","ARIMA only")

k1_ts <- ts(k1,
            start    = 1,
            frequency = 1)

autoplot(k1_ts,
         xlab = "Day",
         ylab = "Residuals") 

# BEST MAPE WAS CHOSEN AS THE FINAL MODEL
# SIDE NOTE: Notice how MAPE's exogenous variables is 3/4 of MLR method's chosen variables.