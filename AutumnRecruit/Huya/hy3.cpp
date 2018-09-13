#include <iostream>

using namespace std;

int has1MoreThan3(size_t num)
{
    int cnt = 0;
    while(num != 0)
    {
        if(num & 1 == 1)
        {
            ++cnt;
        }
        else
        {
            cnt = 0;
        }
        if(cnt > 2)
        {
            return 1;
        }
        num >>= 1;
    }
    return 0;
}

int main(int argc, char* argv[])
{
    size_t cnt = 1;
    size_t maxNum;
    cin >> maxNum;
    for(size_t num = 1; num <= maxNum; ++num)
    {
        if(has1MoreThan3(num))
        {
            continue;
        }
        ++cnt;
    }
    cout << cnt << endl;
    return 0;
}