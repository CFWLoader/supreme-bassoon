#include<iostream>
#include <vector>

using namespace std;

// INCLUDE HEADER FILES NEEDED BY YOUR PROGRAM
// SOME LIBRARY FUNCTIONALITY MAY BE RESTRICTED
// DEFINE ANY FUNCTION 
// FUNCTION SIGNATURE BEGINS, THIS FUNCTION IS REQUIRED
int ringLength(vector<int>& ids, vector<int>& visited, int& startNum)
{
    if(startNum >= visited.size())return 0;
    int ringLen = 0;
    while(visited[startNum] == 1)++startNum;
    int visNum = startNum;
    while(visited[visNum] == 0)
    {
        visited[visNum] = 1;
        visNum = ids[visNum] - 1;
        ++ringLen;
    }
    // cout << visNum << endl;
    if(visNum == startNum)
    {
        return ringLen;
    }
    return -1;
}

vector<int> idsOfAlumni(int num, vector<int> ids)
{
    // WRITE YOUR CODE HERE
    if(ids.size() == 0)
    {
        return vector<int>();
    }
    vector<int> visited(num, 0);
    int ringLen, maxRingLen = 0, recIdx = -1;
    for(int idx = 0; idx < num;)
    {
        ringLen = ringLength(ids, visited, idx);
        if(ringLen > maxRingLen || ringLen > num / 2)
        {
            maxRingLen = ringLen;
            recIdx = idx;
        }
    }
    if(recIdx == -1)
    {
        return vector<int>();
    }
    // cout << recIdx << endl;
    vector<int> seats;
    seats.push_back(recIdx + 1);
    for(int idx = ids[recIdx] - 1; idx != recIdx; )
    {
        seats.push_back(idx + 1);
        idx = ids[idx] - 1;
    }
    return seats;
}
// FUNCTION SIGNATURE ENDS

void printVec(const vector<int>& vec)
{
    for(int idx = 0; idx < vec.size(); ++idx)
    {
        cout << vec[idx] << " ";
    }
    cout << endl;
}

int main(int argc, char* argv[])
{
    // vector<int> tc1({2, 3, 4, 1});
    // vector<int> tc1;tc1.push_back(2);tc1.push_back(3);tc1.push_back(4);tc1.push_back(1);
    // vector<int> tc1r = idsOfAlumni(4, tc1);
    vector<int> tc2;tc2.push_back(3);tc2.push_back(4);tc2.push_back(1);tc2.push_back(5);tc2.push_back(6);tc2.push_back(7);tc2.push_back(2);
    vector<int> tc2r = idsOfAlumni(7, tc2);
    printVec(tc2r);
}