#include <iostream>
#include "ccc1.h"

using namespace std;

extern int aaa;

class MemCls
{
public:
    MemCls()
    {
        cout << "MemCls::MemCls()" << endl;
    }
};

class StaMem
{
public:
    StaMem()
    {
        cout << "StaMem::MemCls()" << endl;
    }
};

class ComCls
{
public:
    ComCls()
    {
        cout << "ComCls::ComCls()" << endl;
    }
private:
    MemCls memCls;
    static StaMem staMem;
};

StaMem ComCls::staMem = StaMem();

int main(int argc, char* argv[])
{
    cout << aaa << endl;
    // cout << "main()" << endl;
    // ComCls cc1;
    return 0;
}