#include <cstdio>
#include "main.h"

//Функции для вывода строк как массивов символов в Python
void print_c_string(char *s)
{
    printf("s = [");
    for (; *s; s++)
        printf("\'%c\', ", *s);
    puts("\'\\0\']");
}

void print_c_string(char *s, int l)
{    
    printf("s = [");
    for (int i = 0; i < l; s++, i++)
        printf("\'%c\', ", *s);
    puts("\'\\0\']");
}
