// import org.apache.spark.mllib.tree.DecisionTree
import org.apache.spark.mllib.tree.RandomForest
import org.apache.spark.mllib.evaluation.BinaryClassificationMetrics
import org.apache.spark.mllib.regression.LabeledPoint
import org.apache.spark.mllib.util.MLUtils
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.log4j.Logger
import org.apache.log4j.Level

/**
 *  决策时 -- ID3
 */
object RandomForestDemo {
  def main(args: Array[String]) {
    Logger.getLogger("org").setLevel(Level.OFF)
    Logger.getLogger("akka").setLevel(Level.OFF)
    val conf =new SparkConf()
    .setMaster("local")
    .setAppName("RandomForestDemo")
    // .setLogLevel("WARN")
    val sc=new SparkContext(conf)
    // sc.setLogLevel("OFF")
    // val data=MLUtils.loadLibSVMFile(sc,"src/main/resources/class_svm_data.txt")
    val data = MLUtils.loadLibSVMFile(sc,"src/main/resources/kr-vs-kp.txt")
    //val data=sc.textFile("")
    // Split data into training (60%) and test (40%)
    val Array(training, test) = data.randomSplit(Array(0.6, 0.4), seed = 11L)
    // training.cache()
    // val training = data
    // val test = data
 
    val numClasses = 2 //设置分类数量
    val categoricalFeaturesInfo = Map[Int,Int]() //设定输入格式
    val numTrees = 2
    val featureSubsetStrategy = "auto" // Let the algorithm choose.
    val impurity = "gini"
    val maxDepth=4  //设定树高度
    val maxBins=32   //设定分裂数据集
 
    val model = RandomForest.trainClassifier(training, numClasses, categoricalFeaturesInfo,
            numTrees, featureSubsetStrategy, impurity, maxDepth, maxBins) //建立模型
    // println("model.depth:" + model.depth)
    // println("model.numNodes:" + model.numNodes)
    // println("model.topNode:" + model.topNode)
    val predictionsAndLabels = test.map { case LabeledPoint(label, features) =>
      val prediction = model.predict(features)
      (prediction, label)
    }
    val metrics = new BinaryClassificationMetrics(predictionsAndLabels)
    val testErr = predictionsAndLabels.filter(r => r._1 != r._2).count.toDouble / test.count()
    println(s"Test Error = $testErr")
    // println(s"Learned classification forest model:\n ${model.toDebugString}") 
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