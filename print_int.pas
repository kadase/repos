unit print_int;

interface

uses root_int,
	 integral_int;

procedure print_root(var po: journal_root_list_t);
procedure print_i(var po: journal_int_list_t);
procedure delete_root(var po: journal_root_list_t);
procedure delete_int(var po: journal_int_list_t);

implementation
{----------------------------------------------------------------------}
    
procedure print_root(var po: journal_root_list_t);
var p: ^list_root_item;
    i: integer;
begin
    p := po.head;
    i := 1;
    writeln('The journal of roots');
    writeln;
    while (p <> nil) do begin
        writeln('iteration: ', i,
				'	left border: ', p^.l : 0 : 3,
                '	right border ', p^.r : 0 : 3);
        writeln;
        i := i + 1;
        p := p^.next;
    end;
end;

procedure print_i(var po: journal_int_list_t);
var p: ^list_int_item;
    i: integer;
begin
    p := po.head;
    i := 1;
    writeln('The journal of integrals ');
    writeln;
    while (p <> nil) do begin
        writeln('iteration: ', i,
				'	number of intervals: ', p^.n : 0: 0,
				'	the size of the partition: ', p^.h : 0 :1,
				'	current value: ', p^.i : 0 : 1,
				'	current epsilon: ', p^.eps : 0 : 1);
        writeln;
        i := i + 1;
        p := p^.next;
    end;
    writeln;
end;

procedure delete_root(var po: journal_root_list_t);
var p, d: ^list_root_item;
begin
    p := po.head;
    while (p <> nil) do
    begin
        d := p;
        p := p^.next;
        dispose(d);
    end;
end;

procedure delete_int(var po: journal_int_list_t);
var p, d: ^list_int_item;
begin
    p := po.head;
    while (p <> nil) do
    begin
        d := p;
        p := p^.next;
        dispose(d);
    end;
end;
end.
