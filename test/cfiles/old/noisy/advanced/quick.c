// This program illustrates the quick sort algorithm by sorting an
// array of char and printing the intermediate results.
//
// Adapted from N.Wirth: Algorithms + Data Structures = Programs


void printString(char s[]);

char eol[2];
int n;


void sort(char a[], int l, int r) {
  int i;
  int j;
  char x;
  char w;


  i = l;
  j = r;
  x = a[(l+r) / 2];
  
  while ( i<= j) {
    while (a[i] < x) i = i + 1;
    while (x < a[j]) j = j - 1;
    if (i<= j) {
      w = a[i];
      a[i] = a[j];
      a[j] = w;
      i = i + 1;
      j = j - 1;
    }
  }
  // Un-comment the two lines below if you want to see
  // intermediate values of a.

  // printString (a);
  // printString (eol);
  if (l < j) sort(a, l,j);
  if (i < r) sort(a, i, r);

}

int main(void)
{
  char s[27];
  int i;
  char t;
  int q;

  eol[0] = '\n';
  eol[1] = 0;

  n = 26;

  s[n] = 0;

  i = 0;
  q = 11;


  // Fill the string with random-looking data
  while (i<n) {
    t = q - (q / 26)*26;
    s[i] = 'a'+t;
    i = i + 1;
    q = q + 17;
  }


  printString (s); // print it ...
  printString (eol);
  sort(s, 0, n-1); // sort it ...
  printString(s);  // and print again
  printString (eol);

}
