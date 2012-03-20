char g(int x) {
	char y[5];
	if(x == 1) {
		return y[0]; // This should be ok
	} else {
		return y; // This will create an error
	}
}



int main(void) {
	g(5);
	g(1);
	return 0;
}
