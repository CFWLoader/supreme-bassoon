#include <stack>
#include <iostream>

using namespace std;

string finalizePath(string& path)
{
    typename string::iterator startIter = path.begin();
    typename string::iterator iter = path.begin();
    stack<string> pathStack;
    string tmp;
    for(; iter != path.end(); ++iter)
    {
        if(*iter == '/')
        {
            if(startIter < iter)
            {
                tmp = string(startIter, iter);
                // cout << tmp << endl;
                if(tmp == ".")
                {
                }
                else if(tmp == "..")
                {
                    pathStack.pop();
                }
                else
                {
                    pathStack.push(tmp);
                }
            }
            startIter = iter + 1;
        }
    }
    tmp = "";
    while(!pathStack.empty())
    {
        tmp = tmp + string(pathStack.top().rbegin(), pathStack.top().rend()) + '/';
        pathStack.pop();
    }
    return string(tmp.rbegin(), tmp.rend());
}

int main(int argc, char* argv[])
{
    string testcase1("/a/././b//../../c/");
    cout << finalizePath(testcase1) << endl;
    string testcase2("/home/");
    cout << finalizePath(testcase2) << endl;
    return 0;
}