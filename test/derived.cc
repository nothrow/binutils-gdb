#include <test/derived.hpp>
#include <stdio.h>

Derived::~Derived()
{
  printf("Destructing derived\n");
}
Derived::Derived()
{
  printf("Constructing derived\n");
}
