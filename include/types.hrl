-record('EXPRESSION', {
	  value,
	  line :: integer()
	 }).

-record('ARRAY', {
	  identifier,
	  expression,
	  line :: integer()
	 }).

-record('FUNCTION_CALL', {
	  identifier,
	  argument_list,
	  line :: integer()
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
	  expression,
	  line :: integer()
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
	  statement2,
	  line :: integer()
	 }).

-record('WHILE', {
	  expression,
	  statement,
	  line :: integer()
	 }).

-record('RETURN', {
	  expression,
	  line :: integer()
	 }).	  

-record('VARDEC', {
	  base_type, 
	  declarator,
	  line :: integer()
	 }).

-record('ARRDEC', {
	  identifier,
	  base_type,
	  size :: integer(),
	  line :: integer()
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
	  body,
	  line :: integer()
	 }).

-record('EXTFUNC', {
	  name,
	  return_type,
	  formals,
	  line :: integer()
	 }).

-record('GLOBAL', {
	  declaration
	 }).
	  

-record('ARGUMENT', {
	  args
	 }).
