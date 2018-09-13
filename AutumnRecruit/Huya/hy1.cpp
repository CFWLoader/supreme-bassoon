#include <iostream>
#include <algorithm>
#include <vector>

using namespace std;

struct Student
{
    int classNo, marks;
    explicit Student(int clsNo, int mks) : classNo(clsNo), marks(mks) {}
};

struct StudentComparator
{
    bool operator()(const Student& s1, const Student& s2)
    {
        if(s1.classNo != s2.classNo)
        {
            return s1.classNo < s2.classNo;
        }
        else
        {
            return s1.marks > s2.marks;
        }
    }
};

int main(int argc, char* argv[])
{
    int clsNo, marks;
    /*
    map<int, vector<int>> classes;
    while(cin >> clsNo >> marks)
    {
        classes[clsNo].emplace_back(marks);
    }
    for(auto cls : classes)
    {
        sort(cls.second.rbegin(), cls.second.rend());
        for(auto marks : cls.second)
        {
            cout << cls.first << " " << marks << endl;
        }
    }
    */
    vector<Student> stuVec;
    while(cin >> clsNo >> marks)
    {
        stuVec.emplace_back(Student(clsNo, marks));
    }
    sort(stuVec.begin(), stuVec.end(), StudentComparator());
    for(auto stu : stuVec)
    {
        cout << stu.classNo << " " << stu.marks << endl;
    }
    return 0;
}