/* Test file for syntactic errors. Contains exactly one error. */	

int a;
int main(void) {
  if (a != 0) then printInt(a);	// Shouldn't be a 'then' here
}
