#include <iostream>

using namespace std;

size_t combisFun(size_t n, size_t m)
{
    size_t result = n;
    for(size_t i = 1; i <= m; ++i)
    {
        result *= (n - i + 1);
        result /= i;
    }
    return result;
}

int main(int argc, char* argv[])
{
    size_t k, la, lb, na, nb;
    // cin >> k >> la >> na >> lb >> nb;
    k = 5, la = 2, na = 3, lb = 3, nb = 3;
    size_t combis = 0, combisA = 1, combisB = 1;
    size_t limA = k / la >= na ? na : k / la;
    size_t tmp;
    // combisA = combisFun(na, limA);
    for(size_t numA = 0; numA <= na; ++numA)
    {
        tmp = k - numA * la;
        if(tmp%lb == 0)
        {
            // cout << numA << endl;
            combis += combisFun(na, numA) * combisFun(nb, tmp / lb);
        }
    }
    cout << combis % 1000000007 << endl;
    return 0;
}