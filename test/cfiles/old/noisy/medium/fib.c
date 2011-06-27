/* Fibbonacci, in the simple and naive form */

void printInt(int i);
void printString(char s[]);

int fib(int n) {
  if (n == 0) return 1;
  if (n == 1) return 1;
  return fib(n-1) + fib(n-2);
}

int main (void) {
  int i;
  char eol[2];
  char eq[4];
  char fib_a[5];
  char fib_b[2];

  eol[0]='\n';
  eol[1]=0;
  
  eq[0] = eq[2] = ' ';
  eq[1] = '=';
  eq[3] = 0;

  fib_a[0] = 'f';
  fib_a[1] = 'i';
  fib_a[2] = 'b';
  fib_a[3] = '(';
  fib_a[4] = 0;
  fib_b[0] = ')';
  fib_b[1] = 0;

  i = 0;

  while (i<=12) {
    printString(fib_a);
    printInt(i);
    printString(fib_b);
    printString(eq);
    printInt(fib(i));
    printString(eol);
    i = i + 1;
  }
}
