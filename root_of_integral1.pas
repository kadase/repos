unit root_of_integral1;

interface

uses print_integral;
	
type 
	func_real_t = function (x: real): real;
	

procedure Root(f, g: func_real_t; eps1: real; var a, b, x: real;
			   amount_of_itterations: integer; var itterarion_namber: integer;
			   var y: journal_list_t);  

function F_123(f, g: func_real_t; x: real): real; 

implementation

function F_123(f, g: func_real_t; x: real): real; 
begin
	F_123 := f(x) - g(x);
end;

procedure Root(f, g: func_real_t; eps1: real; var a, b, x: real;
			   amount_of_itterations: integer; var itterarion_namber: integer;
			   var y: journal_list_t);  
var q, p, w, c: real;
	t, d :list_item_link_t;
begin
	new(t);
	inc(itterarion_namber);
	t^.number := itterarion_namber;
	t^.left_front := a;
	t^.right_front := b;
	t^.max_interval := eps1;	
	if y.tail = nil then
    begin
        y.head := t;
        y.tail := t;
        t^.prev := nil;
    end
    else
    begin
        d := y.tail;
        t^.prev := d;
        d^.next := t;
        y.tail := t;
    end;
	if (itterarion_namber > amount_of_itterations) then
	begin
			writeln(1);
			exit;
	end; 
	q := F_123(f, g, b); {F(b)}
	p := F_123(f, g, a); {F(a)}
	c := (a*q - b*p)/(q - p); {c = (a*F(b)-b*F(a))/(F(b)-F(a))}
	w := F_123(f, g, (a+b)/2);{F((a+b)/2)}
	{0 situation}
	if (F_123(f, g, c) < eps1) then 
	begin
		x := c;
		writeln(0)
	end
	{1 situation}
	else if ((p > 0) and (w > (p + q)/2)) or ((p < 0) and (w < (p + q)/2)) then 
	begin
		a := c;
		if (a > b) then {graniza a stala > granizi b}
		begin
			writeln(2);
			exit;
		end;
		if (b - a) < eps1 then 
		begin
			x := a;
			writeln(0)
		end
		else Root(f, g, eps1, a, b, x, amount_of_itterations, itterarion_namber, y);
	end
	{2 situation}
	else if ((p < 0) and (w > (p + q)/2)) or ((p < 0) and (w > (p + q)/2)) then														
	begin
		b := c;
		if (a > b) then {graniza a stala > granizi b}
		begin
			writeln(2);
			exit;
		end;
		if (b - a) < eps1 then 
		begin
			x := a;
			writeln(0)
		end
		else Root(f, g, eps1, a, b, x, amount_of_itterations, itterarion_namber, y);
	end
end;
end.
