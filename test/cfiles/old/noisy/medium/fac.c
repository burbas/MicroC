/* 
**	Recursive functions.
*/


void printInt(int i);
int readInt(void);

int fac(int n) {
  if (n == 0) return 1;
  else return n*fac(n-1);
}

int a;
int main(void) {
  a = readInt();
  printInt( fac(a));
}
