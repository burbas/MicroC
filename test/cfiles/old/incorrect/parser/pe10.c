/* Test file for syntactic errors. Contains exactly one error. */

void  foo(int a, int b, int c){
  printInt( 0);
}

int main(void) {
  foo(1, 2, );	// Unexpected token ')'
}

