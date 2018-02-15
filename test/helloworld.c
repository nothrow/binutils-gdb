#include <stdio.h>

int main()
{
  printf("hello, world from gcc %d.%d.%d\n", __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__);
  return 0;
}
