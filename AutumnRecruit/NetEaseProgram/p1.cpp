#include<iostream>

using namespace std;

int main(int argc, char* argv[])
{
    int gameBoard[200][1001] = {0};
    int ncol, numSquare;
    int bottomRow = 0;
    int col, row, j;
    int points = 0;
    ncol = 3;
    numSquare = 9;
    int inputs[] = {0, 1, 1, 2, 2, 3, 1, 2, 2, 3};
    // cout << inputs[1] << endl;
    // cin >> ncol >> numSquare;
    for(int i = 1; i <= numSquare; ++i)
    {
        // cin >> col;
        col = inputs[i];
        row = bottomRow;
        while(gameBoard[row][col]) row = (row + 1) % 1000;
        gameBoard[row][col] = 1;
        j = 1;
        for(;j <= ncol; ++j)
        {
            if(gameBoard[bottomRow][j] != 1) break;
        }
        if(j == ncol)
        {
            j = 1;
            for(;j <= ncol; ++j)
            {
                gameBoard[bottomRow][j] = 0;
            }
            ++bottomRow;
            ++points;
        }
    }
    cout << points << endl;
    return 0;
}