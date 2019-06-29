#include <cstdio>
#include "main.h"

char s1[13] = "This is str";
char s2[13] = "Boliboliboli";
char s3[13] = "  dffe f ";

int main(void)
{
    printf("len of s1 = %d", DlinaStroki(s1));    printf("len of s2 = %d", DlinaStroki(s2));    printf("len of s3 = %d", DlinaStroki(s3));
    char *s = CopyString(s2, s1, 4);
    if (s == s1)
        puts("OK");
    else
        puts("Not OK");
    print_c_string(s1);
    printf("New len of s3 = %d", DelProbel(s3));
    print_c_string(s3);
    
    return 0;
}
