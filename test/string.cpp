#include <iostream>
#include <string>

int main()
{
  std::string mystring = "Some string";
  std::string *myptr = new std::string("Some ptr");
  std::cout << mystring << " and " << *myptr << std::endl;
  delete myptr;
}
