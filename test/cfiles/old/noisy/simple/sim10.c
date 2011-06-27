/* Logic operations.  
*/

void printString(char s[]);
void printInt(int i);

int main(void) {
  int a;
  int b;
  int c;
  
  char zero[4];
  char one[4];

  zero[0] = '\n';
  zero[1] = '0';
  zero[2] = ' ';
  zero[3] = 0;

  one[0] = '\n';
  one[1] = '1';
  one[2] = ' ';
  one[3] = 0;

  a=0;
  b=0;
  c=0;

  printString(zero);
  printInt(a || !b && c);

  a = 0; b = 0; c = 1;
  printString(one);
  printInt(a || !b && c);

  a = 0; b = 1; c = 0;
  printString(zero);
  printInt(a || !b && c);

  a = 0; b = 1; c = 1;
  printString(zero);
  printInt(a || !b && c);

  a = 1; b = 0; c = 0;
  printString(one);
  printInt(a || !b && c);

  a = 1; b = 0; c = 1;
  printString(one);
  printInt(a || !b && c);

  a = 1; b = 1; c = 0;
  printString(one);
  printInt(a || !b && c);

  a = 1; b = 1; c = 1;
  printString(one);
  printInt(a || !b && c);

}
