void printString(char s[]);

char x[15];

int main(void) {
  char y[15];

  x[0] = 'H';
  x[1] = 'e';
  x[2] = 'l';
  x[3] = 'l';
  x[4] = 'o';
  x[5] = ',';
  x[6] = ' ';
  x[7] = 'w';
  x[8] = 'o';
  x[9] = 'r';
  x[10] = 'l';
  x[11] = 'd';
  x[12] = '!';
  x[13] = '\n';
  x[14] = 0;

  y[0] = 'H';
  y[1] = 'e';
  y[2] = 'l';
  y[3] = 'l';
  y[4] = 'o';
  y[5] = ',';
  y[6] = ' ';
  y[7] = 'w';
  y[8] = 'o';
  y[9] = 'r';
  y[10] = 'l';
  y[11] = 'd';
  y[12] = '!';
  y[13] = '\n';
  y[14] = 0;

  printString(x);   
  printString(y);
}
