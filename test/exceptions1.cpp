// From: https://gcc.gnu.org/wiki/Dwarf2EHNewbiesHowto
#include <stdio.h>

int main() {
  try {
    throw 1;
  }
  catch (...) {
    printf(" in catch\n");
    return 0;
  }
  printf(" back in main\n");
  return 10;
}
