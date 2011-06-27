void printString(char s[]);

char t[10];

int main(void) {
  int b;
  b = 10;
  t[1] = 0;

  while (b) {
    t[0] = 48+b-1;
    printString(t);
    b = b - 1;
  }
}









