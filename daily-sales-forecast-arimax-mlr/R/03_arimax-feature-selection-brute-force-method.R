# ================================================
#
# Daily Sales Forecasting Project
# Author: Zak Laurence E. Beltran
#
# ================================================
# 03 ARIMAX FEATURE SELECTION (BRUTE FORCE)
# ================================================

reg_cols <- c(3:9)
results <- list()
i <- 1
for (k in 1:length(reg_cols)) {
  combos <- combn(reg_cols, k, simplify = FALSE)
  for (combo in combos) {
    combo_name <- paste0("cols_", paste(combo, collapse = "_"))
    
    xreg_train <- ts_train[, combo, drop = FALSE]
    xreg_test  <- ts_test[,  combo, drop = FALSE]
    
    fit <- auto.arima(ts_train[,'Sales'],
                      xreg        = xreg_train,
                      trace       = FALSE,
                      approximation=FALSE)
    
    fcast <- forecast(fit, xreg = xreg_test)
    
    acc <- accuracy(fcast, ts_test[,'Sales'])
    
    results[[i]] <- tibble(
      model       = combo_name,
      arima       = as.character(fit$arma[c(1,6,2)] %>% paste(collapse=",")),
      AICc        = fit$aicc,
      BIC         = fit$bic,
      RMSE_test   = acc["Test set","RMSE"],
      MAE_test    = acc["Test set","MAE"],
      MAPE_test   = acc["Test set","MAPE"]
    )
    i <- i + 1
  }
}
results_df <- bind_rows(results)

results_df %>% # Shows results arranged by MAPE (Ascending)
  filter(MAPE_test <= 50) %>%  
  arrange(MAPE_test) %>%
  print(n = Inf)

results_df %>% # Shows results arranged by RMSE (Ascending)
  filter(MAPE_test <= 50) %>%  
  arrange(RMSE_test) %>%
  print(n = Inf)

# Shortlist of ARIMAX models with different exogenous variables:
# - Best RMSE - ARIMAX(0,0,1) - XReg: Fiesta (col_5), Promo (col_8)
# - Best MAPE - ARIMAX(0,0,2) - XReg: Fiesta (col_5), Promo (col_8), Posts (col_9)
# - MLR Analysis and Backward Elimination - ARIMAX(0,0,2) - XReg: Fiesta (col_5) , Holiday (col_6), Promo (col_8), Posts (col_9)