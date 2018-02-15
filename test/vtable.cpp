#include <stdio.h>

struct ClassWithVirtualDestructor
{
  virtual ~ClassWithVirtualDestructor()
  {
    printf("In base\n");
  }
};

struct ConcreteClass : public ClassWithVirtualDestructor
{
  virtual ~ConcreteClass()
  {
    printf("In derived\n");
  }
};

int main()
{
  ConcreteClass c;
}
