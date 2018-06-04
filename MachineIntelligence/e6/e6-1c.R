library(keras)
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

mnist <- dataset_mnist()

# reshape
x_train <- array_reshape(mnist$train$x, c(nrow(mnist$train$x), 784))
x_test <- array_reshape(mnist$test$x, c(nrow(mnist$test$x), 784))
# rescale
x_train <- x_train / 255
x_test <- x_test / 255

y_train <- to_categorical(mnist$train$y, 10)
y_test <- to_categorical(mnist$test$y, 10)

model <- keras_model_sequential()

model %>% 
    layer_dense(units = 1500, activation = "relu", input_shape = c(784), 
        kernel_initializer = initializer_random_normal(mean = 0, stddev = 0.01), 
        bias_initializer = initializer_constant(value = 0.1)) %>%
    layer_dropout(0.5) %>%
    layer_dense(units = 1500, activation = "relu", 
        kernel_initializer = initializer_random_normal(mean = 0, stddev = 0.01), 
        bias_initializer = initializer_constant(value = 0.1)) %>%
    layer_dropout(0.5) %>%
    layer_dense(units = 1500, activation = "relu", 
        kernel_initializer = initializer_random_normal(mean = 0, stddev = 0.01), 
        bias_initializer = initializer_constant(value = 0.1)) %>%
    layer_dropout(0.5) %>%
    layer_dense(units = 10, activation = "softmax")

# C:\\Users\\IBM_ADMIN\\Desktop\\supreme-bassoon\\MachineIntelligence\\e6

model %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = optimizer_adam(lr = 0.001, beta_1 = 0.001, beta_2 = 0.999, epsilon = 10e-8),
  metrics = c('accuracy')
)

history <- model %>% fit(
  x_train, y_train,
  epochs = 10, batch_size = 100,
)

plt.df <- data.frame(
  x = c(1:length(history$metrics$loss)),
  loss = history$metrics$loss,
  acc = history$metrics$acc
)

ggplot(plt.df, aes(x = x)) + geom_point(aes(y = loss, color = "Loss")) + geom_point(aes(y = acc, color = "Acc")) + labs(color = "Type")

ggsave("e6-1c.png")