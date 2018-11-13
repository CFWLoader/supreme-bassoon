import pandas as pd
import numpy as np
import os

def gauss_bayes(trainx, y, testx):
    classTprob = np.count_nonzero(y) / y.shape[0]
    classFprob = 1 - classTprob
    # print(class1num)
    classTtrain = trainx[y == 1]
    classFtrain = trainx[y != 1]
    classTmeans = classTtrain.mean(axis= 0).reshape(-1, 1)
    classTstd = classTtrain.std(axis= 0).reshape(-1, 1)
    classFmeans = classFtrain.mean(axis= 0).reshape(-1, 1)
    classFstd = classFtrain.std(axis= 0).reshape(-1, 1)
    # print(classTmeans.shape)
    nrow, ncol = testx.shape
    testy = np.ndarray((y.shape[0]))
    for row in range(0, nrow):
        pct = 1
        pcf = 1
        for feaIdx in range(0, ncol):
            numer = - (testx[row, feaIdx] - classTmeans[feaIdx, 0])
            if classTstd[feaIdx, 0] != 0:
                numer = np.exp(numer / (2 * classTstd[feaIdx, 0] * classTstd[feaIdx, 0]))
                denom = (np.sqrt(2 * np.pi) * classTstd[feaIdx, 0])
                pct *= numer / denom
            numer = - (testx[row, feaIdx] - classFmeans[feaIdx, 0])
            if classFstd[feaIdx, 0] != 0:
                numer = np.exp(numer / (2 * classFstd[feaIdx, 0] * classFstd[feaIdx, 0]))
                denom = (np.sqrt(2 * np.pi) * classFstd[feaIdx, 0])
                pcf *= numer / denom
        if pct * classTprob >= pcf * classFprob:
            testy[row] = pct * classTprob
        else:
            testy[row] = 1 - pcf * classFprob
    return testy / nrow

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
    # trainmin = trainx.min(axis= 0)
    # trainmax = trainx.max(axis= 0)
    # unify_trainx = np.mat(np.ones(trainx.shape))
    # unify_testx = np.mat(np.ones(testx.shape))
    # for idx in range(0, len(trainmax)):
    #     denom = trainmax[idx] - trainmin[idx]
    #     if(denom != 0):
    #         normdata = (trainx[:, idx] - trainmin[idx]) / denom
    #         unify_trainx[:, idx] = normdata.reshape(-1, 1)
    #         normdata = (testx[:, idx] - trainmin[idx]) / denom
    #         unify_testx[:, idx] = normdata.reshape(-1, 1)
    # 正态归一化
    trainave = np.mean(trainx, axis=0)
    trainstd = np.std(trainx, axis=0)
    unify_trainx = np.mat(np.ones(trainx.shape))
    unify_testx = np.mat(np.ones(testx.shape))
    for idx in range(0, len(trainave)):
        if(trainstd[idx] != 0):
            normdata = (trainx[:, idx] - trainave[idx]) / trainstd[idx]
            unify_trainx[:, idx] = normdata.reshape(-1, 1)
            normdata = (testx[:, idx] - trainave[idx]) / trainstd[idx]
            unify_testx[:, idx] = normdata.reshape(-1, 1)
    testy = gauss_bayes(unify_trainx, trainy, unify_testx)
    print(np.min(testy))
    print(np.max(testy))
    # outputdf = raw_testinput[['ID']]
    # outputdf.insert(1, column = 'TARGET', value = testy)
    # outputdf.to_csv(path_or_buf= testoutpath, index= None, encoding = 'utf-8')
    ########## End ##########


getPrediction()
