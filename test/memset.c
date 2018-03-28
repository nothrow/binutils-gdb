#include <stdio.h>
#include <string.h>

int main()
{
    char str[] = "A bunch of text.";
    printf("Before memset(): %s\n", str);
    memset(str, '.', sizeof(str) * sizeof(char));
    str[sizeof(str) * sizeof(char) - 1] = 0;

    printf("After memset():  %s\n", str);
    return 0;
}
