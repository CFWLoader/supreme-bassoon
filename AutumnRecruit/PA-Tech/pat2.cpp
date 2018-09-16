#include <iostream>
// #include <map>
#include <algorithm>
#include <vector>

using namespace std;

/**
 * Test Case 1 input:
 * Bob 95 95
 * Ally 100 90 95
 * Li 92 86
 * Cat 98 99
 * Wang 99
 * ***** output *****
 * Wang 99
 * Cat 99
 * Bob 95
 * Ally 95
 * Li 89
 */

bool isDigit(const string& str)
{
    for(auto ch : str)
    {
        if(ch < '0' or ch > '9')
        {
            return false;
        }
    }
    return true;
}

int transInt(const string& str)
{
    int result = 0;
    for(auto ch : str)
    {
        result = result * 10 + (ch - '0');
    }
    return result;
}

struct CustomComparator
{
    bool operator()(const pair<string, double>& a, const pair<string, double>& b)
    {
        return a.second > b.second;
    }
};

int main(int argc, char* argv[])
{
    string buf, nameBuf;
    vector<pair<string, int>> records;
    // map<int, vector<string>> records;
    int sums = 0, cnt = 0, tmp;
    cin >> nameBuf;
    while(cin >> buf)
    {
        if(isDigit(buf) and cnt > 0)
        {
            // records.emplace_back(nameBuf, (rec[0] + rec[1] + rec[2]) / cnt);
            tmp = sums / double(cnt);
            //records[tmp].push_back(nameBuf);
            records.emplace_back(nameBuf, tmp);
            sums = cnt = 0;
            nameBuf = buf;
        }
        /*
        else if((!isDigit(buf)) and nameBuf.size() > 0 and cnt == 0)
        {
            records.emplace_back(nameBuf, 0);
            sums = cnt = 0;
            nameBuf = buf;
        }
        */
        else
        {
            sums += transInt(buf);
            ++cnt;
        }
    }
    sort(records.begin(), records.end(), CustomComparator());
    for(auto ele : records)
    {
        // printf("%s $d\n", ele.first.data(), ele.second);
        cout << ele.first << " " << static_cast<int>(ele.second) << endl;
    }
    /*
    for(auto rIter = records.rbegin(); rIter != records.rend(); ++rIter)
    {
        for(auto nameVar : rIter->second)
        {
            cout << nameVar << " " << rIter->first << endl;
        }
    }
    */
    return 0;
}