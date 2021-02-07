program lists_108;

type
    list_link_t = ^link_t;
    bidirect_list_t = record
        head: list_link_t;
        tail: list_link_t
    end;
    link_t = record
        prev: list_link_t;
        next: list_link_t;
        data: array of char;
        coma: integer;
    end;


var list: bidirect_list_t;
    list_1, list_2: list_link_t;
    sym: char = ' ';
    f: string[20];
    i: integer = 0;

{enter a list}
procedure text_input;
var
    list_in: list_link_t;
    symbol: char;
    length_of_list: integer = 0;
begin
    list_in:= nil;
    length_of_list:= 0;
    if eof then 
        halt;
    repeat
        if eof then 
            halt;
        length_of_list:= 0;
        New (list_in);
        if not eoln and not eof then
        repeat
            if eof then 
                halt;
            Read (symbol);
            length_of_list:= length_of_list + 1;
            SetLength (list_in^.data, length_of_list); {set the size of the array 
            which we need}
            list_in^.data [length_of_list-1]:= symbol;
        until eoln or eof;
        list_in^.next:= nil;
        list_in^.prev:= list.tail;
        if list.head = nil then 
        begin
            list.tail:= list_in;
            list.head:= list_in;
        end
        else 
        begin
            list.tail^.next:= list_in;
            list.tail:= list_in;
        end;
        Readln;
    until (length_of_list = 1) and (list_in^.data [length_of_list-1] = '.');
    list.tail:= list.tail^.prev;
    dispose (list.tail^.next);
    list.tail^.next:= nil;
end;

{determine the length of the list}
function length_of_list: integer;
var 
    i:integer;
    list_in: list_link_t;
begin
     i:= 0;
     list_in:= list.head;
    while list_in <> nil do 
    begin
        i:= i + 1;
        list_in:= list_in^.next;
    end;
    length_of_list:= i;
end;

{procedure that helps to change lists}
procedure change (var list_1, list_2: list_link_t);
var 
    list_in: list_link_t;
begin
    if list_1^.prev = nil then
        list.head:= list_2
    else
        list_1^.prev^.next:= list_2;
    if list_2^.next = nil then
        list.tail:= list_2
    else
        list_2^.next^.prev:= list_1;
    list_2^.prev:= list_1^.prev;
    list_1^.prev:= list_2;
    list_1^.next:= list_2^.next;
    list_2^.next:= list_1;
    list_in:= list_1;
    list_1:= list_2;
    list_2:= list_in;
end;

{this procedure is a complete analogue of the 'change' procedure, 
 but is used to aid the 'sort_merge'procedure}
procedure change_for_merge (var list_1, list_2: list_link_t);
var 
    list_in: list_link_t;
begin
    if list_1^.prev = nil then
        list.head:= list_2;
    if list_2^.next = nil then
        list.tail:= list_2;
    list_2^.prev:= list_1^.prev;
    list_1^.prev:= list_2;
    list_1^.next:= list_2^.next;
    list_2^.next:= list_1;
    list_in:= list_1;
    list_1:= list_2;
    list_2:= list_in;
end;

{help us to make sort_coma procedure}
function comma_help (list_in: list_link_t): integer;
var 
    i, j: integer;
begin
    j:= 0;
    for i:= 0 to high (list_in^.data) do
        if list_in^.data[i] = ',' then
            j:= j +1;
    comma_help:= j;
end;

{sort by the number of commas in descending order}
procedure sort_coma;
var
    list_1, list_2: list_link_t;
    i, j, tmp: integer;
begin
    list_1:= list.head;
    tmp:= length_of_list;
    for i := 1 to tmp-1 do 
    begin
        list_1:= list.head;
        for j:= 1 to tmp-i do 
        begin
            if comma_help (list_1) < comma_help (list_1^.next) then
            begin
                list_2:= list_1^.next;
                change (list_1, list_2);
            end;
            list_1:= list_1^.next;
        end;
    end;
end;

{assistance in checking the balance of brackets}
function imbalance (list_in: list_link_t): integer;
var 
    i, j, balance_of_braces: integer;
begin
    j := 0;
    balance_of_braces:= 0;
    for i:= 0 to high (list_in^.data) do
        if list_in^.data[i] = '(' then
            balance_of_braces:= balance_of_braces + 1
        else 
            if list_in^.data[i] = ')' then
            if balance_of_braces = 0 then 
                    j:= j + 1
            else 
                balance_of_braces:= balance_of_braces - 1;
    imbalance:= j + balance_of_braces;
end;

{checking balance of brackets}
procedure sort_imbalance;
var
    list_1, list_2: list_link_t;
    i, j, length: integer;
begin
     list_1:= list.head;
     length:= length_of_list;
    for i:= 1 to length-1 do 
    begin
        list_1:= list.head;
        for j:= 1 to length-i do 
        begin
            if imbalance(list_1) > imbalance(list_1^.next) then 
            begin
                list_2 := list_1^.next;
                change (list_1, list_2);
            end;
            list_1 := list_1^.next;
        end;
    end;
end;

{return TRUE , if first string longer than second, FALSE on the contrary}
function compa (list_1, list_2: list_link_t): boolean;
var 
    i, min: integer;
    f_bool: boolean = true;
begin
    compa:= true;
    if high (list_1^.data) >= high (list_2^.data) then
        min:= high (list_2^.data)
    else
        min:= high (list_1^.data);
    for i:= 0 to min do
    begin
        if list_1^.data[i] <> list_2^.data[i]  then
        begin
            if list_1^.data[i] < list_2^.data[i] then
                compa:= false;
            f_bool:= false;
            break;
        end;
    end;
    if f_bool and (high (list_2^.data) > high (list_1^.data)) then
        compa:= false;
end;

{a procedure that helps you insert a list}
procedure embed_list (list_1, list_2:list_link_t);
begin
    if list_1^.next <> nil then
        list_1^.next^.prev:= list_1^.prev
    else
        list.tail:= list_1^.prev;
    list_1^.prev^.next:= list_1^.next;
    if list_2^.prev <> nil then
        list_2^.prev^.next:= list_1
    else
        list.head:= list_1;
    list_1^.prev:= list_2^.prev;
    list_1^.next:= list_2;
    list_2^.prev:= list_1;
end;

{sort the string as in the dictionary in ascending order}
procedure sort_up;
var 
    list_1, list_2, list_in: list_link_t;
begin
    list_1:= list.head^.next;
    while list_1 <> nil do 
    begin
        list_2:= list_1;
        list_in:= list_1^.next;
        while (list_2^.prev <> nil) and (compa (list_2^.prev, list_1)) do 
             list_2:= list_2^.prev;
        if list_1 <> list_2 then 
            embed_list (list_1,list_2);
        list_1:= list_in;
    end;
end;

{a sort that arranges a list in a specific order}
procedure sort_merge (var list_1, list_2, list_3: list_link_t);
var 
    stop_1, stop_2, stop_3, list_t, list_s, list_v: list_link_t;
begin
    list_s:= nil;
    stop_1:= list_2^.next;
    stop_2:= list_1^.prev;
    stop_3:= list_3;
    list_2^.next:= nil;
    stop_3^.prev^.next:= nil;
    while (list_3 <> nil) or (list_1 <> nil) do
    begin
        if list_1 <> nil then
        begin
            if (list_3 = nil) or (compa (list_1, list_3)) then
            begin
                list_v:= list_1;
                list_1:= list_1^.next;
                if list_s = nil then
                begin
                    list_s:= list_v;
                    list_v^.prev:= nil;
                    list_t:= list_v;
                end
                else 
                begin
                    list_s^.next:= list_v;
                    list_v^.prev:= list_s;
                    list_s:= list_s^.next;
                end;
            end
            else
            begin
                list_v:= list_3;
                list_3:= list_3^.next;
                if list_s = nil then
                begin
                    list_s:= list_v;
                    list_v^.prev:= nil;
                    list_t:= list_v;
                end
                else 
                begin
                    list_s^.next:= list_v;
                    list_v^.prev:= list_s;
                    list_s:= list_s^.next;
                end;
            end;
        end
        else 
        begin
            list_v:= list_3;
            list_3:= list_3^.next;
            if list_s = nil then
            begin
                list_s:= list_v;
                list_v^.prev:= nil;
                list_t:= list_v;
            end
            else 
            begin
                list_s^.next:= list_v;
                list_v^.prev:= list_s;
                list_s:= list_s^.next;
            end;
        end;
    end;
    list_s^.next := stop_1;
    if stop_1 <> nil then
        stop_1^.prev:= list_s;
    list_t^.prev:= stop_2;
    if stop_2 <> nil then
        stop_2^.next:= list_t;
    list_1:= list_t;
    list_2:= list_s;
end;

{sort strings in lexicographic descending order}
procedure sort_down (var list_1, list_2: list_link_t);
var 
    list_a, list_b, middle_of_lists: list_link_t;
begin
    if list_1 <> list_2 then
    begin
        if list_2 = list_1^.next then
        begin
            if compa (list_2, list_1) then
            begin
                change_for_merge (list_1,list_2);
            end
        end
        else
        begin
            while (list_1 <> list_2) and (list_1^.next <> list_2) do
            begin
                list_1:= list_1^.next;
                list_2:= list_2^.prev;
            end;
            middle_of_lists:= list_2;
            list_a:= middle_of_lists;
            list_b:= list_a^.prev;
            sort_down (list_1, list_b);
            sort_down (list_a, list_2);
            while (list_1 <> list_2) and (list_1^.next <> list_2) do
            begin
                list_1:= list_1^.next;
                list_1:= list_2^.prev;
             end;
            middle_of_lists:=list_2;
            list_a:= middle_of_lists;
            sort_merge (list_1, list_2, list_a);
        end;
    end;
end;

{removes unnecessary (in particular - comments)}
procedure delete_comments (list_1, list_2: list_link_t; j, k: integer);
var 
    list_a, list_b: list_link_t;
    i, tmp: integer;
begin
    if list_1 = list_2 then
    begin
        for i:= j to j + high (list_1^.data) - k - 1 do
            list_1^.data[i]:= list_1^.data[i + k - j + 1];
        SetLength (list_1^.data, high (list_1^.data) - k + j);
    end
    else 
    begin
        list_a:= list_1^.next;
        while list_a <> list_2 do 
        begin
            list_b:= list_a;
            list_a:= list_a^.next;
            list_b^.next^.prev:= list_b^.prev;
            list_b^.prev^.next:= list_b^.next;
            dispose (list_b);
        end;
        tmp:= high (list_2^.data);
        SetLength (list_2^.data, j + tmp - k);
        for i:= j to tmp - k - 1 + j do
            list_2^.data[i]:= list_2^.data[i + k - j + 1];
        for i:= 0 to j - 1 do
            list_2^.data[i]:= list_1^.data[i];
        list_b:= list_1;
        list_b^.next^.prev:= list_b^.prev;
        if list_b^.prev <> nil then
            list_b^.prev^.next:= list_b^.next
        else
            list.head:= list_b^.next;
        dispose (list_b);
    end;
end;

{search comments and use procedure "delete_comments" to delete them}
procedure clear_comments;
var 
    list_tmp_a, list_tmp_b, list_tmp_c, list_tmp_d, list_tmp_f: list_link_t;
    i, j, k, j_j, k_k: integer;
    fl, z: boolean;
begin
    list_tmp_a:= list.head;
    j:= -1;
    j_j:= -1;
    k_k:= -1;
    k:= -1;
    z:= false;
    while list_tmp_a <> nil do 
    begin
        fl := true;
        for i:= 0 to high (list_tmp_a^.data) do 
        begin
            if (ord(list_tmp_a^.data[i]) = 39) and (j = -1) and (j_j = -1) then
                    z:= not z
            else 
                if (list_tmp_a^.data[i] = '{') and (j = -1) and (not z) then 
                begin
                    list_tmp_b:= list_tmp_a;
                    j:= i;
                end
            else 
                if (list_tmp_a^.data[i] = '}') and (j >= 0) then 
                begin
                    list_tmp_c:= list_tmp_a;
                    k:= i;
                end
            else 
                if (list_tmp_a^.data[i] = '(') and (list_tmp_a^.data[i + 1] = '*') and (j_j = -1) and (not z) then 
                begin
                    list_tmp_d:= list_tmp_a;
                    j_j:= i;
                end
            else 
                if (list_tmp_a^.data[i] = '*') and (list_tmp_a^.data[i + 1] = ')') and (j_j >= 0) then 
                begin
                    list_tmp_f:= list_tmp_a;
                    k_k := i + 1;
                end;
            if (j >= 0) and (k >= 0) then 
            begin
                delete_comments (list_tmp_b, list_tmp_c, j, k);
                j:= -1;
                k:= -1;
                fl:= false;
                break;
            end;
            if (j_j >= 0) and (k_k >= 0) then 
            begin
                delete_comments (list_tmp_d, list_tmp_f, j_j, k_k);
                j_j:= -1;
                k_k:= -1;
                fl:= false;
                break;
            end;
        end;
        if fl then
            list_tmp_a:= list_tmp_a^.next;
    end;
    list_tmp_a:= list.head;
    z:= false;
    while list_tmp_a <> nil do 
    begin
        for i:= 0 to high (list_tmp_a^.data) do 
        begin
            if ord (list_tmp_a^.data[i]) = 39 then
                z:= not z
            else 
                if (list_tmp_a^.data[i] = '/') and (list_tmp_a^.data[i - 1] = '/') and (not z) then
                begin
                    delete_comments (list_tmp_a, list_tmp_a, i - 1, high(list_tmp_a^.data));
                    break;
                end;
        end;
        list_tmp_a:= list_tmp_a^.next;
    end;
end;

{procedure "bag_list" helps to do procedure "clear_style"; this procedure helps 
 to move 'begin' and 'end'}
procedure bag_list (list_in: list_link_t; j, i: integer);
var 
    list_tmp: list_link_t = nil;
    tmp_1, tmp_2: integer;
begin
    if j + i - 1 < high (list_in^.data) then 
    begin
        new (list_tmp);
        SetLength (list_tmp^.data, high (list_in^.data) - j - i + 1);
        list_tmp^.data:= copy (list_in^.data, j + i, high (list_in^.data));
        list_tmp^.next:= list_in^.next;
        if list_tmp^.next <> nil then
            list_tmp^.next^.prev:= list_tmp
        else 
            list.tail:= list_tmp;
        list_tmp^.prev:= list_in;
        list_in^.next:= list_tmp;
        list_tmp:= nil;
    end;
    if j = 0 then 
        SetLength (list_in^.data, i)
    else 
    begin
        tmp_1:= 0;
        while list_in^.data[tmp_1] = ' ' do
            tmp_1:= tmp_1 + 1;
        if tmp_1 = j then
            SetLength (list_in^.data, j + i)
        else
        begin
            new (list_tmp);
            SetLength (list_tmp^.data, i + tmp_1);
            for tmp_2:= 0 to tmp_1 - 1 do
                list_tmp^.data[tmp_2]:= ' ';
            for tmp_2:= tmp_1 to (i + tmp_1 - 1) do
                list_tmp^.data[tmp_2]:= list_in^.data[j + tmp_2 - tmp_1];
            list_tmp^.next:= list_in^.next;
            if list_tmp^.next <> nil then
                list_tmp^.next^.prev:= list_tmp
            else
                list.tail:= list_tmp;
            list_tmp^.prev:= list_in;
            list_in^.next:= list_tmp;
            SetLength (list_in^.data, j);
        end;
    end;
end;

{put "begin" and " end " according to the rules of registration}
procedure clear_style;
var 
    list_tmp: list_link_t;
    i: integer;
begin
    list_tmp:= list.tail;
    while list_tmp <> nil do 
    begin
        for i:= high (list_tmp^.data) - 4 downto 0 do
            if (list_tmp^.data[i] = 'b') and (list_tmp^.data[i + 1] = 'e')
            and (list_tmp^.data[i + 2] = 'g') and (list_tmp^.data[i + 3] = 'i')  
            and (list_tmp^.data[i + 4] = 'n') then
                bag_list (list_tmp, i, 5);
        list_tmp:= list_tmp^.prev;
    end;
    list_tmp:= list.tail;
    while list_tmp <> nil do 
    begin
        for i:= high (list_tmp^.data) - 2 downto 0 do
            if (list_tmp^.data[i] = 'e') and (list_tmp^.data[i + 1] = 'n') 
            and (list_tmp^.data[i + 2] = 'd') then
                bag_list (list_tmp, i, 3);
        list_tmp:= list_tmp^.prev;
    end;
end;

{helps to better orientation in commands}
procedure help_for_program;
begin
    Writeln ('sort-up',#10,'sort-down',#10,'sort-coma',#10,'sort-imbalance',#10,
             'clear-comments',#10,'clear-style',#10,'print');
end;

{print our new list}
procedure print_list;
var 
    list_tmp: list_link_t;
    i: integer;
begin
    list_tmp:= list.head;
    while list_tmp <> nil do 
    begin
        for i:= 0 to high (list_tmp^.data) do
            write (list_tmp^.data[i]);
        writeln;
        list_tmp:= list_tmp^.next;
    end
end;

procedure clean_our_lists;
var
    list_1, list_2: list_link_t;
begin
    list_1:= list.head;
    while list_1 <> nil do
    begin
        list_2:= list_1;
        list_1:= list_1^.next;
        list_2^.data:= nil;
        dispose (list_2);
    end;
end;


begin
    list.head := nil;
    list.tail := nil;
    text_input;
    if not eof then
    repeat
        i:= 0;
        if not eoln then
        begin
            repeat
                read (sym);
                i:= i + 1;
            until (sym <> ' ') and (ord (sym) <> 9);
            read (f);
            if (sym <> '#') then
            begin
                f := sym + f;
                if Pos ('sort-up', f) = 1 then
                    sort_up
                else 
                    if Pos ('sort-down', f) = 1 then
                        sort_down (list.head, list.tail)
                else 
                    if Pos ('sort-coma', f) = 1 then
                        sort_coma 
                else 
                    if Pos ('sort-imbalance', f) = 1 then
                        sort_imbalance
                else 
                    if Pos ('clear-comments', f) = 1 then
                        clear_comments
                else 
                    if Pos ('clear-style', f) = 1 then
                        clear_style
                else 
                    if Pos ('print', f) = 1 then
                        print_list
                else 
                    if Pos('help', f) = 1 then
                        help_for_program
            end;
        end;
        readln;
    until ((f = '.') and (i = 1)) or (eof);
    list_1:= list.head;
    while list_1 <> nil do
    begin
        list_2:= list_1;
        list_1:= list_1^.next;
        list_2^.data:= nil;
        dispose (list_2);
    end;
end.