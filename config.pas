unit config;

interface

uses SysUtils;

type
    config_data = record
                      population_volume, preserved_low_positions, preserved_high_positions,
                                                     max_valueless_iters, 
                                                     max_iters, crossing_volume, pop_number_max: word;
                      enough_function_value, quality_eps: real;
                      mode: boolean;
                      selection_method, crossbreeding_method, mutation_method: integer;
                  end;
    
function get_data(filename: string): config_data;

implementation

function get_data(filename: string): config_data;
var
    a: config_data;
    conf: TextFile;
    inp_str, var_name, expected_value: string;
    eq_pos, err: integer;
begin
    assign(conf, filename);
    reset(conf);
    a.population_volume:= 30;
    a.pop_number_max:= 65535;
    a.preserved_high_positions := 5;
    a.preserved_low_positions := 5;
    a.crossing_volume := 25;
    a.max_valueless_iters := 15;
    a.max_iters := 20;
    a.enough_function_value := 4;
    a.mode := false;
    a.selection_method := 0;
    a.crossbreeding_method := 1;
    a.mutation_method := 3;
    a.quality_eps := 0.000001;;
    get_data := a;
    while not eof(conf) do
    begin
        readln(conf, inp_str);
        inp_str := trim(inp_str);
        if inp_str[1] = '#' then 
            continue;
        eq_pos := pos('=', inp_str);
        if eq_pos = 0 then
        begin
            writeln('no "=" symbol in line(', inp_str, ')');
            halt;
        end;
        var_name := trim(copy(inp_str, 0, eq_pos - 1));
        expected_value := trim(copy(inp_str, eq_pos + 1, length(inp_str)));
        case var_name of
            'population_volume':
            begin
                val(expected_value, a.population_volume, err);
                if err <> 0 then
                begin
                    writeln('ERROR converting ', expected_value, ' to int');
                    halt;
                end;
            end;
            'preserved_high_position':
            begin
                val(expected_value, a.preserved_high_positions, err);
                if err <> 0 then
                begin
                    writeln('ERROR converting ', expected_value, ' to int');
                    halt;
                end;
            end;
            'preserved_low_position':
            begin
                val(expected_value, a.preserved_low_positions, err);
                if err <> 0 then
                begin
                    writeln('ERROR converting ', expected_value, ' to int');
                    halt
                end;
            end;
            'valueless_iter':
            begin
                val(expected_value, a.max_valueless_iters, err);
                if err <> 0 then
                begin
                    writeln('ERROR converting ', expected_value, ' to int');
                    halt;
                end;
            end;
            'max_iters':
            begin
                val(expected_value, a.max_iters, err);
                if err <> 0 then
                begin
                    writeln('ERROR converting ', expected_value, ' to int');
                    halt;
                end;
            end;
            'enough_function_value':
            begin
                val(expected_value, a.enough_function_value, err);
                if err <> 0 then
                begin
                    writeln('ERROR converting ', expected_value, ' to real');
                    halt;
                end;
            end;
            'mode':
            begin
                if ((expected_value) = 'W') or ((expected_value) = 'WORK') then
                    a.mode := true
                else if ((expected_value) = 'D') or ((expected_value) = 'DEBUG') then
                    a.mode := false
                else
                begin
                    writeln('illegal value assigned to mode: ', expected_value);
                    halt;
                end;
            end;
            'selection_method':
            begin
                if ((expected_value) = 'TOURNAMENT') then
                    a.selection_method := 0
                else
                if ((expected_value) = 'RANDOM') then
                    a.selection_method := 1
                else
                begin
                    writeln('illegal value assigned to selection_method: ', expected_value);
                    halt;
                end;
            end;
            'crossbreeding_method':
            begin
                if ((expected_value) = 'SINGLE') then
                    a.crossbreeding_method := 1
                else 
                if ((expected_value) = 'DOUBLE') then
                    a.crossbreeding_method := 2
                else
                if ((expected_value) = 'UNIVERSAL') then
                    a.crossbreeding_method := 3
                else
                if ((expected_value) = 'CONTINIOUS') then
                    a.crossbreeding_method := 4
                else
                begin
                    writeln('illegal value assigned to crossbreeding_method: ', expected_value);
                    halt;
                end;
            end;
            'mutation_method':
             begin
                if ((expected_value) = 'SIMPLE') then
                    a.mutation_method := 1
                else
                if ((expected_value) = 'SWITCH') then
                    a.mutation_method := 2
                else
                if  ((expected_value) = 'REVERSE') then
                    a.mutation_method := 3
                else
                begin
                    writeln('illegal value assigned to mutation_method: ', expected_value);
                    halt;
                end;
            end;
            'quality_eps':
            begin
                val(expected_value, a.quality_eps, err);
                if err <> 0 then
                begin
                    writeln('ERROR converting ', expected_value, ' to real');
                    halt;
                end;
            end;
        end;
    end;
    get_data := a;
end;
end.
