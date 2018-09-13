#include <iostream>

using namespace std;

void printArray(int* arr, int size)
{
    for(int idx = 0; idx < size; ++idx)
    {
        cout << arr[idx] << " ";
    }
    cout << endl;
}

// while(lo<hi){
//             while(array[hi]>key&&hi>lo){//从后半部分向前扫描
//                 hi--;
//             }
//             array[lo]=array[hi];
//             while(array[lo]<=key&&hi>lo){//从前半部分向后扫描
//                 lo++;
//             }
//             array[hi]=array[lo];
//         }
//         array[hi]=key;

int partition(int* arr, int left, int right)
{
    int val = arr[right];
    int l = left, r = right;
    while(left < right)
    {
        while(arr[left] < val && left < right)
        {
            ++left;
        }
        arr[right] = arr[left];
        while(arr[right] > val && left < right)
        {
            
            --right;
        }
        arr[left] = arr[right];
    }
    arr[left] = val;
    return left;
}

void quickSort(int* arr, int left, int right)
{
    if(left < right)
    {
        int parIdx = partition(arr, left, right);
        quickSort(arr, left, parIdx - 1);
        quickSort(arr, parIdx + 1, right);
    }
}

int main(int argc, char* argv[])
{
    int tc1[] = {3, 2, 7, 9, 4, 5, 6};
    printArray(tc1, 7);
    // cout << partition(tc1, 0, 6) << endl;
    quickSort(tc1, 0, 6);
    printArray(tc1, 7);
    return 0;
}