#include <iostream>

using std::cin;
using std::cout;
using std::endl;

int findRouteAndMaxCost(int* cost, int* edges, int numNode)
{
    int maxCost = 0;
    int curCost, numRoutes = 0;
    int idx, next;
    for(int startIdx = numNode; startIdx > 0; --startIdx)
    {
        if(edges[startIdx] == -1)
        {
            continue;
        }
        idx = startIdx;
        curCost = cost[idx];
        ++numRoutes;
        while(edges[idx] != -1)
        {
            next = edges[idx];
            edges[idx] = -1;
            curCost += cost[next];
            idx = next;
        }
        if(curCost > maxCost)
        {
            maxCost = curCost;
        }
    }
    cout << numRoutes << " " << maxCost;
    return 0;
}

int main(int argc, char *argv[])
{
    size_t numNode, numEdge;
    cin >> numNode >> numEdge;
    int* cost = new int[numNode + 1];
    int* edges = new int[numNode + 1];
    edges[0] = -1;
    for (int idx = 1; idx <= numNode; ++idx)
    {
        cin >> cost[idx];
        edges[idx] = -1;
    }
    int start, end;
    for(int edgeIdx = 0; edgeIdx < numEdge; ++ edgeIdx)
    {
        cin >> start >> end;
        edges[end] = start;
    }
    findRouteAndMaxCost(cost, edges, numNode);
    delete[] cost;
    delete[] edges;
    return 0;
}