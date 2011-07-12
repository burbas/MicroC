-define(BYTE, byte).
-define(LONG, long).


-record('RTL_PROC', {
	  label,
	  formals,
	  locals,
	  framesize,
	  insns
	 }).

-record('RTL_DATA', {
	  label,
	  size
	 }).


-record('RTL_CALL', {
	  function,
	  arguments
	 }).


-record('RTL_TEMP', {
	  temp
	 }).

-record('RTL_ICON', {
	  int
	 }).

-record('RTL_LABREF', {
	  label
	 }).

-record('RTL_UNARY', {
	  unop, %% load value of type ?LONG | ?BYTE from address in operand
	  temp
	 }).

-record('RTL_BINARY', {
	  binop :: 'add' | 'sub' | 'mul' | 'div', 
	  dest,
	  temp1,
	  temp2
	 }).

-record('RTL_EVAL', {
	  dest,
	  value
	 }).

-record('RTL_COMMENT', {
	  text
	 }).

-record('RTL_SUB', {
	  temp1,
	  temp2
	 }).

-record('RTL_LABELDEF', {
	  label
	 }).

-record('RTL_ASSIGN', {
	  dest,
	  temp1,
	  temp2
	 }).

-record('RTL_JUMP', {
	  label
	 }).

-record('RTL_CJUMP', {
	  relop :: 'lt' | 'le' | 'eq' |'ne' | 'ge' | 'gt', 
	  temp1,
	  temp2,
	  label
	 }).

-record('RTL_STORE', {
	  ty :: 'long' | 'byte',
	  temp1,
	  temp2
	 }).
