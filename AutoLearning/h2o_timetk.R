# https://ask.hellobi.com/blog/R_shequ/18186
library(timetk)
library(h2o)
library(tidyquant)
library(dplyr)

# Prepare data.
beer_sales_tbl <- tq_get(
    "S4248SM144NCEN", 
    get = "economic.data", 
    from = "2010-01-01",
    to = "2017-10-27")

# Augment (adds data frame columns)
beer_sales_tbl_aug <- beer_sales_tbl %>%
    tk_augment_timeseries_signature()

# beer_sales_tbl_aug %>% glimpse()

beer_sales_tbl_clean <- beer_sales_tbl_aug %>%
    select_if(~ !is.Date(.)) %>%
    select_if(~ !any(is.na(.))) %>%
    mutate_if(is.ordered, ~ as.character(.) %>% as.factor)

# beer_sales_tbl_clean %>% glimpse()

# Split into training, validation and test sets
train_tbl <- beer_sales_tbl_clean %>% filter(year < 2016)
valid_tbl <- beer_sales_tbl_clean %>% filter(year == 2016)
test_tbl  <- beer_sales_tbl_clean %>% filter(year == 2017)

h2o.init()
h2o.no_progress() # Turn off progress bars

# Convert to H2OFrame objects
train_h2o <- as.h2o(train_tbl)
valid_h2o <- as.h2o(valid_tbl)
test_h2o  <- as.h2o(test_tbl)

# Set names for h2o
y <- "price"
x <- setdiff(names(train_h2o), y)

# linear regression model used, but can use any model
automl_models_h2o <- h2o.automl(
    x = x, 
    y = y, 
    training_frame = train_h2o, 
    validation_frame = valid_h2o, 
    leaderboard_frame = test_h2o, 
    max_runtime_secs = 60, 
    stopping_metric = "deviance")

# Extract leader model
automl_leader <- automl_models_h2o@leader

# str(automl_models_h2o)
# print(automl_leader)

pred_h2o <- h2o.predict(automl_leader, newdata = test_h2o)
h2o.performance(automl_leader, newdata = test_h2o)