from sklearn.datasets import load_iris
import sklearn.covariance as covar
import sklearn.mixture as sklmix
import sklearn.linear_model as skllin
import sklearn.neighbors as sklnei
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix, roc_curve, roc_auc_score
import numpy as np
import pandas as pd

datapack = load_iris()

x = datapack.get('data')
y = datapack.get('target')
biy = y.copy()
biy[y == 2] = 0

# xdf = pd.DataFrame(data = x)
# print(xdf.corr())
# print(covar.empirical_covariance(x))
# print(biy)

# Gaussian mixture
train_X, test_X, train_y, test_y = train_test_split(
    x, biy, test_size=1/3, random_state=0)

mix_gua = sklmix.GaussianMixture(n_components=2)
mix_gua.fit(train_X, train_y)

val_prd = mix_gua.predict(test_X)

# print(confusion_matrix(test_y, val_prd))
# fpr, tpr, thres = roc_curve(test_y, val_prd)
# print(thres)

print(roc_auc_score(test_y, val_prd))

# Logistic Regression
lrm = skllin.LogisticRegression()

lrm.fit(train_X, train_y)

val_prd = lrm.predict(test_X)

print(roc_auc_score(test_y, val_prd))

# kNN model
knnm = sklnei.KNeighborsClassifier(n_neighbors= 15)

knnm.fit(train_X, train_y)

val_prd = knnm.predict(test_X)

print(roc_auc_score(test_y, val_prd))

# print(knnm.predict_proba(test_X))