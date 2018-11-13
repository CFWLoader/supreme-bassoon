'''
本地跑都很耗时，没有提交
'''
import pandas as pd
import numpy as np
import os

def MAE(set):
    y = set['TARGET'].values
    return np.mean([abs(yi-np.mean(y)) for yi in y])

class tree_node(object):
    def __init__(self,set = None,mae = None, col = None,value = None, result = None,tb = None, fb = None):
        self.set = set
        self.mae = mae
        self.col = col
        self.value = value
        self.result = result
        self.tb = tb
        self.fb = fb

def build_tree(data):
    cols = data.drop('TARGET',axis = 1).columns
    t = tree_node()
    #数据集
    t.set = data
    #该节点的mae，同样只适用于叶节点，如果节点被划分则归零
    t.mae = MAE(data)
    delta_mae = 0
    for col in cols:#遍历特征
        for value in data[col]:#遍历所有特征取值，对于大的数据集可以使用set()或者转换为字典来去重
            set1 = data[data[col]>=value]
            set2 = data[data[col]<value]
            if len(set1)>0 and len(set2)>0:
                new_mae = (MAE(set1)*len(set1) + MAE(set2)*len(set2))/len(data)
                new_delta_mae = t.mae - new_mae
                if delta_mae < new_delta_mae:
                    delta_mae = new_delta_mae
                    t.mae = new_mae
                    t.col = col
                    t.value = value
    #判断是否能够进行划分
    if t.col != None:
        t_tree = build_tree(data[data[t.col]>=t.value])
        f_tree = build_tree(data[data[t.col]<t.value])
        return tree_node(col = t.col,value = t.value,tb = t_tree,fb = f_tree)
    else:
        #该节点的平均值，只适用于叶节点
        t.result = data['y'].mean()
        return tree_node(result = t.result,set = t.set)

def classify(row,tree):
    #样本单个单个地通过决策树
    #如果是叶节点
    if tree.result != None:
        return tree.result
    else:
        if row[tree.col] >= tree.value:
            branch = tree.tb
        elif row[tree.col] < tree.value:
            branch = tree.fb
        return classify(row,branch)

# *********************数据说明***********************
# 训练数据：src/step1/input/train.csv
# 测试数据：src/step1/input/test.csv
# 结果文件：src/output/test_prediction.csv
# ***************************************************
def getPrediction():
    ########## Begin ##########
    ### local path
    script_dir = os.path.dirname(os.path.realpath(__file__))
    srcpath = os.path.join(script_dir, 'input', 'train.csv')
    testpath = os.path.join(script_dir, 'input', 'test.csv')
    testoutpath = os.path.join(script_dir, 'output', 'test_prediction.csv')
    ### Path in validator matchine
    # srcpath = 'src/step1/input/train.csv'
    # testpath = 'src/step1/input/test.csv'
    # testoutpath = 'src/output/test_prediction.csv'
    raw_srcinput = pd.read_csv(srcpath)
    raw_testinput = pd.read_csv(testpath)
    for colmn in raw_srcinput.columns:
        if colmn in ["ID", "TARGET"]:
            continue
        max_data = max(list(raw_srcinput[colmn]))
        min_data = min(list(raw_srcinput[colmn]))
        raw_srcinput[colmn] = (raw_srcinput[colmn] - min_data) / (max_data - min_data)
        raw_testinput[colmn] = (raw_testinput[colmn] - min_data) / (max_data - min_data)
        # print(train[colmn])

    # 正态归一化
    # trainave = np.mean(trainx, axis=0)
    # trainstd = np.std(trainx, axis=0)
    # unify_trainx = np.mat(np.ones(trainx.shape))
    # unify_testx = np.mat(np.ones(testx.shape))
    # for idx in range(0, len(trainave)):
    #     if(trainstd[idx] != 0):
    #         normdata = (trainx[:, idx] - trainave[idx]) / trainstd[idx]
    #         unify_trainx[:, idx] = normdata.reshape(-1, 1)
    #         normdata = (testx[:, idx] - trainave[idx]) / trainstd[idx]
    #         unify_testx[:, idx] = normdata.reshape(-1, 1)
    tree = build_tree(raw_srcinput)
    for i, row in raw_testinput.iterrows():
        print(classify(row, tree))
    # outputdf = raw_testinput[['ID']]
    # outputdf.insert(1, column = 'TARGET', value = np.around(testy, decimals= 1))
    # outputdf.to_csv(path_or_buf= testoutpath, index= None, encoding = 'utf-8')
    ########## End ##########


getPrediction()
