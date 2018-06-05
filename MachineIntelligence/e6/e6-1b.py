from __future__ import print_function

import keras
from keras.datasets import mnist
from keras.models import Sequential
from keras.layers import Dense, Dropout
from keras.optimizers import adam
from keras.initializers import random_normal, constant

batch_size = 128
num_classes = 10
epochs = 20

# the data, split between train and test sets
(x_train, y_train), (x_test, y_test) = mnist.load_data()

x_train = x_train.reshape(60000, 784)
x_test = x_test.reshape(10000, 784)
x_train = x_train.astype('float32')
x_test = x_test.astype('float32')
x_train /= 255
x_test /= 255
# print(x_train.shape[0], 'train samples')
# print(x_test.shape[0], 'test samples')

# convert class vectors to binary class matrices
y_train = keras.utils.to_categorical(y_train, num_classes)
y_test = keras.utils.to_categorical(y_test, num_classes)

model = Sequential()
model.add(Dense(units = 1500, activation = 'relu', input_shape = (784, ), 
    kernel_initializer = random_normal(mean = 0, stddev = 0.01), bias_initializer = constant(0.1)))
model.add(Dense(units = 1500, activation = 'relu', 
    kernel_initializer = random_normal(mean = 0, stddev = 0.01), bias_initializer = constant(0.1)))
model.add(Dense(units = 1500, activation = 'relu',
    kernel_initializer = random_normal(mean = 0, stddev = 0.01), bias_initializer = constant(0.1)))
model.add(Dense(units = 10, activation = 'softmax'))

# model.summary()

model.compile(
    loss = 'categorical_crossentropy',
    optimizer = adam(lr = 0.001, beta_1 = 0.001, beta_2 = 0.999, epsilon = 10e-8),
    metrics = ['accuracy']
)

history = model.fit(x_train, y_train,
    batch_size= 100, epochs= 10
)

print(history)