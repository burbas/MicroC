// This program illustrates the bubblesort algorithm by sorting an
// array of char and printing the intermediate results.


void printString(char s[]);

char eol[1];
int n;


void bubble(char a[]) {
  int i;
  int j;
  char t;

  printString (a);
  printString (eol);
  i=n-1;
  while (i>0) {
    j = 0;
    while (j<i) {
      if (a[j] > a[j+1]) { 
	  t = a[j];
	  a[j] = a[j+1];
	  a[j+1] = t;
	}
      j = j + 1;
    }
    printString (a);
    printString (eol);
    i = i -1;
  }
}

int main(void)
{ 
  char s[27];
  int i;

  eol[0] = '\n';
  eol[1] = 0;

  n = 26;

  s[n] = 0;

  i = 0;
  
  while (i<n) {
    s[i] = 'z'-i;
    i = i + 1;
  }
  
  bubble(s);
}
