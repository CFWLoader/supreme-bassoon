from sklearn.datasets import load_iris
import sklearn.covariance as covar
import numpy as np

datapack = load_iris()

x = datapack.get('data')
y = datapack.get('target')
biy = y.copy()
biy[y == 2] = 0

print(covar.empirical_covariance(x))
# print(biy)