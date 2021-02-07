unit gen_operations;

interface 

uses types, config, bit_functions;
  
procedure single_point_crossing; stdcall;external name 'SINGLE_POINT_CROSSING';
procedure double_point_crossing; stdcall;external name 'DOUBLE_POINT_CROSSING';
procedure universal_crossing; stdcall;external name 'UNIVERSAL_CROSSING';
procedure uniform_crossing; stdcall;external name 'UNIFORM_CROSSING';
procedure change_one_bit; stdcall;external name 'CHANGE_ONE_BIT'; 
procedure change_some_bits; stdcall;external name 'CHANGE_ONE_BIT';
procedure reverse_bits; stdcall;external name 'REVERSE_BITS';
procedure sort_pop (var val: array of real; size_pop:word); stdcall; 
external name 'SORT_POP'; 
procedure random_selection; stdcall;external name 'RANDOM_SELECTION'; 
procedure selection_tournament; stdcall;external name 'SELECTION_TOURNAMENT'; 
procedure selection(method:integer); stdcall;external name 'SELECTION'; 
function mutation(mutation_method:integer):word; stdcall;
external name 'MUTATION';
function making_child (r: integer):word; stdcall;
external name 'MAKING_CHILD'; 
procedure crossing(crossbreeding_method, mutation_method: integer); stdcall;
external name 'CROSSING'; {$L new1.obj}
implementation
end.
