int a;
char b;
int c[10];
char d[10];

void f(int e, char g, int h[], char i[]) {
  h[2] = 3;
  i[3] = 7;
}


int main(void) {
  int j;
  char k;
  int l[10];
  char m[10];

  f(a, k, l, d);

  c[4] = c[4] + 11;
  d[5] = 13;

  l[6] = 17;
  m[7] = 19;


}
