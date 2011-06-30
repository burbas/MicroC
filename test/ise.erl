-module(ise).

-include_lib("eunit/include/eunit.hrl").

-include("path.hrl").

-compile(export_all).


helper(File) ->
    case catch microc:compile(?CPATH++File) of
	{'EXIT', Error} ->
	    Error;
	A ->
	    A
    end.

ise01() ->
    ?assertMatch({error, not_found, b}, helper("se01.c")).
	

ise02() ->
   ?assertMatch({error, not_found, foo}, helper("se02.c")).

ise03() ->
    ?assertMatch({error, not_found, output}, helper("se03.c")).
 
ise04() ->
    ?assertMatch({error, already_decleared}, helper("se04.c")).

ise05() ->
    ?assertMatch({error, already_decleared}, helper("se05.c")).
   
ise06() ->
    ?assertMatch({error, already_decleared}, helper("se06.c")).

ise07() ->
    ?assertMatch({error, return_missmatch}, helper("se07.c")).

ise08() ->
    ?assertMatch({error, return_missmatch}, helper("se08.c")).
    
ise09() ->
    ?assertMatch({error, return_missmatch}, helper("se09.c")).
   
ise10() ->
    ?assertMatch({error, not_found, n}, helper("se10.c")).
    
ise11() ->
    ?assertMatch({error, incompatible_types}, helper("se11.c")).
    
ise12() ->
    ?assertMatch({error, not_found, a}, helper("se12.c")).
    
ise13() ->
    ?assertMatch({error, unmatched_types}, helper("se13.c")).
   
ise14() ->
    ?assertMatch({error, not_found, f}, helper("se14.c")).
   
ise15() ->
    ?assertMatch({error, not_same_type}, helper("se15.c")).
    
ise16() ->
    ?assertMatch({error, not_same_type}, helper("se16.c")).
   
ise17() ->
    ?assertMatch({error, illegal_pointer}, helper("se17.c")).
    
ise18() ->
    ?assertMatch({error, illegal_pointer}, helper("se18.c")).
    
ise19() ->
    ?assertMatch({error, illegal_pointer}, helper("se19.c")).
    
ise20() ->
    ?assertMatch({error,illegal_pointer}, helper("se20.c")).
    
ise21() ->
    ?assertMatch({error,return_missmatch}, helper("se21.c")).
    
ise22() ->
    ?assertMatch({error,illegal_pointer}, helper("se22.c")).
   
ise23() ->
    ?assertMatch({error, not_found, b}, helper("se23.c")).
   
ise24() ->
    ?assertMatch({error,illegal_pointer}, helper("se24.c")).
   
ise25() ->
    ?assertMatch({error, no_assignment}, helper("se25.c")).
    
ise26() ->
    ?assertMatch({error,not_same_type}, helper("se26.c")).
    
ise27() ->
    ?assertMatch({error,return_missmatch}, helper("se27.c")).
    
ise28() ->
    ?assertMatch({error,return_missmatch}, helper("se28.c")).
    
ise29() ->
    ?assertMatch({error,already_declared}, helper("se29.c")).
    
ise30() ->
    ?assertMatch({error,illegal_pointer}, helper("se30.c")).
    
ise31() ->
    ?assertMatch({error,already_declared}, helper("se31.c")).
    
ise32() ->
    ?assertMatch({error,unmatched_types}, helper("se32.c")).
    
ise33() ->
    ?assertMatch({error,not_same_type}, helper("se33.c")).
    
ise34() ->
    ?assertMatch({error,not_same_type}, helper("se34.c")).
    
