#include <iostream>
#include <vector>
#include <map>

using namespace std;

int main(int argc, char* argv[])
{
    size_t numStr, strIdx;
    // cin >> numStr;
    // vector<string> inputStr(numStr);
    numStr = 5;
    vector<string> inputStr(numStr);
    inputStr[0] = "bytedance";
    inputStr[1] = "toutiaohao";
    inputStr[2] = "toutiaoapp";
    inputStr[3] = "iesaweme";
    inputStr[4] = "iestiktok";
    map<string, int> prefixRec;
    for(size_t cnt = 0; cnt < numStr; ++cnt)
    {
        // cin >> inputStr[cnt];
        strIdx = 1;
        for(; strIdx <= inputStr[cnt].size(); ++strIdx)
        {
            if(prefixRec[string(inputStr[cnt].begin(), inputStr[cnt].begin() + strIdx)] == 0)
            {
               break;
            }
        }
        prefixRec[string(inputStr[cnt].begin(), inputStr[cnt].begin() + strIdx)] = 1;
    }
    for(size_t cnt = 0; cnt < numStr; ++cnt)
    {
        strIdx = 1;
        for(; strIdx <= inputStr[cnt].size(); ++strIdx)
        {
            if(prefixRec[string(inputStr[cnt].begin(), inputStr[cnt].begin() + strIdx)] == 0)
            {
               break;
            }
        }
        cout << string(inputStr[cnt].begin(), inputStr[cnt].begin() + strIdx) << endl;
    }
    return 0;
}