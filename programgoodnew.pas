Program P1;

var
  epsilon, x, d, q :real; predsymbol, c : char;
  n, i, j, verh, nizhn, k, lengthp, t, kpt, kt, km, x1, k1, maxlengthp : integer;
  mas : array of real;
  tochka, otr, okch, error, grow, notfall, arith, geom, flag : boolean;
  {
  describing  variables:
  i,j - indexy cicla for
  d - raznost arithm. progression
  q - chastnoe geom. progression
  c - current input symbol
  pred - predydushiy input symbol
  n - amount of elements
  lengthp -length of palindrom
  maxlengthp - max length of palindrom
  t - first meeting element of sequence,which equal mas[1],
  or value of period
  kt - amount point in chislo
  kpt - amount symbols after point
  point - find point in number
  otr - find otric. chislo
  okch - detector availability probel
  error - detector error
  grow - detector up
  notfall - detector notdown
  arith - arith. progression
  geom - geom. progression
  }
 
 //function,which match two numbers with accuracy epsilon
 
Function identity(a, b, e : real):boolean;
begin
    if abs(a - b) < e then identity := true
    else  identity := false;
end;
Procedure equalzero ();
begin
    tochka := false;
    kpt := 0; 
    error := false; 
    otr := false;
    okch := false; 
    predsymbol := ' '; 
    x := 0; 
    kt := 0; 
    k1 := 0; 
    km := 0; 
    x1 := 0;
end;
begin
    writeln('Input rational neotricatelnoe number');
    equalzero ();
      {
      start control neotr epsilon
      }
      repeat
          equalzero ();
          if eof() then 
          begin
              writeln('input empty string or end of file');
              halt(1);
          end;
          repeat
              read(c);
              if eof() then 
          begin
              writeln('input empty string or end of file');
              halt(1);
          end;
              k1 := k1 + 1;
              if (((c < '0')or(c > '9'))and(c <> ' ')and(c <> '.')and(c <> '-'))
              or(kt > 1)or(((predsymbol = ' ') or (predsymbol = '-')) and(c = '.'))
              or ((okch = true) and (c <> ' ')) then
              begin
                  error := true;
                  writeln('Error input,please, try input again,until true input:');
                  x := 0;
              end
              else
              begin
                  if(c = '-')or (otr = true) then otr := true
                  else
                  begin
                      if (predsymbol <> ' ') and (c = ' ') then okch := true;
                      if ((c >= '0') and (c <= '9')) or (c = '.') then
                      begin
                          if (c <> '.') and (tochka = false) then
                          begin
                              x := 10*x;
                              x := x + ord(c) - ord('0');
                          end;
                          if c = '.' then
                          begin
                              tochka := true;
                              kt := kt + 1;
                          end;
                          if (c <> '.') and (tochka = true) then
                          begin
                              kpt := kpt + 1;
                              x:= x + (ord(c) - ord('0'))/exp(ln(10)*kpt);
                          end;
                      end;
                  end;
              end;
              predsymbol := c;
          until (eoln) or (error = true);
          if (k1 = 1) and (c = ' ') then
          begin
              error := true;
              writeln('Error input,please, try input again,until true input:');
          end;
          if otr = true then
          begin
              error := true;
              writeln('Error input,please, try input again,until true input:')
          end;
          readln;
      until (error = false);
    epsilon := x;
    equalzero ();
    writeln('Input amount of sequence elements');

    {
    start control of input amount elements
    }
      repeat
          equalzero ();
          if eof() then 
          begin
              writeln('input empty string or end of file');
              halt(1);
          end;
          repeat
              read(c);
              if eof() then 
          begin
              writeln('input empty string or end of file');
              halt(1);
          end;
              k1 := k1 + 1;
              if (((c < '0')or(c > '9'))and(c <> ' '))
              or((okch = true)and (c <> ' '))then
              begin
                  error := true;
                  writeln('Error input,please,try input again,until true input:');
                  x := 0;
              end
              else
              begin
                  if (predsymbol <> ' ') and (c = ' ') then okch:=true;
                  if ((c >= '0') and (c <= '9'))then
                  begin
                      x1 := 10*x1;
                      x1 := x1+ord(c)-ord('0');
                  end;
              end;
              predsymbol := c;
          until (eoln)or (error = true);
          if (k1 = 1) and (c = ' ')or ((k1 = 1) and (c = '0')) then
          begin
              error := true;
              writeln('Error input,please, try input again,until true input:');
          end;
          readln;
      until (error = false);
    n := x1;
    setlength(mas,n);
    equalzero ();
        equalzero ();
        writeln('Input ' , n, ' elements of sequence');
        for i:=0 to n-1 do
        begin
            {
            start control of input element of sequence
            }
              repeat
              if eof() then 
              begin
                  writeln('input empty string or end of file');
                  halt(1);
              end;
                  equalzero ();
                  repeat
                      read(c);
                      k1 := k1 + 1;
                      if (((c < '0')or(c > '9'))and(c <> ' ')and(c <> '.')and(c <> '-'))
                      or((predsymbol >= '0')and(predsymbol <= '9')and(c = '-'))
                      or(kt > 1)or(((predsymbol = ' ')or (predsymbol = '-')) and (c = '.'))or ((okch=true)
                      and (c <> ' ')) then
                      begin
                          error := true;
                          writeln('Error input,please, try input again,until true input:');
                          x := 0;
                      end
                      else
                      begin
                          if((predsymbol = ' ') and (c = '-'))or ((predsymbol = '-')and (c = '-'))then
                          begin
                              km := km + 1;
                              if odd(km) then otr := true
                              else otr := false;
                          end
                          else
                          begin
                              if (predsymbol <> ' ') and (c = ' ') then okch:=true;
                              if ((c >= '0') and (c <= '9')) or (c = '.') then
                              begin
                                  if (c <> '.') and (tochka = false) then
                                  begin
                                      x := 10*x;
                                      x := x + ord(c) - ord('0');
                                  end;
                                  if c = '.' then
                                  begin
                                      tochka := true;
                                      kt := kt + 1;
                                  end;
                                  if (c <> '.') and (tochka = true) then
                                  begin
                                      kpt := kpt + 1;
                                      x := x + (ord(c) - ord('0'))/exp(ln(10)*kpt);
                                  end;
                              end;
                          end;
                      end;
                      predsymbol := c;
                  until (eoln) or (error = true);
                  if eof then
                  begin
                      error := true;
                      writeln('Error input,please, try input again,until true input:');
                  end;
                  if (k1 = 1) and ((c = ' ') or (c = '-')) then
                  begin
                      error := true;
                      writeln('Error input,please, try input again,until true input:');
                  end;
                  if otr = true then x := (-1)*x;
                  readln;
              until (error = false);
              mas[i] := x;
            end;
      {
      special for sequence, which amount equal 0
      }
      if n = 1 then
      begin
          arith := true;
          geom := true;
          grow := true;
          notfall := true;
          maxlengthp := 1;
          t := 0;
      end
      else
      begin
          d := mas[1] - mas[0];{calculate subtraction and divide}
          if mas[0] <> 0 then
          q := mas[1] / mas[0]
          else q := 0;
          k := 0;
          lengthp := 0;
          maxlengthp := 0;
          t := -1;
          j := 0;
          flag := true;
          arith := true;
          geom := true;
          if d > 0 then
          begin
              grow := true;
              notfall := true;
          end
          else if d = 0 then
          begin
              grow := false;
              notfall := true;
          end
          else if d < 0 then
          begin
              grow := false;
              notfall := false;
          end;
          for i := 1 to n-1 do
          begin
          {check arithmetic and geometry progression}
              if mas[i] <> (mas[i-1]+d) then arith := false;
              if mas[i] = 0 then
              if mas[i] <> mas[i-1] then geom := false;
              if (epsilon = 0) and (round(mas[i]/mas[i-1]) <> round(q)) then geom := false;
              if (epsilon > 0) and ((mas[i] > (mas[i-1]*q + epsilon))or (mas[i] < (mas[i-1]*q - epsilon))) then geom := false;
              {check up and notdown}
              if (notfall = true) then
              begin
                  if (grow = true) and (mas[i] <= mas[i-1]) then
                  grow := false;
                  if mas[i] < mas[i-1] then
                  notfall := false;
              end;
          end;
          k := 0;
  
          {
          check period
          }
          for i:=1 to n-1 do
          begin
              if (identity(mas[i], mas[k], epsilon)) and (k = 0) then
              begin
                  k := 1;
                  t := i;
              end
              else if (identity(mas[i], mas[k], epsilon)) and (k > 0) then k := k + 1
              else if (identity(mas[i], mas[k], epsilon) = false) and (k > 0) then
              begin
                  t := -1;
                  k := 0;
              end;
              if t = -1 then t := 0;
  
              {
              find max length of palindrom
              }
          end;
          lengthp := 0;
          maxlengthp := 0;
          for i := 1 to n-1 do
          begin
              for j := 0 to i - 1 do
              begin
                  if identity(mas[i], mas[j], epsilon) then
                  begin
                      lengthp := i - j + 1;
                      verh := i;
                      nizhn := j;
                      flag := true;
                      while (verh > nizhn) do
                      begin
                          if identity(mas[verh],mas[nizhn],epsilon) = false then flag := false;
                          verh := verh - 1;
                          nizhn := nizhn + 1;
                      end;
                      if (lengthp > maxlengthp) and (flag = true) then maxlengthp := lengthp;
                  end;
              end;
          end;
          if notfall = false then grow := false;
      end;
      
      {
      total result of analyse sequence
      }
      writeln ('vozrastanie - ',grow);
      writeln('neubivanie - ',notfall);
      if arith = true then 
          writeln('arithmetic progressin ',arith,', raznost progression = ',d,',')
      else 
          writeln('arithmetic progressin ',arith);
      if geom = true then 
          writeln('geometry progression ',geom,',divide progression =  ',q)
      else 
          writeln('geometry progression ',geom);
      writeln('period ',t);
      writeln('palindrom ',maxlengthp);
      readln;
end.