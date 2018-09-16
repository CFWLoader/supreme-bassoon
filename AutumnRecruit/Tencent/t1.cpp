#include <iostream>
#include <vector>

using namespace std;

int gcd(int a, int b)
{
    if (a % b == 0)
    {
        return b;
    }
    else
    {
        return gcd(b, a % b);
    }
}

inline int lcm(int a, int b)
{
    return a * b / gcd(a, b);
}

int minLcmNum(int startNum)
{
    if(startNum < 3)
    {
        return startNum;
    }
    int seqLcm = 2;
    int lcmNo = 3;
    int nLcm = startNum + 1;
    for(;lcmNo <= nLcm; ++lcmNo)
    {
        seqLcm = lcm(seqLcm, lcmNo);
    }
    while(seqLcm != nLcm)
    {
        // cout << seqLcm << " " << nLcm << endl;
        seqLcm = lcm(seqLcm, lcmNo);
        nLcm = lcm(nLcm, lcmNo);
        ++lcmNo;
    }
    return lcmNo - 1;
}

int main(int argc, char* argv[])
{
    cout << minLcmNum(3) << endl;
    cout << minLcmNum(4) << endl;
    return 0;
}