library(keras)
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

mnist <- dataset_mnist()

# reshape
x_train <- array_reshape(mnist$train$x, c(nrow(mnist$train$x), 28, 28, 1))
x_test <- array_reshape(mnist$test$x, c(nrow(mnist$test$x), 28, 28, 1))
# rescale
# x_train <- x_train / 255
# x_test <- x_test / 255

y_train <- to_categorical(mnist$train$y, 10)
y_test <- to_categorical(mnist$test$y, 10)

model <- keras_model_sequential()

model %>% 
    layer_conv_2d(filter = 32, kernel_size = 5, strides = 1, padding = "same", activation = "relu", input_shape = c(28, 28, 1)) %>%
    layer_max_pooling_2d(pool_size = 2, strides = 2) %>%
    layer_conv_2d(filter = 64, kernel_size = 5, strides = 1, padding = "same", activation = "relu") %>%
    layer_max_pooling_2d(pool_size = 2, strides = 2) %>%
    layer_flatten() %>%
    layer_dense(units = 10, activation = "softmax")

summary(model)

model %>% compile(
  loss = 'categorical_crossentropy',
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

ggsave("e6-1d.png")