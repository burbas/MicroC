Test suite for the compiler project in the course Compiler Techniques
DV1/MN1, Uppsala university, 2008

Three classes of test programs:

 + incorrect
 
   Trying to compile these program should give error messages in
   either the lexer, the parser or the semantic analysis.


 + quiet

   Fairly short programs that do not produce any output. 


 + noisy

   Slightly larger programs that produce output. Divided in three
   groups; simple, medium and advanced.

The file uc.c contains definitions of the I/O routines used in the
noisy programs.


You can compile the programs using the ordinary C complier by typing
(for example)

cc noisy/simple/sim04.c uc.c

at the Unix command line. To run them, type 

./a.out


