program analiz_posledovatelnosti;

var
    eps, d, q, x: real;
    i, j, kt, kpt, n, x1, k1, t, lngp, maxlngp, verh, niz, g, km: integer;
    a, b, v, w, u, tchk, otr, okch, err, glaf, result: boolean;
    mas: array of real;
    pred, c: char;

Function equal(x, y, epsilon:real):boolean;
begin
    if abs(x-y) <= epsilon then
        result := true
    else
        result := false;
end;

Function identity(a,b,epsilon:real):boolean;
begin
    if abs(a - b) < epsilon then
        result := true
    else
        result := false;
end;

begin
    repeat
    tchk := false; kpt := 0; err := false; otr := false;
    okch := false; pred := ' '; x := 0; kt := 0; k1 := 0;
    Writeln('Enter a real nonnegative number:');
        repeat
            Read(c);
            k1 := k1 + 1;
            if (((c < '0') or (c > '9')) and (c <> ' ') and (c <> '.') and (c <> '-'))
            or (kt > 1) or (((pred = ' ')
            or (pred = '-')) and (c = '.')) or ((okch = true)
            and (c <> ' ')) then
            begin
                err := true;
                Writeln('Error input,please, re-enter:');
                x := 0;
            end
            else
            begin
                if(c = '-')or (otr = true) then otr := true
                else
                begin
                    if (pred <> ' ') and (c = ' ') then okch := true;
                    if ((c >= '0') and (c <= '9')) or (c = '.') then
                    begin
                        if (c <> '.') and (tchk = false) then
                        begin
                            x := 10*x;
                            x := x + ord(c) - ord('0');
                        end;
                        if c = '.' then
                        begin
                            tchk := true;
                            kt := kt + 1;
                        end;
                        if (c <> '.') and (tchk = true) then
                        begin
                            kpt := kpt + 1;
                            x:= x + (ord(c) - ord('0'))/exp(ln(10)*kpt);
                        end;
                    end;
                end;
            end;
            pred := c;
        until (eoln) or (err = true) or (eof);
        if eof then
        begin
            err := true;
            Writeln('Error input,please,re-enter:');
        end;
        if (k1 = 1) and (c = ' ') then
        begin
            err := true;
            Writeln('Error input,please,re-enter:');
        end;
        if otr = true then
        begin
            err := true;
            Writeln('Error input,please, re-enter:');
        end;
        Readln;
    until (err = false);
    eps := x;
    tchk := false; kpt := 0; err := false; otr := false;
    okch := false; pred := ' '; x := 0; kt := 0; k1 := 0;
    Writeln('Enter amount of sequence elements');
    
    if not eof then
    begin
        tchk := false; kpt := 0; err := false; otr := false;
        okch := false; pred := ' '; x := 0; kt := 0; k1 := 0;
        repeat
            Read(c);
            k1 := k1 + 1;
            if (((c < '0') or (c > '9')) and (c <> ' ')) or
            ((okch = true) and (c <> ' ')) then
            begin
                err := true;
                Writeln('Error input,please,re-enter:');
                x := 0;
            end
            else
            begin
                if (pred <> ' ') and (c = ' ') then okch:=true;
                if ((c >= '0') and (c <= '9'))then
                begin
                    x1 := 10*x1;
                    x1 := x1+ord(c)-ord('0');
                end;
            end;
            pred := c;
        until (eoln) or (err = true) or (eof);
        if eof then
        begin
            err := true;
            Writeln('Error input,please, re-enter:');
        end;
        if (k1 = 1) and (c = ' ') then
        begin
            err := true;
            Writeln('Error input,please, re-enter:');
        end;
        readln;
    end;
    n := x1;
    setlength(mas,n);
    tchk := false; kpt := 0; err := false; otr := false;
    okch := false; pred := ' '; x := 0; kt := 0; k1 := 0; km := 0;
    for i:=0 to n-1 do
    begin
        Writeln('Enter value of the sequence element:');
        if not eof then
        begin
            tchk := false; kpt := 0; err := false; otr := false;
            okch := false; pred := ' '; x := 0; kt := 0; k1 := 0; km := 0;
            repeat
                Read(c);
                k1 := k1 + 1;
                if (((c < '0') or (c > '9')) and (c <> ' ') and (c <> '.') and (c <> '-'))
                or ((pred >= '0') and (pred <= '9') and (c = '-'))
                or (kt > 1) or (((pred = ' ')
                or (pred = '-')) and (c = '.')) or ((okch = true)
                and (c <> ' ')) then
                begin
                    err := true;
                    Writeln('Error input,please, re-enter:');
                    x := 0;
                end
                else
                begin
                    if((pred = ' ') and (c = '-'))or ((pred = '-') and (c = '-'))then
                    begin
                        km := km + 1;
                        if odd(km) then 
                            otr := true
                        else 
                            otr := false;
                    end
                    else
                    begin
                        if (pred <> ' ') and (c = ' ') then okch:=true;
                        if ((c >= '0') and (c <= '9')) or (c = '.') then
                        begin
                            if (c <> '.') and (tchk = false) then
                            begin
                                x := 10*x;
                                x := x + ord(c) - ord('0');
                            end;
                            if c = '.' then
                            begin
                                tchk := true;
                                kt := kt + 1;
                            end;
                            if (c <> '.') and (tchk = true) then
                            begin
                                kpt := kpt + 1;
                                x := x + (ord(c) - ord('0'))/exp(ln(10)*kpt);
                            end;
                        end;
                    end;
                end;
                pred := c;
            until (eoln) or (err = true)or (eof);
            if eof then
            begin
                err := true;
                Writeln('Error input,please, re-enter:');
            end;
            if (k1 = 1) and ((c = ' ') or (c = '-')) then
            begin
                err := true;
                Writeln('Error input,please, re-enter:');
            end;
            if otr = true then 
                x := (-1)*x;
            Readln;
        end;
        mas[i] := x;
    end;

    setlength(mas,n);
    if n = 1 then
    begin
        d:=0;
        q:=0;
        a:= true;
        b:= true;
        maxlngp := 1;
        t:=1;
    end
    else
    begin
    a := true; b := true; v := true; w := true; t := 0; u := true;
    d := mas[1] - mas[0];
    q := mas[1] / mas[0];
    i := 0;
    repeat
    begin
        a := (mas[i] < mas[i + 1]);
        i := i + 1;
    end;
    until (a = false) or (i >= (n - 1));
    i := 0;
    repeat
    begin
        b := (mas[i] <= mas[i + 1]);
        i := i + 1;
    end;
    until (b = false) or (i >= (n - 1));
    if n > 2 then
    begin
        for i := 1 to n - 2 do
            if (mas[i] < (mas[i-1]+d)-eps) or (mas[i] > (mas[i-1]+d)+eps) then
                v := false;
            if v = false then
            begin
                  for i := 1 to n - 2 do
                    if (mas[i] < (mas[i-1]*q) - eps) or ( mas[i] > (mas[i-1]*q)+eps) then
                        w := false;
            end
    end
    else
        if n = 2 then
             q:= mas[1]/mas[0];
    g:=0;
    if n >= 2 then
    begin
        for i := 1 to n - 1 do
            if (equal(mas[i], mas[g], eps)) and (g = 0) then
            begin
                g := 1;
                t := i;
            end
            else
                if (equal(mas[i], mas[g], eps)) and (g > 0) then
                    g := g+1
            else
                if (equal(mas[i], mas[g], eps) = false) and (g > 0) then
                begin
                    if equal(mas[i], mas[0], eps) then
                    begin
                        t := i;
                        g := 1;
                    end
                    else
                    begin
                        t := -1;
                        g := 0;
                    end;
                end;
    end
    else
        if (n = 2) and (abs(mas[0] - mas[1]) <= eps) or (abs(mas[1] - mas[1]) <= eps) then
            t := 1
        else
            t:=1;

    lngp := 0;
    maxlngp := 0;
    for i := 1 to n-1 do
    begin
        for j := 0 to i - 1 do
        begin
            if identity(mas[i],mas[j],eps) then
            begin
                lngp := i - j + 1;
                verh := i;
                niz :=j;
                glaf := true;
                while (verh > niz) do
                begin
                    if identity(mas[verh],mas[niz],eps) = false then
                        glaf := false;
                    verh := verh - 1;
                    niz := niz + 1;
                end;
                if (lngp > maxlngp) and (glaf = true) then
                    maxlngp := lngp;
            end;
        end;
    end;
    end;
    Writeln('The sequence increases: ',a);
    Writeln('The sequence does not decrease: ',b);
    if (v = true) or (n = 1) then
        Writeln('Difference of arithmetic progression: ',d)
    else
        Writeln('Arithmetic progression: ',v);
    if (w = true) or (n = 1) then
        Writeln('The denominator of a geometric progression: ',q)
    else
        Writeln('Geometric progression: ',w);
    if t = -1 then
        Writeln('Period: ',0)
    else
        Writeln('Period: ',t);
    Writeln('Length of palindrome: ',maxlngp);
end.
