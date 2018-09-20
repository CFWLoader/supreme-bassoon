#include <iostream>
#include <vector>

using namespace std;

int bruteForceMatch(const string& word, const vector<vector<char>>& chMat, int wordIdx, int row, int col, const int nrow, const int ncol, const int wordSize)
{
    if(wordSize == wordIdx)return 1;
    else if(word[wordIdx] != chMat[row][col])return 0;
    int result = 0;
    if(row > 0)
    {
        result = bruteForceMatch(word, chMat, wordIdx + 1, row - 1, col, nrow, ncol, wordSize);
    }
    if(!result and row < nrow - 1)
    {
        result = bruteForceMatch(word, chMat, wordIdx + 1, row + 1, col, nrow, ncol, wordSize);
    }
    if(!result and col > 0)
    {
        result = bruteForceMatch(word, chMat, wordIdx + 1, row, col - 1, nrow, ncol, wordSize);
    }
    if(!result and col < ncol - 1)
    {
        result = bruteForceMatch(word, chMat, wordIdx + 1, row + 1, col, nrow, ncol, wordSize);
    }
    return result;
}

int main(int argc, char* argv[])
{
    int nrow, ncol, numWord;
    cin >> ncol >> nrow >> numWord;
    vector<string> words(numWord);
    vector<vector<char>> charMatrix;
    for(int n = 0; n < numWord; ++n)
    {
        cin >> words[n];
    }
    for(int row = 0; row < nrow; ++row)
    {
        charMatrix.emplace_back(vector<char>(ncol));
        for(int col = 0; col < ncol; ++col)
        {
            cin >> charMatrix[row][col];
        }
    }
    for(int n = 0; n < numWord; ++n)
    {
        for(int row = 0; row < nrow; ++row)
        {
            for(int col = 0; col < ncol; ++col)
            {
                if(words[n][0] == charMatrix[row][col] and bruteForceMatch(words[n], charMatrix, 0, row, col, nrow, ncol, words[n].size()))
                {
                    cout << words[n] << endl;
                }
            }
        }
    }
    return 0;
}