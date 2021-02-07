uses root_int,
     integral_int,
     print_int,
     graph_int;

var eps, max_distance: real;
    mode, f_roots, f_int, f_graph: integer; 
    jou_root_12, jou_root_13, jou_root_23: journal_root_list_t;
    jou_int_1, jou_int_2, jou_int_3: journal_int_list_t;


procedure result_code(i: integer);
begin
    if (i = 1) then
        writeln('Sorry, limit number of iterations reached');
    if (i = 2) then
        writeln('Sorry, it is a wrong segment');
    halt;
end;

procedure debug_mode(eps, max_distance: real; f_roots, f_int, 
                     f_graph: integer);
var
    x1, x2, x3, i1, i2, i3, S: real;
    code: integer;

begin
    code := root(@F_test_12, max_distance, 1.6, 1.7, x1, jou_root_12, f_roots);
	if (code = 0) then
	    writeln('x1 = ', x1)
	else
	    result_code(code);
	code := root(@F_test_13, max_distance, 0.45, 0.55, x2, jou_root_13, f_roots);
	if (code = 0) then
	    writeln('x2 = ', x2)
	else
	    result_code(code);
	code := root(@F_test_23, max_distance, -1.4, -1.3, x3, jou_root_23, f_roots);
	if (code = 0) then
	    writeln('x3 = ', x3)
	else
	    result_code(code);
	code := integral(@F_test_1, x2, x1, eps, jou_int_1, i1, f_int);
	if (code = 0) then
	    writeln('integral 1 = ', i1)
	else
	    result_code(code);
	code := integral(@F_test_2, x3, x1, eps, jou_int_2, i2, f_int);
	if (code = 0) then
	    writeln('integral 2 = ', i2)
	else
	    result_code(code);
	code := integral(@F_test_3, x3, x2, eps, jou_int_3, i3, f_int);
	if (code = 0) then
	    writeln('integral 3 = ', i3)
	else
	    result_code(code);
	S := i1 - i2 + i3;
	writeln('Area = ', S);
    if (f_graph = 1) then
	    graphtest (x1, x2, x3, s);
end;


procedure not_debug_mode(eps, max_distance: real; f_roots, f_int, f_graph: integer);
var
    x1, x2, x3, i1, i2, i3, S: real;
    code: integer;
begin
    code := root(@F_12, max_distance, 1.3, 1.4, x1, jou_root_12, f_roots);
	if (code = 0) then
	    writeln('x1 = ', x1)
	else
	    result_code(code);
	code := root(@F_13, max_distance, -1.4, -1.3, x2, jou_root_13, f_roots);
	if (code = 0) then
	    writeln('x2 = ', x2)
	else
	    result_code(code);
	code := root(@F_23, max_distance, 0.8, 0.9, x3, jou_root_23, f_roots);
	if (code = 0) then
	    writeln('x3 = ', x3)
	else
	    result_code(code);
	code := integral(@F_1, x2, x1, eps, jou_int_1, i1, f_int);
	if (code = 0) then
	    writeln('integral 1 = ', i1)
	else
	    result_code(code);
	code := integral(@F_2, x3, x1, eps, jou_int_2, i2, f_int);
	if (code = 0) then
	    writeln('integral 2 = ', i2)
	else
	    result_code(code);
	code := integral(@F_3, x2, x3, eps, jou_int_3, i3, f_int);
	if (code = 0) then
	    writeln('integral 3 = ', i3)
	else
	    result_code(code);
	S := i1 - i2 - i3;
	writeln('Area S is = ', S);
	if (f_graph = 1) then
	    graph(x1, x2, x3, s);
end;


begin
    writeln('Please, write epsilon: ');
    readln(eps);
    writeln('Please, write max distance: ');
    readln(max_distance);
    writeln('Do you want to keep a journal for roots? (0 - NO, 1 - YES)');
    readln(f_roots);
    writeln('Do you want to keep a journal for integrals? (0 - NO, 1 - YES)');
    readln(f_int);
    writeln('Do you want to work in debug mode or standart mode? (0 - Standart mode, 1 - Debug mode)');
    readln(mode);
    writeln('Do you want to print graph? (0 - NO, 1 - YES)');
    readln(f_graph);
    if (mode = 1) then
        debug_mode(eps, max_distance, f_roots, f_int, f_graph)
    else
        not_debug_mode(eps, max_distance, f_roots, f_int, f_graph);
    if (f_roots = 1) then begin
        print_root(jou_root_12);
        print_root(jou_root_13);
        print_root(jou_root_23);
        delete_root(jou_root_12);
        delete_root(jou_root_13);
        delete_root(jou_root_23);
    end;
    writeln;
    if (f_int = 1) then begin
        print_i(jou_int_1);
        print_i(jou_int_2);
        print_i(jou_int_3);
        delete_int(jou_int_1);
        delete_int(jou_int_2);
        delete_int(jou_int_3);
    end;
end.
