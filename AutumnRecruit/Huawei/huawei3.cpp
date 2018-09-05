#include <iostream>
#include <map>
#include <vector>
#include <algorithm>

using namespace std;

struct StringComparator
{
public:
    int operator()(const string& str1, const string& str2)
    {
        if(str1.size() < str2.size())
        {
            return -1;
        }
        else if(str1.size() > str2.size())
        {
            return 1;
        }
        else
        {
            return -str1.compare(str2);
        }
    }
};

size_t extractString(const string& str, string& buf, size_t startIdx)
{
    char ch;
    size_t idx = startIdx;
    for(; idx < str.size(); ++idx)
    {
        ch = str[idx];
        if(ch >= 'a' && ch <= 'z' || ch >= 'A' && ch <= 'Z')
        {
            buf += ch;
        }
        else
        {
            break;
        }
    }
    return idx - startIdx;
}

size_t extractNumber(const string& str, int& num, size_t startIdx)
{
    num = 0;
    size_t idx = startIdx;
    while(idx < str.size() && str[idx] >= '0' && str[idx] <= '9')
    {
        num = num * 10 + str[idx] - '0';
        ++idx;
    }
    return idx - startIdx;
}

string decode(const string& str)
{
    string temp;
    map<int, vector<string> > cntMap;
    size_t byteCnt;
    int cnt;
    for(size_t idx = 0; idx < str.size(); idx += byteCnt)
    {
        temp = "";
        byteCnt = extractString(str, temp, idx);
        idx += byteCnt;
        byteCnt = extractNumber(str, cnt, idx);
        cntMap[cnt].push_back(temp);
    }
    string result;
    StringComparator comparator;
    for(typename map<int, vector<string> >::iterator iter = cntMap.begin();
        iter != cntMap.end();
        ++iter
    )
    {
        // cout << iter->first << endl;
        sort(iter->second.begin(), iter->second.end(), comparator);
        for(typename vector<string>::iterator sIter = iter->second.begin();
            sIter != iter->second.end();
            ++sIter)
            {
                for(size_t copiedCnt = 0; copiedCnt < iter->first; ++copiedCnt)
                {
                    result += *sIter;
                }
            }
    }
    return result;
}

int main(int argc, char* argv[])
{
    // string testcase1("a11b2bac3bad3abcd2");
    // string result1("bbabcdabcdbacbacbacbadbadbadaaaaaaaaaaa");
    string instring;
    cin >> instring;
    string tcres1 = decode(instring);
    cout << tcres1 << endl;
    return 0;
}