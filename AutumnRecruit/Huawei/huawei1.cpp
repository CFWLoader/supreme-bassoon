#include <iostream>
#include <algorithm>

using namespace std;

string d26add(string& str1, string& str2)
{
    reverse(str1.begin(), str1.end());
    reverse(str2.begin(), str2.end());
    size_t cur = 0;
    size_t bitSum;
    string result;
    size_t idx = 0;
    for(; idx < str1.size() && idx < str2.size(); ++idx)
    {
        bitSum = str1[idx] - 'a' + str2[idx] - 'a' + cur;
        cur = bitSum / 26;
        bitSum %= 26;
        result += (bitSum + 'a');
    }
    if(idx == str1.size())
    {
        for(; idx < str2.size(); ++idx)
        {
            bitSum = str2[idx] - 'a' + cur;
            cur = bitSum / 26;
            bitSum %= 26;
            result += (bitSum + 'a');
        }
    }
    else
    {
        for(; idx < str1.size(); ++idx)
        {
            bitSum = str1[idx] - 'a' + cur;
            cur = bitSum / 26;
            bitSum %= 26;
            result += (bitSum + 'a');
        }
    }
    reverse(result.begin(), result.end());
    return result;
}

int main(int argc, char* argv[])
{
    string str1, str2;
    str1 = "z";
    str2 = "bc";

    cout << d26add(str1, str2) << endl;
}