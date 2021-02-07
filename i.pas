uses root_of_integral1,
     integral_integral,
     print_integral,
     graph_integral;
type 
	func_real_t = function (x: real): real;
	
var x13, x12, x23, S1, S2, S3, S, a, b: real;
	epsilon, max_interval_to_root: real;
	n, amount_of_itterations, itteration_number, h, t: integer;
	x1, x2, x3, x4, x5, x6: journal_list_t;
	
{the main begin}
begin
	x1.tail := nil;
	x2.tail := nil;
	x3.tail := nil;
	x4.tail := nil;
	x5.tail := nil;
	x6.tail := nil;
	amount_of_itterations := 60;
	{read max_distance_to_root}
	writeln('Choose mode: 0 (work mode); any other number - test mode');
	read(t);
	writeln('Inject the distance between roots ');
	read(max_interval_to_root);
	while (max_interval_to_root > 0.1) do 
	begin
		writeln('This value is not correct, inject another one');
		read(max_interval_to_root);
	end;
	{read epsilon}
	writeln ('Inject the epsilon for the area');
	read(epsilon);
	while (epsilon > 0.1) do 
	begin
		writeln('This value is not correct, inject another one');
		read(epsilon);
	end;
	if (t <> 0) then
	begin
		{DetectGraph (Driver, Mode); /// pridets ubrat}
		writeln('Find roots');
		writeln();
		a := 1.6; b := 1.7;
		itteration_number := 0;
		root(@test1, @test2, max_interval_to_root, a, b, x12, amount_of_itterations, h, x1);
		writeln('x12 is ', x12);
		a := 0.45; b := 0.55;
		itteration_number := 0;
		root(@test1, @test3, max_interval_to_root, a, b, x13, amount_of_itterations, h, x2);
		writeln('x13 is ', x13);
		a := -1.4; b := -1.3;
		itteration_number := 0;
		root(@test2, @test3, max_interval_to_root, a, b, x23, amount_of_itterations, h, x3);
		writeln('x23 is ', x23);
		{-----}	
		n := 8;
		writeln();
		itteration_number := 0;
		S1 := integral(@test2, x12, x23, epsilon, n, 
		amount_of_itterations, itteration_number, x4);
		writeln('S1 =  ', S1);
		itteration_number := 0;
		S2 := integral(@test3, x23, x13, epsilon, n, 
		amount_of_itterations, itteration_number, x5);
		writeln('S2 =  ', S2);
		itteration_number := 0;
		S3 := integral(@test1, x12, x13, epsilon, n, 
		amount_of_itterations, itteration_number, x6);
		writeln('S3 =  ', S3);
		S := S1 + S2 + S3;
		writeln('The area between functions:', S);		
		ggra(x12, x13, x23, t);
	end
	else	
	begin	
		a := 1.3; b := 1.4;
		itteration_number := 0;
		root(@F1, @F2, max_interval_to_root, a, b, x12, amount_of_itterations, h, x1);
		writeln('x12 is ', x12);
		a := -1.4; b := -1.3;
		itteration_number := 0;
		root(@F1, @F3, max_interval_to_root, a, b, x13, amount_of_itterations, h, x2);
		writeln('x13 is ', x13);
		a := 0.0; b := 1.0;
		itteration_number := 0;
		root(@F2, @F3, max_interval_to_root, a, b, x23, amount_of_itterations, h, x3);
		writeln('x23 is ', x23);
		n := 8;
		writeln();
		itteration_number := 0;
		S1 := integral (@F2, x23, x12, epsilon, n, 
		amount_of_itterations,
		itteration_number, x4);
		writeln('S1 =  ', S1);
		itteration_number := 0;
		S2 := integral(@F3, x13, x23, epsilon, n, amount_of_itterations, 
		itteration_number, x5);
		writeln('S2 =  ', S2);
		itteration_number := 0;
		S3 := integral(@F1, x13, x12, epsilon, n, amount_of_itterations, 
		itteration_number, x6);
		writeln('S3 =  ', S3);
		S := S1 + S2 + S3;
		writeln('The area between functions:', S);
		ggra(x12, x13, x23, t);
	end;
	writeln();
	writeln('journal of x12:');
	print(x1);
	writeln('journal of x13:');
	print(x2);
	writeln('journal x23:');
	print(x3);
	writeln('journal of S1:');
	print(x4);
	writeln('journal of S2:');
	print(x5);
	writeln('journal of S3:');
	print(x6);
end.
