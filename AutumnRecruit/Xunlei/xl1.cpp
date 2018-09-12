#include <iostream>

using namespace std;

int main(int argc, char* argv[])
{
    int a, b;
    // cin >> a >> b;
    a = 4, b = -5;
    // 数据分0-6,7-9,10-16下标三部分考虑
    // 5,6,10,11插入的b可以被7-9区间共享
    // 优先满足0-6以及10-16区间的条件，当两个区间所需的b超过2个时候，则要开始考虑7-9区间插入b
    int numB = 1;
    for(; numB < 3; ++numB)
    {
        if((7 - numB) * a + numB * b < 0)
        {
            cout << (17 - numB * 2) * a + 2 * numB * b << endl;
            return 0;
        }
    }
    // b在7-9区间最多只能插入3个
    int extNumB = 1;
    for(; extNumB < 4; ++extNumB)
    {
        if((5 - extNumB) * a + (extNumB + 2) * b < 0)
        {
            cout << extNumB << endl;
            cout << (13 - extNumB * 3) * a + (4 + 3 * extNumB) * b << endl;
            return 0;
        }
    }
    // 2-14区间已经全部为b了，只剩考虑0，1，15，16下标填充
    numB = 1;
    for(; numB < 3; ++numB)
    {
        if((2 - numB) * a + (5 + numB) * b < 0)
        {
            cout << (4 - numB * 2) * a + (13 + 2 * numB) * b << endl;
            return 0;
        }
    }
    return 0;
}