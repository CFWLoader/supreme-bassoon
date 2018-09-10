#include<iostream>
#include<map>

using namespace std;

int main(int argc, char* argv[])
{
    int arr[10000];//, sums[10000];
    int arrLen;
    map<int, int> cntMap, sumMap;
    cin >> arrLen;
    for(int idx = 0; idx < arrLen; ++idx)
    {
        cin >> arr[idx];
        if(cntMap[arr[idx]] == 0)
        {
            cntMap[arr[idx]] = 1;
        }
        else
        {
            ++cntMap[arr[idx]];
        }
    }
    // arrLen = 4;
    // arr[0] = 5, arr[1] = 4, arr[2] = 2, arr[3] = 9;
    // for(int idx = 0; idx < arrLen; ++idx)
    // {
    //     if(cntMap[arr[idx]] == 0)
    //     {
    //         cntMap[arr[idx]] = 1;
    //     }
    //     else
    //     {
    //         ++cntMap[arr[idx]];
    //     }
    // }
    int sumVal = 0, preVal = 0;
    map<int, int>::iterator iter = cntMap.begin();
    for(;iter != cntMap.end(); ++iter)
    {
        sumVal += iter->second * preVal;
        sumMap[iter->first] = sumVal;
        preVal = iter->first;
    }
    for(int idx = 0; idx < arrLen; ++idx)
    {
        cout << sumMap[arr[idx]] << endl;
    }
    return 0;
}