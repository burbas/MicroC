#include <stdio.h>

void printInt(int x) {
  printf("%d",x);
}

void printString(char* s) {
  printf("%s",s);
}

int readInt() {
  int i;
  scanf("%d", &i);
  return i;
}

void readString(char buffer[]) {
  scanf("%s",buffer);
}




