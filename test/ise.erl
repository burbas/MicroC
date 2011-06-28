-module(ise).

-include_lib("eunit/include/eunit.hrl").

-include("path.hrl").

-compile(export_all).

ise01() ->
    try
	microc:compile(?CPATH++"se01.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, b}, Reason)
    end.

ise02() ->
   try
	microc:compile(?CPATH++"se02.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, foo}, Reason)
    end.

ise03() ->
    try
	microc:compile(?CPATH++"se03.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, output}, Reason)
    end.

ise04() ->
   try
	microc:compile(?CPATH++"se04.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, already_decleared}, Reason)
    end.

ise05() ->
    try
	microc:compile(?CPATH++"se05.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, already_decleared}, Reason)
    end.

ise06() ->
   try
	microc:compile(?CPATH++"se06.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, already_decleared}, Reason)
    end.

ise07() ->
    try
	microc:compile(?CPATH++"se07.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, return_missmatch}, Reason)
    end.

ise08() ->
   try
	microc:compile(?CPATH++"se08.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, return_missmatch}, Reason)
    end.

ise09() ->
    try
	microc:compile(?CPATH++"se09.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, return_missmatch}, Reason)
    end.

ise10() ->
   try
	microc:compile(?CPATH++"se10.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, n}, Reason)
    end.

ise11() ->
    try
	microc:compile(?CPATH++"se11.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, incompatible_types}, Reason)
    end.

ise12() ->
   try
	microc:compile(?CPATH++"se12.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, a}, Reason)
    end.

ise13() ->
    try
	microc:compile(?CPATH++"se13.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, unmatched_types}, Reason)
    end.

ise14() ->
   try
	microc:compile(?CPATH++"se14.c")
   catch
       _:Value ->
	   {{{_, Reason}, _}, _} = Value,
	   ?assertMatch({error, not_found, f}, Reason)
   end.

ise15() ->
    try
	microc:compile(?CPATH++"se15.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_same_type}, Reason)
    end.

ise16() ->
   try
	microc:compile(?CPATH++"se16.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_same_type}, Reason)
    end.

ise17() ->
    try
	microc:compile(?CPATH++"se17.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, illegal_pointer}, Reason)
    end.

ise18() ->
   try
	microc:compile(?CPATH++"se18.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, illegal_pointer}, Reason)
    end.

ise19() ->
    try
	microc:compile(?CPATH++"se19.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, illegal_pointer}, Reason)
    end.

ise20() ->
   try
	microc:compile(?CPATH++"se20.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, foo}, Reason)
    end.

ise21() ->
    try
	microc:compile(?CPATH++"se21.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, b}, Reason)
    end.

ise22() ->
   try
	microc:compile(?CPATH++"se22.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, foo}, Reason)
    end.

ise23() ->
    try
	microc:compile(?CPATH++"se23.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, b}, Reason)
    end.

ise24() ->
   try
	microc:compile(?CPATH++"se24.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, foo}, Reason)
    end.

ise25() ->
    try
	microc:compile(?CPATH++"se25.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, b}, Reason)
    end.

ise26() ->
   try
	microc:compile(?CPATH++"se26.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, foo}, Reason)
    end.

ise27() ->
    try
	microc:compile(?CPATH++"se27.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, b}, Reason)
    end.

ise28() ->
   try
	microc:compile(?CPATH++"se28.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, foo}, Reason)
    end.

ise29() ->
    try
	microc:compile(?CPATH++"se29.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, b}, Reason)
    end.

ise30() ->
   try
	microc:compile(?CPATH++"se30.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, foo}, Reason)
    end.

ise31() ->
    try
	microc:compile(?CPATH++"se31.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, b}, Reason)
    end.

ise32() ->
   try
	microc:compile(?CPATH++"se32.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, foo}, Reason)
    end.

ise33() ->
    try
	microc:compile(?CPATH++"se33.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, b}, Reason)
    end.

ise34() ->
   try
	microc:compile(?CPATH++"se34.c")
    catch
	_:Value ->
	    {{{_, Reason}, _}, _} = Value,
		?assertMatch({error, not_found, foo}, Reason)
    end.
