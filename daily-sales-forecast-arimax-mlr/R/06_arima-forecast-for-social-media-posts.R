# ================================================
#
# Daily Sales Forecasting Project
# Author: Zak Laurence E. Beltran
#
# ================================================
# 06 ARIMA FORECAST FOR SOCIAL MEDIA POSTS
# ================================================


# ARIMA MODEL FITTING AND TEST FORECAST
posts <- ts(sales_df[,'Posts'], start = c(2024,306), frequency = 365)

acf(ts_train[,'Posts'])
pacf(ts_train[,'Posts'])
kpss.test(ts_train[,'Posts'])

autoplot(ts_train[,'Posts'],legendLabs = c("Train set"),xlab="Year",series="Train set") + 
  autolayer(ts_test[,'Posts'],series = "Test set") +
  ggtitle("Posts Data split")

fit <- auto.arima(ts_train[,'Posts'], trace=TRUE, approximation = FALSE)
print(summary(fit))
checkresiduals(fit)

testfcast_posts <- fit %>%
  forecast(h = length(ts_test[,'Posts']))
autoplot
plot(testfcast_posts)

autoplot(ts_train[,'Posts'],xlab ="Year",ylab="Daily Posts") +
  autolayer(ts_test[,'Posts'],series="Actual Posts",PI =FALSE) +
  autolayer(testfcast_posts,series="ARIMA",PI =FALSE) +
  ggtitle("Forecast obtained from ARIMA model")

accuracy(testfcast_posts, ts_test[,"Posts"])

# ACTUAL FORECAST

fit <- arima(posts, order = c(1,0,4))
summary(fit)
checkresiduals(fit)

fcast_posts <- fit %>%
  forecast(h = 14)
autoplot
plot(fcast_posts)

posts_forecast <- as.data.frame(fcast_posts)
print(posts_forecast$'Point Forecast')

forecast_column_vector <- posts_forecast$`Point Forecast`
xreg_posts_fc <- as.matrix(forecast_column_vector)

write.csv(xreg_posts_fc,'data/intermediate-output/Forecasted-Posts-14Days.csv')