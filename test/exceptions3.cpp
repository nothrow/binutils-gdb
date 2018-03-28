#include <stdio.h>

struct SomeNameICanRecognise {};
    
int main ()
{
  try
  {
    throw SomeNameICanRecognise();
  }
  catch(SomeNameICanRecognise)
  {
    printf("Caught.\n");
    return 0;
  }
  return 1;
}
