from keras.models import Sequential
from keras.layers import Dense, Activation
from keras.datasets import mnist

# model = Sequential([
#     Dense(32, units=784),
#     Activation('relu'),
#     Dense(10),
#     Activation('softmax'),
# ])

(X_train, y_train), (X_test, y_test) = mnist.load_data()
print("X_train original shape", X_train.shape)
print("y_train original shape", y_train.shape)