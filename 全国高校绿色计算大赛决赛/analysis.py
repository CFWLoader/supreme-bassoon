import pandas as pd
import numpy as np
import os


def sigmoid(inX):
    return 1.0 / (1 + np.exp(-inX))


def logistic_model(xmat, y, m, n, k):
    # 更新权值，k是循环次数
    X = xmat.T
    Y = y
    params = np.mat(np.ones(n))  # 初始化权重矩阵
    for i in range(k):
        params = params - 0.2 / m * (sigmoid(params * X) - Y) * X.T  # 更新公式
    return params


def logistic_predict(testData, theta):
    return sigmoid(np.dot(testData, theta))

def center_data(trainmat):
    meanvals = np.mean(trainmat, axis=0)  # 按列求均值
    centered = trainmat - meanvals
    return centered, meanvals


def pca(trainmat, n, testmat):
    newData, meanvals = center_data(trainmat)
    covmat = np.cov(newData, rowvar=False)
    eigvals, eigvects = np.linalg.eig(np.mat(covmat))   # 求特征值和特征向量,特征向量按列存放
    eigvalindice = np.argsort(eigvals)                  # 对特征值排序
    neigvalindice = eigvalindice[-1:-(n + 1):-1]        # 最大的n个特征值的下标
    neigvect = eigvects[:, neigvalindice]               # 最大的n个特征值对应的特征向量
    trainpcamat_c = newData * neigvect                  # 降维的数据
    trainpcamat = (trainpcamat_c * neigvect.T) + meanvals  # 重构数据
    testmat_c, tmeanvals = center_data(testmat)
    testpcamat_c = testmat_c * neigvect
    testpcamat = (testpcamat_c * neigvect.T) + tmeanvals
    return trainpcamat_c, trainpcamat, testpcamat_c, testpcamat


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
    attrnum = len(raw_srcinput.columns)
    trainx = raw_srcinput.iloc[:, 1: attrnum - 1].values
    trainy = raw_srcinput.iloc[:, attrnum - 1].values
    testx = raw_testinput.iloc[:, 1: attrnum - 1].values
    # params, residuals, rank, singulars = np.linalg.lstsq(trainx, trainy, rcond=None)
    # 0-1归一化
    trainmin = trainx.min(axis= 0)
    trainmax = trainx.max(axis= 0)
    unify_trainx = np.mat(np.ones(trainx.shape))
    unify_testx = np.mat(np.ones(testx.shape))
    for idx in range(0, len(trainmax)):
        denom = trainmax[idx] - trainmin[idx]
        if(denom != 0):
            normdata = (trainx[:, idx] - trainmin[idx]) / denom
            unify_trainx[:, idx] = normdata.reshape(-1, 1)
            normdata = (testx[:, idx] - trainmin[idx]) / denom
            unify_testx[:, idx] = normdata.reshape(-1, 1)
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
    train_pcmat, train_pmat, test_pcmat, test_pmat = pca(unify_trainx, 40, unify_testx)
    ftrainx = train_pmat
    ftestx = test_pmat
    # print(np.max(ftrainx, axis=0))
    nrows, ncols = ftrainx.shape
    params = logistic_model(ftrainx, trainy, nrows, ncols, 2000)
    # print(params)
    testy = logistic_predict(ftestx, params.T)
    print(np.max(testy))
    print(np.min(testy))
    # outputdf = raw_testinput[['ID']]
    # outputdf.insert(1, column = 'TARGET', value = testy)
    # outputdf.to_csv(path_or_buf= testoutpath, index= None, encoding = 'utf-8')
    ########## End ##########


getPrediction()
