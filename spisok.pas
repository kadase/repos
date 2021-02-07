program list_sem;

type
    list_node_link = ^list_node;
    list = record
        first: list_node_link;
        last: list_node_link;
        end;
    list_node = record
        data: integer;
        next: list_node_link;
        end;


var
    amount_of_numbers, i, tmp: integer;
    list_input: list;
    
procedure init_list (var input: list);
begin
    input.first := nil;
end;


procedure add_element_in_list (var input: list; data_in: integer);
begin
    if input.first = nil then
    begin
        new (input.first);
        input.first^.data := data_in;
        input.first^.next := nil;
        input.last := input.first;
    end
    else
    begin
        new (input.last^.next);
        input.last^.next^.data := data_in;
        input.last^.next^.next := nil;
        input.last := input.last^.next;
    end;
end;


procedure print_list(input: list);
var cur: list_node_link;
begin
    cur := input.first;
    while cur <> nil do
    begin
        write(cur^.data, '  ');
        cur := cur^.next;
    end;
    writeln;
end;


procedure remove_elements (var first: list_node_link; 
                           var last: list_node_link);
var
    cur, cur_next: list_node_link;
begin
    cur := first^.next;
    cur_next := cur^.next;
    while cur <> last do
    begin
        dispose (cur);
        cur := cur_next;
        cur_next := cur_next^.next;
    end;
    first^.next := last;
end;


procedure remove_increase (var list_input: list);
var
    left_link, right_link: list_node_link; 
begin
    left_link := list_input.first;
    right_link := list_input.first;
    while left_link^.next <> nil do
    begin
        right_link := left_link;
        while right_link^.next <> nil do
        begin
            if right_link^.data >= right_link^.next^.data then 
                break
            else 
                right_link := right_link^.next
        end;
        if right_link <> left_link then
            remove_elements (left_link, right_link);
        left_link := left_link^.next;
    end;
end;

procedure bubble_sort (var list_input: list);
var
    cur1, cur2: list_node_link;
    tmp: integer;
begin
    cur1 := list_input.first;
    while cur1^.next <> nil do
    begin
        cur2 := list_input.first;
        while cur2^.next <> nil do
        begin
            if cur2^.data < cur2^.next^.data then
            begin
                tmp := cur2^.data;
                cur2^.data := cur2^.next^.data;
                cur2^.next^.data := tmp;
            end;
            cur2 := cur2^.next;
        end;
        cur1 := cur1^.next;
    end;
end;

procedure clear_list (var list_input: list);
var
    cur, cur_next: list_node_link;
begin
    cur := list_input.first;
    cur_next := list_input.first^.next;
    while cur <> list_input.last do
    begin
        dispose (cur);
        cur := cur_next;
        cur_next := cur_next^.next;
    end;
    dispose (cur);
end;

begin
    init_list (list_input);
    Writeln ('Enter the number of sequence numbers: ');
    Readln (amount_of_numbers);
    Writeln ('Enter the sequence');
    for i := 1 to amount_of_numbers do
    begin
        Read (tmp);
        add_element_in_list (list_input, tmp);
    end;
    Writeln ('Sequence, which you entered:');
    print_list (list_input);
    if tmp > 0 then
    begin
        remove_increase (list_input);
        writeln ('The altered sequence: ');
        print_list (list_input);
        bubble_sort (list_input);
        Writeln ('Changed sequence (in descending order): ');
        print_list (list_input);
        clear_list (list_input);
    end
    else 
        Writeln ('Nothing changes: ');
end.