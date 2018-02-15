int main()
{
  try
  {
    throw 0;
  }
  catch(int x)
  {
    return x;
  }
  return 1;
}
