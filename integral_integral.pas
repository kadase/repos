unit integral_integral;

interface

uses print_integral;

type 
	func_real_t = function (x: real): real;
	
        
function integral(f: func_real_t; a, b, eps_2: real;
				  n, amount_of_itterations: integer; 
				  var itteration_number: integer; 
				  var y: journal_list_t): real;
				  
implementation

function integral(f: func_real_t; a, b, eps_2: real;
				  n, amount_of_itterations: integer; 
				  var itteration_number: integer; 
				  var y: journal_list_t): real;
var h, Integral_k, Integral_2k: real;
    i: integer;
	p: longint;
	t:list_item_link_t;
begin
	p := n;
	repeat 
		new(t);
		inc(itteration_number);
		t^.fragmentation_1 := p;
		t^.number := itteration_number;
		t^.left_front := a;
		t^.right_front := b;
		t^.max_interval := eps_2*3;
		Integral_k := 0;
		Integral_2k := 0;
		h := (b-a)/p;
		for i := 0 to p - 1 do 
			Integral_k := Integral_k + f(a + i * h);
		Integral_k := (integral_k + f(b)) * h / 3;
		t^.Integral_k0 := Integral_k;
		p := p*2;
		t^.fragmentation_2 := p;
		h := (b-a)/p;
		for i := 0 to p - 1 do 
			Integral_2k := Integral_2k + f(a + i * h);
		Integral_2k := (Integral_2k + f(b)) * h / 3;
		t^.Integral_2k0 := Integral_2k;
		if y.tail = nil then
		begin
			y.head := t;
			y.tail := t;
			t^.prev := nil;
		end
		else
		begin
			t^.prev := y.tail;
			y.tail^.next := t;
			y.tail := t;
			t^.next:= nil;
		end;
		if (itteration_number > amount_of_itterations) then
		begin
			writeln(1);
			Integral := Integral_2k;
			exit;
		end;
	until abs(Integral_k - Integral_2k) < 3*eps_2;
	writeln(0);
	Integral := Integral_2k;
end;
end.
