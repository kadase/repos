unit types;

interface
uses config;
var val: array of real;
    my: config_data;
    file_name: string;
    die, iters,mom, papa, valueless_iters, child_cur, child: word;
    f_max, f_max_pred, val_max: real;
    ent: array of word;
    f_x: array of real;
    
procedure create_pop;   
procedure find_f_max;
function fun_x(x: word): real; 
procedure f_population;
function checking_stop:boolean;
procedure choose_parents;
procedure print_population;

implementation

procedure create_pop;
var i: word;
begin
  for i:=0 to my.population_volume - 1 do
  begin
    ent[i]:=random(65535);
    val[i]:=ent[i]*4/65535;
  end;
end;

procedure find_f_max;
var i: byte;
begin
  f_max_pred:= f_max;
  f_max:=f_x[0];
  for i:=0 to my.population_volume - 1 do
  if f_x[i] > f_max then begin
     f_max:= f_x[i];
     val_max:= val[i];
  end;
end;

function fun_x(x: word): real; 
begin
	fun_x := val[x]*(val[x] - 2)*(val[x]-2.75)*cos(val[x]/10)*
    (2-exp((val[x]-2)*ln(3)))*exp(val[x]/10);
end;

procedure f_population;
var i: word;
begin
  f_x[0]:= fun_x(0);
  for i:=1 to my.population_volume - 1 do
  begin
    f_x[i]:= fun_x(i);
    if f_x[i] > f_max then begin
      f_max_pred:=f_max;
      f_max:=f_x[i];
      val_max:=i;
    end;
  end;
end;

function checking_stop:boolean;
begin
  checking_stop:= false;
  if abs (f_max - f_max_pred) < my.quality_eps then
    valueless_iters := valueless_iters+1
  else
    valueless_iters := 0;               
  if valueless_iters = my.max_valueless_iters then 
  begin
    checking_stop := true;
    writeln('STOP');
    writeln(valueless_iters,' iterations without change in F_max');
  end;
  if iters = my.max_iters then
    checking_stop := true ; 
  if f_max > my.enough_function_value then
  begin
    checking_stop := true;
    writeln('STOP');
    writeln(my.enough_function_value,' value has been reached');
  end;
end;

procedure choose_parents;
var p_mom, p_papa: word;
begin
  repeat
    p_mom:= random (my.crossing_volume) + my.population_volume - my.crossing_volume;
  until ent[p_mom]<>-1;
  repeat
    p_papa:= random (my.crossing_volume) + my.population_volume - my.crossing_volume;
  until ent[p_papa]<>-1;
  mom:= ent[p_mom];
  papa:= ent[p_papa];
end;

procedure print_population;
var i: byte;
begin
  writeln('Current itteration: ',iters);
  writeln('   # :entity :  value   :  f(x)   ');
  for i:=0 to my.population_volume-1 do
  begin
    write(i:4,' : ',ent[i]:5,' : ',val[i]:3:6,' : ',f_x[i]:3:6);
    writeln();
  end;
end;
end.
