-record('IDENTIFIER', {
	  value,
	  line
	 }).


-record('EXPRESSION', {
	  value,
	  line
	 }).

-record('INT_CONSTANT', {
	  value,
	  line
	 }).

-record('ARRAY', {
	  identifier,
	  expression
	 }).

-record('FUNCTION_CALL', {
	  identifier,
	  argument_list
	 }).

-record('BINARY_OP', {
	  operation,
	  expression1,
	  expression2
	 }).

-record('ASSIGN', {
	  expr1,
	  expr2
	 }).

-record('UNARY', {
	  operation,
	  expression
	 }).

-record('STATEMENT', {
	  value
	 }).

-record('EFFECT', {
	  value
	 }).
-record('IF', {
	  expression,
	  statement1,
	  statement2
	 }).

-record('WHILE', {
	  expression,
	  statement
	 }).

-record('RETURN', {
	  expression
	 }).	  

-record('VARDEC', {
	  base_type, 
	  declarator
	 }).

-record('ARRDEC', {
	  identifier,
	  base_type,
	  size
	 }).


-record('PROGRAM', {
	  decs,
	  source
	 }).

-record('FUNCTION', {
	  name,
	  formals,
	  return_type,
	  locals,
	  body
	 }).

-record('EXTFUNC', {
	  name,
	  return_type,
	  formals
	 }).

-record('GLOBAL', {
	  declaration
	 }).
	  

-record('ARGUMENT', {
	  args
	 }).
