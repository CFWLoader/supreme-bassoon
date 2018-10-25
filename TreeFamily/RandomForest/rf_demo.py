from sklearn.ensemble import RandomForestClassifier
from sklearn.datasets import make_classification

X, y = make_classification(n_samples=50000, n_features=20, n_informative= 2, n_redundant= 0, random_state= 0, shuffle= False)

rfclt = RandomForestClassifier(n_estimators= 20, max_depth= 5, random_state= 0)

rfclt.fit(X, y)

print(rfclt.feature_importances_)