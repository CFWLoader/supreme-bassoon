# 深度学习大纲

1. activation functions
2. BN
3. gradient explosion/vanish
4. rcnn history
5. inception
6. resnet framework
7. classical framework introduction
8. theory of LSTM
9. Loss: MSE, log, hinge, huber, exp, cross entropy, bi-classification cross entropy
10. L1, L2 Regularization
11. caffe, construct NN by TF
12. caffe detail:
    1.  effect of group parameter in Convolutional layer
    2.  if group is greater than 1, what will it lead?
    3.  im2col transform matrix
    4.  how group parameter do effects to im2col?
    5.  caffe pseudo codes.
13. PCA, SVM formula
14. Decision tree, boosting, bagging, GDBT introduction
15. custom loss function in your project, paper. visualize your network.
16. resblock
17. how to estimate accucary of models. precision, recall rate, true positive rate, f-measure, AUC, ROC, mAp
18. 降噪最大的问题是没有一个准确的标签，因为在应用场景的图片往往只能得到一个已经被加完噪声的图片，实际训练的时候往往是用高斯噪声模拟，你可以问问她这个方面是怎么解决的？更关键的问题是效果比别人好为啥只出了一个专利不出论文呢
19. 采用了怎样的网络结构进行了优化，baseline是什么，有了多大的提升，速度还是准确率，因为大概率是基于别人物体网络改的，可以问问是哪个网络，讲讲检测原理
20. 检测无非，RP，特征提取，目标位置回归。首先问她用的啥模型，要是faster rcnn之类的话，就问她smooth L1默写，anchor讲解。提到mask rcnn的话问这个算法的anchor与faster rcnn的区别
21. 要是用的SSD就问用多个尺度怎么实现的，最终的box作用是啥
22. 用的YOLO就问作者用到聚类聚类的是啥，你有没有在项目中重新聚类。YOLOv3了不了解，主要是想是啥