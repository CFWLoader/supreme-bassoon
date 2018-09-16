#include <iostream>

using namespace std;

bool passTest(int a, int b, int c)
{
    if(a % b == 0 && c == 0)
    {
        return true;
    }
    else if(a % b == 0 && c != 0)
    {
        return false;
    }
    int base = a % b, multiplier = 1;
    for(; multiplier <= b; ++multiplier)
    {
        if((base * multiplier) % b == c)
        {
            return true;
        }
    }
    return false;
}

int main(int argc, char* argv[])
{
    int numCases, a, b, c;
    cin >> numCases;
    for(int idx = 0; idx < numCases; ++idx)
    {
        cin >> a >> b >> c;
        cout << (passTest(a, b, c) ? "YES" : "NO") << endl;
    }
    return 0;
}