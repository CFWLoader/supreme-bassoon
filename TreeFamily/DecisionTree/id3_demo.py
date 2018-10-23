from sklearn import tree
from sklearn.datasets import load_iris
import graphviz
import os

dir_path = os.path.dirname(os.path.realpath(__file__))

iris_data = load_iris()

clf = tree.DecisionTreeClassifier(criterion="gini")
clf = clf.fit(iris_data.data, iris_data.target)

print(clf.score(iris_data.data, iris_data.target))

# dot_data = tree.export_graphviz(clf, out_file=os.path.join(dir_path, "tree.dot"), 
#     feature_names=iris_data.feature_names, class_names=iris_data.target_names,
#     filled=True, rounded=True, special_characters=True)