#include <stdio.h>
#include <typeinfo>

struct A {};

void typeinfo(const std::type_info &tf)
{
  printf("Name: %s\n", tf.name());
  printf("Is pointer? %d\n", tf.__is_pointer_p());
  printf("Is function? %d\n", tf.__is_function_p());
  printf("\n");
}

int main()
{
  auto a = A();
  const auto &tid1 = typeid(A);
  const auto &tid2 = typeid(a);
  const auto &tid3 = typeid(&a);
  const auto &tid4 = typeid(typeinfo);

  typeinfo(tid1);
  typeinfo(tid2);
  typeinfo(tid3);
  typeinfo(tid4);
}
