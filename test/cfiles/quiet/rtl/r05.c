void f(char x[]) {
  x[1] = x[0] + 7;
}


int main(void ) {
  char a[9];

  a[0] = 5;
  f(a);
}
