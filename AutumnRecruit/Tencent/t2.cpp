#include <iostream>
#include <vector>

using namespace std;

static int matrix[1000][1000] = {{0}};
static int inDegree[1000] = {0};
static int outDegree[1000] = {0};

int dfs(int cityNo, vector<bool>& visited, const int maxCityNo)
{
    visited[cityNo] = true;
    int destCount = 0;
    for(int neigh = 0; neigh < maxCityNo; ++neigh)
    {
        if(!visited[neigh] && matrix[cityNo][neigh])
        {
            inDegree[neigh] += 1;
            destCount = destCount + 1 + dfs(neigh, visited, maxCityNo);
        }
    }
    return destCount;
}

void bruteForce(int startNo, int maxCityNo)
{
    vector<bool> visited(maxCityNo, false);
    outDegree[startNo] = dfs(startNo, visited, maxCityNo);
}

int stats(int maxCityNo)
{
    int cnt = 0;
    for(int idx = 0; idx < maxCityNo; ++idx)
    {
        if(inDegree[idx] > outDegree[idx])
        {
            ++cnt;
        }
    }
    return cnt;
}

int main(int argc, char* argv[])
{
    int numCity, numRoad, srcNo, destNo;
    cin >> numCity >> numRoad;
    for(int rdIdx = 0; rdIdx < numRoad; ++rdIdx)
    {
        cin >> srcNo >> destNo;
        matrix[srcNo - 1][destNo - 1] = 1;
    }
    for(int cityIdx = 0; cityIdx < numCity; ++cityIdx)
    {
        bruteForce(cityIdx, numCity);
    }
    cout << stats(numCity) << endl;
    return 0;
}