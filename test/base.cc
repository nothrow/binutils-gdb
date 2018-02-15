#include <test/base.hpp>
#include <stdio.h>

Base::~Base()
{
  printf("Destructing base\n");
}
Base::Base()
{
  printf("Constructing base\n");
}
