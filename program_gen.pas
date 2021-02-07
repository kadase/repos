uses config, bit_functions, types, gen_operations, SysUtils;
var 
Duration: Cardinal;

begin
  iters:= 0;
  file_name:= 'gen.config';
  my:=get_data(file_name);
  Duration:= GetTickCount64();
  setlength(val, my.population_volume);
  setlength(ent, my.population_volume);
  setlength(f_x, my.population_volume);
  create_pop;
  f_population;
  sort_pop(val, my.population_volume);
  if not(my.mode) then
  begin
     writeln('DEBUG MODE');
     writeln;
     print_population;
     while true do
     begin
         f_max_pred:= f_max;  
         f_max:= f_x[0];     
         val_max:= val[0];   
        if checking_stop then
        begin
         writeln('F_max = ',f_max);
         writeln('val_max = ',val_max);
         writeln('iters = ',iters);
         writeln('valueless_iters = ',my.max_valueless_iters);
         Duration:= GetTickCount64() - Duration;
         writeln('Time = ', Duration);
          exit;
        end;
        selection(my.selection_method);
        crossing(my.crossbreeding_method, my.mutation_method);
        sort_pop(val, my.population_volume);
        iters:= iters +1;
        print_population;
        writeln;
     end;
  end
  else
  begin
    writeln('WORKING MODE');
    writeln;
    while true do
    begin
      f_max_pred:= f_max;  
      f_max:= f_x[0];     
      val_max:= val[0];   
      writeln(f_max,' ', val_max,' ', iters); 
      if checking_stop then
      begin
         writeln('F_max = ',f_max);
         writeln('val_max = ',val_max);
         writeln('iters = ',iters);
         writeln('valueless_iters = ',my.max_valueless_iters);
         Duration:= GetTickCount64() - Duration; 
         writeln('Time = ', Duration);
         exit;
      end;
      selection(my.selection_method);
      crossing(my.crossbreeding_method, my.mutation_method);
      sort_pop(val, my.population_volume);
      iters:= iters +1;
      writeln;
    end;
  end;
end.
