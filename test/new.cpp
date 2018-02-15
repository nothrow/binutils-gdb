#include <stdio.h>

struct A
{
  A() { printf("Constructing A\n"); }
  virtual ~A() { printf("Destructing A\n"); }
};

struct B
{
  A *x;
  B() : x(new A) { printf("Constructing B\n"); }
  virtual ~B() { printf("Destructing B\n"); delete x; }
};

struct C : public B
{
  C() : B() { printf("Constructing C\n"); }
  virtual ~C() { printf("Destructing C\n"); }
};

int main()
{
  A *a = new A();
  delete a;
  B b;
  C c;
}
