// INCLUDE HEADER FILES NEEDED BY YOUR PROGRAM
// SOME LIBRARY FUNCTIONALITY MAY BE RESTRICTED
// DEFINE ANY FUNCTION NEEDED
// FUNCTION SIGNATURE BEGINS, THIS FUNCTION IS REQUIRED
#include<string.h>
int savePeople(char *str)
{
    //WRITE YOUR CODE HERE
    int stringLen = strlen(str);
    if(stringLen == 0 or stringLen % 2 != 0)
    {
        return -1;
    }
    int simStack = 0, count = 0;
    for(int idx = 0; str[idx] != '\0'; ++idx)
    {
        if(str[idx] == '(')
        {
            ++simStack;
        }
        else if(str[idx] == ')')
        {
            --simStack;
            ++count;
        }
        if(simStack < 0)
        {
            return -1;
        }
    }
    return simStack == 0 ? count : -1;
}
//FUNCTION SIGNATURE ENDS