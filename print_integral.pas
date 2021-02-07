unit print_integral;

interface

type 
	func_real_t = function (x: real): real;
	
	list_item_link_t = ^list_item_t ;

    journal_list_t = record
        head: list_item_link_t;
        tail: list_item_link_t
        end;
        
    list_item_t = record
        prev: list_item_link_t;
        next: list_item_link_t;
        left_front, right_front,  max_interval, integral_k0, 
        integral_2k0: real;
        fragmentation_1, fragmentation_2, number: integer;
        end;
        
procedure print(x : journal_list_t);

implementation

procedure print(x : journal_list_t);
var i :list_item_link_t;
begin
	i := x.head;
	while i <> nil do
	begin
		writeln('left_front = ', i^.left_front);
		writeln('right_front = ', i^.right_front);
		writeln('max_interval = ', i^.max_interval);
		writeln('integral_k0 = ', i^.integral_k0);
		writeln('ntegral_2k0 = ', i^.integral_2k0);
		writeln('fragmentation1 = ', i^.fragmentation_1);
		writeln('fragmentation2 = ', i^.fragmentation_2);
		writeln('itteration = ', i^.number);
		writeln();
		i := i^.next;
	end;
	writeln();
end;
end.
