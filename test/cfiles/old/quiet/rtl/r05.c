void f(int x[]) {
  x[1] = x[0] + 7;
}

int a[10];

int main(void ) {
  a[0] = 5;
  f(a);
}
