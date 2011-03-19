void f(char x[]) {
  x[1] = x[0] + 7;
}

char a[7];


int main(void ) {

  a[0] = 5;
  f(a);
}
