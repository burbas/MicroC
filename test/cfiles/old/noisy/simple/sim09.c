// All expressions evaluate to 42, of course

void printInt(int i);
void printString(char s[]);

int main(void) {
  char cr[2];

  cr[0]='\n';
  cr[1]=0;

  printString(cr);
  printInt(42);

  printString(cr);
  printInt(35+7);

  printString(cr);
  printInt(6*7);

  printString(cr);
  printInt(3*4+5*6);

  printString(cr);
  printInt(7*8-3*4-2);

  printString(cr);
  printInt((-6)*(-7));

  printString(cr);

  printInt( ((9 + 9 + 9) 
	     * ((9 + 9) / 9) 
	     * (9 * 9 - (9 + 9)) 
	     + (9 + 9)*(9+9+9)) 
	    / (9 * 9+9) 
	    - 9 / 9);

  printString(cr);
}
