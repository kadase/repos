unit bit_functions;

interface

function getbit(input: word; n: byte): byte;
procedure setbit(var input: word; n: byte);
procedure unsetbit(var input: word; n: byte);

implementation

function getbit(input: word; n: byte): byte;
var
    mask: word;
begin
    mask := 1;
    mask := mask shl (15 - n); 
    if input and mask > 0 then
        getbit := 1
    else
        getbit := 0;
end;

procedure setbit(var input: word; n: byte);
var
    mask: word;
begin
    mask := 1;
    mask := mask shl (15-n); 
    input := input or mask;
end;

procedure unsetbit(var input: word; n: byte);
var
    mask: word;
begin
    mask := 1;
    mask := mask shl (15-n);  
    input := not ((not input) or mask);
end;
end.