void printInt(int i);

void foo(int v1, int v2, int v3, int v4, int v5) {
  printInt( v1);
  printInt( v2);
  printInt( v3);
  printInt( v4);
  printInt( v5);
}
int main(void) {	
  foo(1,2,3,4,5);
}
