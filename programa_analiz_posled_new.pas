program analiz_posledovatelnosti;
var
    eps, d, q, x_real, g1, i_new, eps_tochn: real;
    i, j, amount_of_points, char_after_point, n, j1, x1_integer, amount_of_digits, 
    t, length_of_palindrome, g, amount_of_minuses, start, finish,
    max_length_pal, rank, char_after_p_eps, g_new: integer;
    task_a, task_b, det_arith_progres, det_geom_progres, 
    point, det_negative, spaces_after_num, det_error, flag: boolean;
    mas: array of real;
    prev_character, c: char;
    
{d - difference of arithmetic progression
q -coefficient of geometric progression
с - current character to be read
prev_character - previous character 
n - number of elements
x_real - variable, for string conversion (type real)
x1_integer - variable, for string conversion (type integer)
length_of_palindrome - the size of the current palindrome
t - the first encountered element of the sequence equal to mas[1],
t - the number of elements in the period (if any)
amount_of_points - number of digits after the dot
amount_of_minuses - number of minuses 
amount_of_digits - number of digits in the number (must not exceed 255)
amount_of_points - the number of points
char_after_point - number (characters) after the point
point - point detector, if False-integer
rank - rank of 10
det_negative - negativity detector
spaces_after_num - detection of spaces after a number
det_error - error detector, if True - stop reading the element
task_a - ascending detector
task_b - non-decreasing detector
det_arith_progres - detector is an arithmetic progression 
det_geom_progres - detector geometric progression}

Function Identity(f,h,epsilon:real):boolean;
begin
    if abs(f - h) <= epsilon then 
        identity := true
    else  
        identity := false;
    end;

Procedure Def(); {The Def procedure assigns an initial value to the elements}
    begin
        point := false; 
        char_after_point := 0; 
        det_error := false; 
        det_negative := false;
        spaces_after_num := false; 
        prev_character := ' '; 
        x_real := 0; 
        amount_of_points := 0; 
        amount_of_digits := 0;
        rank := 1;
        x1_integer := 0;
    end;
    
begin
    Writeln('Enter a real nonnegative number:');
    amount_of_minuses := 0;
    Def;
    repeat
        Def;
        if eof() then 
          begin
              Writeln('Input empty string or end of file');
              halt(1);
          end;
        repeat
            Read(c);
            if eof() then 
            begin
                Writeln('Input empty string or end of file');
                halt(1);
            end;
            amount_of_digits := amount_of_digits + 1;
            if (((c < '0') or (c > '9')) and (c <> ' ') and (c <> '.') 
            and (c <> '-'))
            or (amount_of_points > 1) or (((prev_character = ' ')
            or (prev_character = '-')) and (c = '.')) or 
            ((spaces_after_num = true)
            and (c <> ' ')) then
            begin
                det_error := true;
                Writeln('Error input, please, re-enter:');
                x_real := 0;
            end
            else
                begin
                if (c = '-') or (det_negative = true) then 
                    det_negative := true
                else
                begin
                    if (prev_character <> ' ') and (c = ' ') then 
                        spaces_after_num := true;
                    if ((c >= '0') and (c <= '9')) or (c = '.') then
                    begin
                        if (c <> '.') and (point = false) then
                        begin
                            x_real := 10*x_real;
                            x_real := x_real + ord(c) - ord('0');
                        end;
                        if c = '.' then
                        begin
                            point := true;
                            amount_of_points := amount_of_points + 1;
                        end;
                        if (c <> '.') and (point = true) then
                        begin
                           char_after_point := char_after_point + 1;
                           for i := 1 to char_after_point do
                               rank := rank * 10; 
                           x_real := x_real + 
                           (ord(c) - ord('0'))/rank;
                        end;
                    end;
                end;
            end;
            prev_character := c;
            char_after_p_eps := char_after_point;
            until (eoln) or (det_error = true);
                if (amount_of_digits = 1) and (c = ' ') then
                begin
                    det_error := true;
                    Writeln('Error input, please, re-enter:');
                end;
                if det_negative = true then
                begin
                    det_error := true;
                    Writeln('Error input, please, re-enter:');
                end;
                Readln;
            until (det_error = false);
        eps := x_real;       

        Def;
        Writeln('Enter amount of sequence elements');
        repeat
            Def;
            if eof() then 
            begin
                Writeln('Input empty string or end of file');
                halt(1);
            end;
            repeat
                Read(c);
                if eof() then 
                begin
                    Writeln('Input empty string or end of file');
                    halt(1);
                end;
                amount_of_digits := amount_of_digits + 1;
                 if (((c < '0') or (c > '9')) and (c <> ' ')) or
                ((spaces_after_num = true) and (c <> ' ')) then
                begin
                    det_error := true;
                    Writeln('Error input,please,re-enter:');
                    x_real := 0;
                end
                else
                begin
                    if (prev_character <> ' ') and (c = ' ') then 
                       spaces_after_num := true;
                    if ((c >= '0') and (c <= '9'))then
                    begin
                        x1_integer := 10*x1_integer;
                        x1_integer := x1_integer+ord(c)-ord('0');
                    end;
                end;
                prev_character := c;
            until (eoln) or (det_error = true);
            if ((amount_of_digits = 1) and (c = ' ')) or ((amount_of_digits = 1) 
            and (c = '0')) then
            begin
                det_error := true;
                Writeln('Error input,please, re-enter:');
            end;
            Readln;
        until (det_error = false);
    n := x1_integer;
    setlength(mas,n);
    
    Def;
    Writeln('Enter value of the sequence element:');
    for i:=0 to n-1 do
    begin
        repeat
            if eof() then 
            begin
                Writeln('Input empty string or end of file');
                halt(1);
            end;
            Def;
            repeat
                Read(c);
                amount_of_digits := amount_of_digits + 1;
                if (((c < '0') or (c > '9')) and (c <> ' ') and (c <> '.') 
                and (c <> '-')) or ((prev_character >= '0') and 
                (prev_character <= '9') and (c = '-'))
                or (amount_of_points > 1) or (((prev_character = ' ')
                or (prev_character = '-')) and (c = '.')) 
                or ((spaces_after_num = true)
                and (c <> ' ')) then
                begin
                    det_error := true;
                    Writeln('Error input,please, re-enter:');
                    x_real := 0;
                end
                else
                begin
                    if((prev_character = ' ') and (c = '-'))or 
                    ((prev_character = '-') and (c = '-')) or ((prev_character = '-') and (c = '0')) then
                    begin
                        amount_of_minuses := amount_of_minuses + 1;
                        if odd(amount_of_minuses) then 
                            det_negative := true
                        else 
                            det_negative := false;
                    end
                    else
                    begin
                        if (prev_character <> ' ') and (c = ' ') then 
                            spaces_after_num := true;
                        if ((c >= '0') and (c <= '9')) or (c = '.') then
                        begin
                            if (c <> '.') and (point = false) then
                            begin
                                x_real := 10*x_real;
                                x_real := x_real + ord(c) - ord('0');
                            end;
                            if c = '.' then
                            begin
                                point := true;
                                amount_of_points := amount_of_points + 1;
                            end;
                            if (c <> '.') and (point = true) then
                            begin
                                char_after_point := char_after_point + 1;
                                for j := 1 to char_after_point do
                                    rank := rank * 10; 
                                x_real := x_real + 
                                (ord(c) - ord('0'))/rank;
                            end;
                        end;
                    end;
                end;
                prev_character := c;
            until (eoln) or (det_error = true);
            if eof then
            begin
                det_error := true;
                Writeln('Error input, please, re-enter:');
            end;
            if (amount_of_digits = 1) and ((c = ' ') or (c = '-')) then
            begin
                det_error := true;
                Writeln('Error input, please, re-enter:');
            end;
            if det_negative = true then 
                x_real := (-1)*x_real;
            Readln;
        until (det_error = false);
        mas[i] := x_real;
     end;

    setlength(mas,n);
    if n = 1 then
    begin
        d := 0;
        q := 0;
        task_a := true;
        task_b:= true;
        t := 1;
    end
    else
    begin
    task_a := true; task_b := true; det_arith_progres := true; 
    det_geom_progres := true;
    t := 0; 
    d := mas[1] - mas[0];
    q := mas[1] / mas[0];
    i := 0;
    repeat
    begin
        task_a := (mas[i] < mas[i + 1]);
        i := i + 1;
    end;
    until (task_a = false) or (i >= (n - 1));
    i := 0;
    repeat
    begin
        task_b := (mas[i] <= mas[i + 1]);
        i := i + 1;
    end;
    until (task_b = false) or (i >= (n - 1));
    if n > 2 then
    begin
        for i := 1 to n - 2 do
            if (mas[i] < (mas[i-1]+d)-eps) or (mas[i] > (mas[i-1]+d)+eps) then
                det_arith_progres := false;
            if det_arith_progres = false then
            begin
                  for i := 1 to n - 2 do
                    if (mas[i] < (mas[i-1]*q) - eps) or 
                    (mas[i] > (mas[i-1]*q)+eps) then
                        det_geom_progres := false;
            end;
    end
    else
        if n = 2 then
             q:= mas[1]/mas[0];
             
       g:=0;
       t:=0;
       g_new:= 0;
       for i:=1 to n-1 do
        begin
				for j := 0 to char_after_p_eps - 1 do
				    eps_tochn := eps * 10;
				    eps_tochn := trunc(eps_tochn);
				for j1 := 1 to n - 1 do
				begin
			     for j := 0 to char_after_p_eps - 1 do
					 begin
					     i_new := mas[i] * 10;
						   g1 := mas[g_new] * 10;
					 end;
				   i_new := trunc(i_new);
					 g1 := trunc(g1);
				end;
          if (abs(i_new - g1) <= eps_tochn) and (g = 0) then
          begin
              g := 1;
              t := i;
          end
          else 
              if (abs(i_new - g1) <= eps_tochn) and (g > 0) then 
                  g := g + 1
              else 
                  if (abs(i_new - g1) >= eps_tochn) and (g > 0) then
                  begin
                      t := -1;
                      g := 0;
                  end;
              if t = -1 then 
              t := 0;
              if g = n-1 then
                  t := 0;
        end;

        length_of_palindrome := 0;
        max_length_pal := 0;
        for i := 1 to n-1 do
        begin
            for j := 0 to i - 1 do
            begin
                if Identity(mas[i], mas[j], eps) then
                  begin
                      length_of_palindrome := i - j + 1;
                      start := i;
                      finish := j;
                      flag := true;
                      while (finish < start) do
                      begin
                          if identity(mas[start],mas[finish],eps) = false then 
                              flag := false;
                          start := start - 1;
                          finish := finish + 1;
                      end;
                      if (length_of_palindrome > max_length_pal) 
                      and (flag = true) then
                          max_length_pal := length_of_palindrome;
                  end;
              end;
          end;
    end;
    Writeln('The sequence increases: ',task_a);
    Writeln('The sequence does not decrease: ',task_b);
    if (det_arith_progres = true) or (n = 1) then
        Writeln('Difference of arithmetic progression: ',d)
    else
        Writeln('Arithmetic progression: ',det_arith_progres);
    if (det_geom_progres = true) or (n = 1) then
        Writeln('The denominator of a geometric progression: ',q)
    else
        Writeln('Geometric progression: ',det_geom_progres);
    Writeln('Period: ',t);
    Writeln('Length of palindrome: ',max_length_pal);
end.
