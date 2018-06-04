library(keras)
library(reshape2)
library(ggplot2)
# install_keras()           # First time installation.

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

model %>% layer_dense(units = 10, activation = 'softmax', input_shape = c(784))

model %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = optimizer_sgd(lr = 0.5),
  metrics = c('accuracy')
)

history <- model %>% fit(
  x_train, y_train,
  epochs = 10000, batch_size = 100,
)

plt.df <- data.frame(
  x = c(1:length(history$metrics$loss)),
  loss = history$metrics$loss,
  acc = history$metrics$acc
)

ggplot(plt.df, aes(x = x)) + geom_point(aes(y = loss, color = "Loss")) + geom_point(aes(y = acc, color = "Acc")) + labs(color = "Type")

ggsave("e6-1a.png")

# plot(history)

# summary(model)

# sample_pic <- mnist$train$x[7, , ]
# pic.mat <- matrix(sample_pic, nrow = 28, byrow = TRUE)
# print(str(pic.mat))
# ggplot(data = melt(pic.mat), aes(x = Var1, y = Var2, fill = value)) + geom_tile()
# ggsave("Sample1.png")