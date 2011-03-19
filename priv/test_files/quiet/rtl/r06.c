int x;

int main(void) {
  
  if (x) 
    x = 1; 
  

  if (x) 
    x = 2;
    else x = 3;
  

  while (x) x = 3;

  while (!x) {
    x = 5;
    while (x) {
      x = 7;
    }

  }
}
