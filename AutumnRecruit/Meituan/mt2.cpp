#include <iostream>
#include <map>

using namespace std;

bool qualify(const map<int, int>& cntMap, int thres)
{
    for(typename map<int,int>::const_iterator iter = cntMap.begin(); iter != cntMap.end(); ++iter)
    {
        if(iter->second >= thres)
        {
            return true;
        }
    }
    return false;
}

int main(int argc, char* argv[])
{
    map<int, int> cntMap;
    int nums[10001];
    int n, k, t;
    int invCnt = 0;
    cin >> n >> k >> t;
    int i = 0;
    for(; i < k; ++i)
    {
        cin >> nums[i];
        ++cntMap[nums[i]];
    }
    if(qualify(cntMap, t)) ++invCnt;
    for(; i < n; ++i)
    {
        cin >> nums[i];
        --cntMap[nums[i - k]];
        ++cntMap[nums[i]];
        if(qualify(cntMap, t)) ++invCnt;
    }
    cout << invCnt << endl;
    return 0;
}