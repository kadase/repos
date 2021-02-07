unit root_int;

interface

type 
	func_real_t = function(x: real): real;
    list_root_item = record
        l, r, c: real;
        next: ^list_root_item;
    end;
    journal_root_list_t = record
        head: ^list_root_item;
        tail: ^list_root_item;
    end;
	
procedure add_root(a, b, c: real; var p: journal_root_list_t);
function root(F: func_real_t; eps: real; a, b: real; var x: real; 
              var journal: journal_root_list_t; 
              f_roots: integer): integer; 
              
implementation
{----------------------------------------------------------------------}

procedure add_root(a, b, c: real; var p: journal_root_list_t);
var e: ^list_root_item;
begin
    new(e);
    e^.l := a; 
    e^.r := b;
    e^.c := c;
    e^.next := nil;
    if (p.head = nil) then begin
        p.head := e;
        p.tail := e;
    end
    else begin
        p.tail^.next := e;
        p.tail := e;
    end;
end;

function root(F: func_real_t; eps: real; a, b: real; var x: real; 
              var journal: journal_root_list_t; 
              f_roots: integer): integer;
var
    s1, s2, c, s3, d: real;
    i: integer;
    s: boolean;
begin
    if (a >= b) then begin
        root := 2;
        exit;
    end;
    s1 := F(a);
    s2 := F(b);
    s := (a < 0.0) = (F((a+b)/2) < (s1+s2)/2);
    i := 1;
    if (s) then
        repeat
            i := i + 1;
            c := (a*s2 - b*s1)/(s2 - s1);
            if (f_roots = 1) then
                add_root(a, b, c, journal);
            s3 := F(c);
            if (s3 = 0.0) then
                x := c
            else begin
                d := F(c - eps);
                if (d*s3 < 0.0) then
                    x := c
                else begin
                    b := c;
                    s2 := s3;
                end
            end
        until (x = c) or (i = 1000)
    else
        repeat
            i := i + 1;
            c := (a*s2 - b*s1)/(s2 - s1);
            if (f_roots = 1) then
                add_root(a, b, c, journal);
            s3 := F(c);
            if (s3 = 0.0) then
                x := c
            else begin
                d := F(c + eps);
                if (d*s3 < 0.0) then
                    x := c
                else begin
                    a := c;
                    s1 := s3;
                end
            end
        until (x = c) or (i = 1000);
    if (i = 1000) then 
        root := 1
    else
        root := 0;
end;
end.
