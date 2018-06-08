library(keras)

script_dir <- dirname(sys.frame(1)$ofile)
setwd(script_dir)

source("./e6-2a.R")

dataset <- gensam()

x_train <- dataset$train$x
y_train <- dataset$train$y

# str(dataset)

model <- keras_model_sequential()

model %>%
    # layer_dense(units = 200, input_shape = c(30)) %>%
    layer_lstm(units = 200, activation = "hard_sigmoid", input_shape = c(30, 1)) %>%
    layer_dense(units = 1, activation = "sigmoid")

# summary(model)

model %>% compile(
  loss = 'binary_crossentropy',
  optimizer = optimizer_adam(lr = 0.001, beta_1 = 0.001, beta_2 = 0.999, epsilon = 10e-8),
  metrics = c('accuracy')
)

history <- model %>% fit(
  x_train, y_train,
  epochs = 10, batch_size = 100
)

plt.df <- data.frame(
  x = c(1:length(history$metrics$loss)),
  loss = history$metrics$loss,
  acc = history$metrics$acc
)

ggplot(plt.df, aes(x = x)) + geom_point(aes(y = loss, color = "Loss")) + geom_point(aes(y = acc, color = "Acc")) + labs(color = "Type")

ggsave("e6-2b.png")