#include <iostream>

using namespace std;

int maxLength(const char* str, size_t left, size_t right)
{
    size_t l = left, r = right;
    while(l < r and str[l] == str[r])
    {
        ++l, --r;
    }
    if(l >= r)
    {
        return right - left + 1;
    }
    int leftMax = maxLength(str, left + 1, right);
    int rightMax = maxLength(str, left, right - 1);
    return leftMax > rightMax ? leftMax : rightMax;
}

int main(int argc, char* argv[])
{
    string buf;
    while(cin >> buf)
    {
        cout << maxLength(buf.data(), 0, buf.size() - 1) << endl;
    }
    return 0;
}