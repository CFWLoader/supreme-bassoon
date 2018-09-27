/**
 * AC 67% cases.
 */
#include <iostream>

using namespace std;

int combineNumbers(int curNum, int maxNum, int target)
{
    if(curNum == maxNum + 1 and target != 0)return 0;
    else if(curNum == maxNum + 1 and target == 0)return 1;
    int methodsSum = 0;
    int comNum = curNum;
    for(int num = curNum + 1; num <= maxNum + 1; ++num)
    {
        // cout << comNum << endl;
        methodsSum += combineNumbers(num, maxNum, target - comNum);	// 加法
        methodsSum += combineNumbers(num, maxNum, target + comNum); // 减法
        comNum = comNum * 10 + num;	// 插空格
    }
    return methodsSum;
}

int main(int argc, char* argv[])
{
    int maxNum = 7, target = 0;
    // cin >> maxNum >> target;
    cout << combineNumbers(1, maxNum, target) / 2 << endl;
    return 0;
}