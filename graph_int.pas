unit graph_int;

interface 

uses ptcgraph;

type 
	func_real_t = function(x: real): real;

function F_test_1(x: real): real;
function F_test_2(x: real): real;
function F_test_3(x: real): real;
function F_1(x: real): real;
function F_2(x: real): real;
function F_3(x: real): real;
function F_test_12(x: real): real;
function F_test_13(x: real): real;
function F_test_23(x: real): real;
function F_12(x: real): real;
function F_13(x: real): real;
function F_23(x: real): real;
procedure axes(x0, y0: integer; mx, my: real);
procedure function_graph(F: func_real_t; mx, my: real; x0, y0: integer; 
                         color: longint);
procedure write_root(F: func_real_t; x, mx, my: real; x0, y0: integer);
procedure painting (x1, x2: real; x0, y0: integer; mx, my: real);
procedure graph (x1, x2, x3, s: real);
procedure paintingtest (x1, x2: real; x0, y0: integer; mx, my: real);
procedure graphtest (x1, x2, x3, s: real);

implementation

const blue = $0010;
const white = $FFFF;
const blue_1 = $000009;
const lilac = $2E8BFF;
const purple = $FF69B4;
const turquoise = $AFFF;
{----------------------------------------------------------------------}

function F_test_1(x: real): real;
begin
    F_test_1 := 4 - x;
end;
function F_test_3(x: real): real;
begin
    F_test_3 := x + 3;
end;
function F_test_2(x: real): real;
begin
    F_test_2 := sqrt(x+4);
end;


function F_test_12(x: real): real;
begin
    F_test_12 := 4 - x - sqrt(x+4);
end;

function F_test_13(x: real): real;
begin
    F_test_13 := 4 - x - x - 3;
end;
function F_test_23(x: real): real;
begin
    F_test_23 := x + 3 - sqrt(x+4);
end;



function F_1(x: real): real;
begin
    F_1 := 1 + 4/(sqr(x) + 1);
end;
function F_2(x: real): real;
begin
	if (x < 0) then
		F_2 := 0
	else
		F_2 := exp(ln(x) * 3);
end;
function F_3(x: real): real;
begin
        F_3 := exp(ln(2) * (-x));
end;

function F_12(x: real): real;
begin
    F_12 := 1 + 4/(sqr(x) + 1)-exp(ln(x) * 3);
end;
function F_13(x: real): real;
begin
    F_13 := 1 + 4/(sqr(x) + 1)-exp(ln(2) * (-x));
end;
function F_23(x: real): real;
begin
    F_23 := exp(ln(x) * 3)-exp(ln(2) * (-x));
end;



procedure axes(x0, y0: integer; mx, my: real);
var
    i: integer;
    s: string;
    dx, dy: real;
begin
    dx := 0.5;
    dy := 0.5;
    Setcolor(white);
    line(0, y0, getmaxX, y0);
    line(x0, 0, x0, getmaxY);
    Settextstyle(2, 0, 2);
    outtextXY(x0 + Textwidth('0'), y0 + Textwidth('0'), '0');
    outtextXY(getmaxX - Textwidth('X'), y0 - Textwidth('X'), 'X');
    outtextXY(x0 + Textwidth('Y'), Textwidth('Y'), 'Y');
    for i := 1 to 5 do
    begin
        line(x0 + round(i*mx), y0 - 2, x0 + round(i*mx), y0 + 2);
        line(x0 - round(i*mx), y0 - 2, x0 - round(i*mx), y0 + 2);
        str(i*dx : 0 : 1, s);
        outtextXY(x0 + round(i*mx) - Textwidth(s) div 2, 
        y0 + Textwidth(s) div 3, s);
        outtextXY(x0 - round(i*mx) - Textwidth(s) div 2, 
        y0 + Textwidth(s) div 3, '-'+s);
    end;
    for i := 1 to 10 do
    begin
        line(x0 - 2, y0 - round(i*my), x0 + 2, y0 - round(i*my));
        line(x0 - 2, y0 + round(i*my), x0 + 2, y0 + round(i*my));
        str(i*dy : 0 : 1, s);
        outtextXY(x0 + Textwidth(s) div 3, y0 - round(i*my), s);
        outtextXY(x0 + Textwidth(s) div 3, y0 + round(i*my), '-'+s);
    end;
end;




procedure function_graph(F: func_real_t; mx, my: real; x0, y0: integer; 
                         color: longint);
var
    x, y: real;
begin
    x := -2;
    while (x < 2.5) do
    begin
        y := F(x);
        if (y0 - round(y*my) > 0) and (y0 - round(y*my) < getmaxY) then
            putpixel(x0 + round(x*mx), y0 - round(y*my), color);
        x := x + 0.00001;
    end;
end;


procedure write_root(F: func_real_t; x, mx, my: real; x0, y0: integer);
var
    s : string;
begin
    str(x : 2 : 3, s);
    Setcolor(white);
    Line(x0 + round(x*mx), y0 - round(F(x)*my), x0 + round(x*mx), y0);
    Outtextxy(x0 + round(x*mx) - Textwidth(s) div 2, 
    y0 - Textwidth(s) div 3, s);
end;


procedure painting (x1, x2: real; x0, y0: integer; mx, my: real);
var
    y1: real;
    y, x: integer;
begin
    while (x1 < x2) do
	begin
		y1 := F_1(x1);
		x := x0 + round (x1*mx);
		while (y1 > F_2(x1)) and (y1 > F_3(x1)) do
		begin
			y := y0 - round(y1*my);
			putpixel(x, y, blue_1);
			y1 := y1 - 0.001;
		end;
		x1 := x1 + 0.001;
	end;
end;



procedure graph (x1, x2, x3, s: real);
var mx, my: real;
    x0, y0: integer;
    gd, gm: smallint;
	y_1, y_2, y_3, x_1, x_2, x_3: integer;
	st: string;
begin
    gd := D16bit;
    gm := detectmode;
    Initgraph(gd, gm, '');
    mx:=getmaxX/9;
    my:=getmaxY/16;
    x0:=round(mx*4);
    y0:=round(my*12);
    mx := mx*2;
    my := my*2;
    painting (x2, x1, x0, y0, mx, my);
    Axes(x0, y0, mx, my);
    Function_graph(@F_1, mx, my, x0, y0, lilac);
    Function_graph(@F_2, mx, my, x0, y0, purple);
    Function_graph(@F_3, mx, my, x0, y0, turquoise);
    Write_root(@F_1, x1, mx, my, x0, y0);
    Write_root(@F_2, x3, mx, my, x0, y0);
    Write_root(@F_3, x2, mx, my, x0, y0);
    x_1 := x0 + round(x1 * mx);
	x_2 := x0 + round(x2 * mx);
	x_3 := x0 + round(x3 * mx);
	y_1 := y0 - round(f_1(x1) * my);
	y_2 := y0 - round(f_2(x2) * my);
	y_3 := y0 - round(f_3(x3) * my);
	str(s:0:5, st);
	Settextstyle(2, 0, 2);
	OutTextXY((abs(x_1) + abs(x_2) + abs(x_3)) div 3 - textwidth(st) shr 1, (y_1 + y_2 + y_3) div 3 - 20,'area = ' + st);
	readln;
end;

procedure paintingtest (x1, x2: real; x0, y0: integer; mx, my: real);
var
    y1: real;
    y, x: integer;
begin
    while (x1 < x2) do
	begin
		y1 := F_test_2(x1);
		x := x0 + round (x1*mx);
		while (y1 < F_test_1(x1)) and (y1 < F_test_3(x1)) do
		begin
			y := y0 - round(y1*my);
			putpixel(x, y, blue);
			y1 := y1 + 0.001;
		end;
		x1 := x1 + 0.001;
	end;
end;



procedure graphtest (x1, x2, x3, s: real);
var mx, my: real;
    x0, y0: integer;
    gd, gm: smallint;
	y_1, y_2, y_3, x_1, x_2, x_3: integer;
	st: string;
begin
    gd := D16bit;
    gm := detectmode;
    Initgraph(gd, gm, '');
    mx:=getmaxX/9;
    my:=getmaxY/16;
    x0:=round(mx*4);
    y0:=round(my*12);
    Axes(x0, y0, mx, my);
    mx := mx*2;
    my := my*2;
    paintingtest(x3, x1, x0, y0, mx, my);
    Function_graph(@F_test_1, mx, my, x0, y0, lilac);
    Function_graph(@F_test_2, mx, my, x0, y0, purple);
    Function_graph(@F_test_3, mx, my, x0, y0, turquoise);
    Write_root(@F_test_1, x1, mx, my, x0, y0);
    Write_root(@F_test_2, x3, mx, my, x0, y0);
    Write_root(@F_test_3, x2, mx, my, x0, y0);
    x_1 := x0 + round(x1 * mx);
	x_2 := x0 + round(x2 * mx);
	x_3 := x0 + round(x3 * mx);
	y_1 := y0 - round(f_1(x1) * my);
	y_2 := y0 - round(f_2(x2) * my);
	y_3 := y0 - round(f_3(x3) * my);
	str(s:0:5, st);
	Settextstyle(2, 0, 2);
	OutTextXY((abs(x_1) + abs(x_2) + abs(x_3)) div 3 - textwidth(st) shr 1, (y_1 + y_2 + y_3) div 3 - 20,'area = ' + st);
    readln;
end;
end.























































