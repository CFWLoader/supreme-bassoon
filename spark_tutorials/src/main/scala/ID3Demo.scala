import org.apache.spark.mllib.tree.DecisionTree
import org.apache.spark.mllib.evaluation.BinaryClassificationMetrics
import org.apache.spark.mllib.regression.LabeledPoint
import org.apache.spark.mllib.util.MLUtils
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.log4j.Logger
import org.apache.log4j.Level

/**
 *  决策时 -- ID3
 */
object ID3Demo {
  def main(args: Array[String]) {
    Logger.getLogger("org").setLevel(Level.OFF)
    Logger.getLogger("akka").setLevel(Level.OFF)
    val conf =new SparkConf()
    .setMaster("local")
    .setAppName("ID3Demo")
    // .setLogLevel("WARN")
    val sc=new SparkContext(conf)
    // sc.setLogLevel("OFF")
    // val data=MLUtils.loadLibSVMFile(sc,"src/main/resources/class_svm_data.txt")
    val data = MLUtils.loadLibSVMFile(sc,"src/main/resources/kr-vs-kp.txt")
    //val data=sc.textFile("")
    // Split data into training (60%) and test (40%)
    val Array(training, test) = data.randomSplit(Array(0.75, 0.25), seed = 11L)
    // training.cache()
    // val training = data
    // val test = data
 
    val numClasses=2 //设置分类数量
    val categoricalFeatureInfo=Map[Int,Int]() //设定输入格式
    val impurity="entropy" //设定信息增信计算公式
    val maxDepth=30  //设定树高度
    val maxBins=100   //设定分裂数据集
 
    val model=DecisionTree.trainClassifier(training,
      numClasses,
      categoricalFeatureInfo,
      impurity,
      maxDepth,
      maxBins)  //建立模型
    // println("model.depth:" + model.depth)
    // println("model.numNodes:" + model.numNodes)
    // println("model.topNode:" + model.topNode)
    val predictionsAndLabels = test.map { case LabeledPoint(label, features) =>
      val prediction = model.predict(features)
      (prediction, label)
    }
    val metrics = new BinaryClassificationMetrics(predictionsAndLabels)
    val precision = metrics.precisionByThreshold
    precision.foreach { case (t, p) =>
      println(s"Threshold: $t, Precision: $p")
    }
    val recall = metrics.recallByThreshold
    recall.foreach { case (t, r) => 
      println(s"Treshhold: $t, Recall: $r")
    }
    sc.stop()
  }
}

/*
结果：

model.depth:4
model.numNodes:11
model.topNode:id = 1, isLeaf = false, predict = 1.0 (prob = 0.625), impurity = 0.9544340029249649, split = Some(Feature = 0, threshold = 0.0, featureType = Continuous, categories = List()), stats = Some(gain = 0.04879494069539847, impurity = 0.9544340029249649, left impurity = 0.8112781244591328, right impurity = 1.0)

--------------------- 
作者：鲍礼彬 
来源：CSDN 
原文：https://blog.csdn.net/baolibin528/article/details/52802483 
版权声明：本文为博主原创文章，转载请附上博文链接！
*/