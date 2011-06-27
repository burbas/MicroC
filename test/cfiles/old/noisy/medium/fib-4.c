/* Fibbonacci, naive and hairy. Give result by adding to a local array
   passed as argument. Use logical operator '&&'. */

void printInt(int i);
void printString(char s[]);


int fib(int n, int x[]) {
  int t;

  x[0] = x[0] + 1;
  (n != 0 && 
   n != 1 && 
   (x[0] = x[0] - 1) * 0 + 1 &&
   fib(n-1, x) * fib(n-2, x) );

  return 1;
}



int main (void) {
  int i;
  int res[1];
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

  i = 1;

  while (i<=12) {
    printString(fib_a);
    printInt(i);
    printString(fib_b);
    printString(eq);
    
    res[0] = 0;
    fib(i,res);
    printInt(res[0]);
    printString(eol);
    i = i + 1;
  }
}
