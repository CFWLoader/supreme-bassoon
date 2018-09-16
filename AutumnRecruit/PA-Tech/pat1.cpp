#include <iostream>
#include <vector>
#include <map>

using namespace std;

int treeHeight(map<int, vector<int>>& tree, int treeNo)
{
    if(tree[treeNo].size() == 0)
    {
        return 1;
    }
    int subTreeHeight = 0, tmpTreeHeight;
    for(auto childNo : tree[treeNo])
    {
        tmpTreeHeight = treeHeight(tree, childNo);
        if(tmpTreeHeight > subTreeHeight)
        {
            subTreeHeight = tmpTreeHeight;
        }
    }
    return subTreeHeight + 1;
}

int main(int argc, char* argv[])
{
    map<int, vector<int>> tree;
    int src, dest;
    while(cin >> src >> dest)
    {
        tree[src].emplace_back(dest);
    }
    cout << treeHeight(tree, tree.begin()->first) << endl;
    return 0;
}