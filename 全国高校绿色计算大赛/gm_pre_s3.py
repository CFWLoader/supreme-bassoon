import pandas as pd
import numpy as np
# import sklearn as skl
from sklearn.linear_model import LogisticRegression
import os

script_dir = os.path.dirname(os.path.realpath(__file__))

output_dir = os.path.join(script_dir, "outputFiles", "test_prediction.csv")
# output_dir = 'src/step1/ground_truth/test_prediction.csv'

train = pd.read_csv(os.path.join(script_dir, "inputFiles", "train.csv"))
test = pd.read_csv(os.path.join(script_dir, "inputFiles", "test.csv"))

# output_dir = 'src/step1/ground_truth/test_prediction.csv'

train_mat = train.values[:, 1:74]
train_y = train.values[:, -1]
test_mat = test.values[:, 1::]

lmlr = LogisticRegression()
lmlr.fit(train_mat, train_y)

testprdy = lmlr.predict(test_mat)
trainprdy = lmlr.predict(train_mat)

outputdf = pd.DataFrame({'ID': test['ID'].values, 'TARGET': testprdy})

outputdf.to_csv(output_dir, index=False)

# outputdf = pd.merge(outputdf, pd.DataFrame(data= dict(){'TARGET': testprdy}))

# print(testprdy)

# ptcnt = 0
# pcnt = 0

# for i in range(0, len(trainprdy)):
#     if trainprdy[i] == train_y[i]:
#         ptcnt += 1

# for i in range(0, len(testprdy)):
#     if testprdy[i] == test_y[i]:
#         pcnt += 1

# print(ptcnt / len(trainprdy))
# print(pcnt / len(testprdy))

# print(train.shape)
# print(train_y.shape)