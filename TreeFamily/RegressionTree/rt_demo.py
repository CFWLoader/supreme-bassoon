print(__doc__)

# Import the necessary modules and libraries
import numpy as np
from sklearn import tree
from sklearn.tree import DecisionTreeRegressor
import matplotlib.pyplot as plt
import graphviz
import os

dir_path = dir_path = os.path.dirname(os.path.realpath(__file__))

# Create a random dataset
rng = np.random.RandomState(1)
X = np.sort(5 * rng.rand(80, 1), axis=0)
y = np.sin(X).ravel()
y[::5] += 3 * (0.5 - rng.rand(16))

# Fit regression model
regr_1 = DecisionTreeRegressor(max_depth=2)
regr_2 = DecisionTreeRegressor(max_depth=5)
regr_3 = DecisionTreeRegressor()
regr_1.fit(X, y)
regr_2.fit(X, y)
regr_3.fit(X, y)

# Predict
X_test = np.arange(0.0, 5.0, 0.01)[:, np.newaxis]
y_1 = regr_1.predict(X_test)
y_2 = regr_2.predict(X_test)
y_3 = regr_3.predict(X_test)

print(regr_1.score(X, y))
print(regr_2.score(X, y))
print(regr_3.score(X, y))
# dot_data = tree.export_graphviz(regr_3, out_file=os.path.join(dir_path, "cart_nomaxdep.dot"), 
#     feature_names=None, class_names=None,
#     filled=True, rounded=True, special_characters=True)

# Plot the results
plt.figure()
plt.scatter(X, y, s=20, edgecolor="black",
            c="darkorange", label="data")
plt.plot(X_test, y_1, color="cornflowerblue",
         label="max_depth=2", linewidth=2)
plt.plot(X_test, y_2, color="yellowgreen", label="max_depth=5", linewidth=2)
plt.plot(X_test, y_3, color="red", label = "max_depth=%d"%(regr_3.tree_.max_depth), linewidth=2)
plt.xlabel("data")
plt.ylabel("target")
plt.title("Decision Tree Regression")
plt.legend()
plt.savefig(os.path.join(dir_path, "cart_test.png"))
# plt.show()