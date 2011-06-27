int f(void) {
  return 7; 
}

void g (int x) {
  1234;

  return;
  
  4321;

}

int h(int x, int y) {
  return x+y;
}

int main(void) {
  f();

  g(567);
  g(f());
  
  h(8,9);
}
