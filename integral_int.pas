unit integral_int;

interface

type 
	func_real_t = function(x: real): real;
    list_int_item = record
        n, h, i, eps: real;
        next: ^list_int_item;
    end;
    journal_int_list_t = record
        head: ^list_int_item;
        tail: ^list_int_item;
    end;

procedure add_int(n, h, i, eps: real; var p: journal_int_list_t);

function integral(F: func_real_t; a, b, eps: real; 
                  var journal: journal_int_list_t; 
                  var integ: real; f_int: integer): integer;
              
implementation
{----------------------------------------------------------------------}

procedure add_int(n, h, i, eps: real; var p: journal_int_list_t);
var e: ^list_int_item;
begin
    new(e);
    e^.n := n; 
    e^.h := h;
    e^.i := i;
    e^.eps := eps;
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

function integral(F: func_real_t; a, b, eps: real; 
                  var journal: journal_int_list_t; 
                  var integ: real; f_int: integer): integer;
var
    SN, ST, S, S4, S2, x, h, p: real;
    n, kkk, i: integer;
begin
    if (a >= b) then begin
        integral := 2;
        exit;
    end;
    p := 1/15;
    SN := F(a) + F(b);
    S4 := 0;
    S2 := 0;
    S := 0;
    n := 1;
    h := b - a;
    kkk := 1;
    repeat
        kkk := kkk + 1;
        n := n*2;
        h := h / 2;
        x := a + h;
        S2 := 2.0*S4 + S2;
        S4 := 0.0;
        for i := 1 to (n div 2) do begin
            S4 := S4 + F(x);
            x := x + 2*h;
        end;
        ST := S;
        S := h*(4*S4 + S2 + SN)/3;
        if (f_int = 1) then
            add_int(n, h, S, abs(ST - S), journal);
    until (kkk = 55) or (p*abs(ST - S) < eps);
    integ := S;
    if (kkk = 55) then
        integral := 1
    else
        integral := 0;
end;
end.
