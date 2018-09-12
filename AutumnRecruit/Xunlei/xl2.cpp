#include <iostream>
#include <cmath>

using namespace std;

bool gcd(int a, int b)
{
    int tmp;
    while(b != 0)
    {
        tmp = b;
        b = a % b;
        a = tmp;
    }
    return a == 1;
}

int main(int argc, char* argv[])
{
    int num = 10, c;
    int cnt = 0;
    for(int a = 1; a <= 10; ++a)
    {
        for(int b = a + 1; b <= 10; ++b)
        {
            c = int(sqrt(a * a + b * b));
            if(c > num || c * c != a * a + b * b)
            {
                continue;
            }
            if(gcd(a, b) && gcd(a, c) && gcd(b, c))
            {
                // cout << a << " " << b << " " << c << endl;
                ++cnt;
            }
        }
    }

    return 0;
}