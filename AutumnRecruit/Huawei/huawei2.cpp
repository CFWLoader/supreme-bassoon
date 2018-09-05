#include <iostream>
#include <string>

using namespace std;

bool contains(const string& str1, const string& str2)
{
    int cntMap[256];
    for(int idx = 0; idx < str1.size(); ++idx)
    {
        ++cntMap[str1[idx]];
    }
    for(int idx = 0; idx < str2.size(); ++idx)
    {
        if(cntMap[str2[idx]] == 0)
        {
            return false;
        }
    }
    return true;
}

int main(int argc, char* argv[])
{
    string str1, str2;
    cin >> str1 >> str2;
    string result(contains(str1, str2) ? "true" : "false");
    cout << result << endl;
    return 0;
}
