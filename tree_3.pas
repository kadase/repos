program trees_3;


type
    tree_node_link = ^tree_node;
    tree = record
        root: tree_node_link;
        end;

    tree_node = record
        data: integer;
        left: tree_node_link;
        right: tree_node_link;
        parent: tree_node_link;
        end;

var
    tree_input: tree;
    mode, i: integer;

{help us creating the tree}
procedure create_tree (var input_tree: tree; n: integer);
var
    temp, treenode, parent: tree_node_link;
    temp_addr: ^tree_node_link;
begin
    temp:= input_tree.root;
    temp_addr:= @(input_tree.root);
    New (treenode);
    treenode^.left:= nil;
    treenode^.right:= nil;
    treenode^.data:= n;
    while temp <> nil do
    begin
        parent:= temp;
        if temp^.data <= n then
        begin
            temp_addr:= @(temp^.right);
            temp:= temp^.right;
        end
        else
        begin
            temp_addr:= @(temp^.left);
            temp:= temp^.left;
        end;
    end;
    treenode^.parent:= parent;
    temp_addr^:= treenode;
    input_tree.root^.parent:= nil;
end;

{creating the tree}
procedure tree_creating (var input_tree: tree);
var
    n: integer;
begin
    input_tree.root:= nil;
    repeat
        Readln(n);
        create_tree (input_tree, n);
    until (eof);
end;

{help to print tree}
procedure tree_print_node (temp: tree_node_link);
begin
    if temp = nil then 
        exit;
    tree_print_node (temp^.right);
    Writeln (temp^.data);
    tree_print_node (temp^.left);
end;

{print tree}
procedure tree_print (input_tree: tree);
begin
    tree_print_node (input_tree.root);
end;

{help to print tree's levels}
procedure level_printing_node (temp: tree_node_link; 
          level_of_tree: integer; target: integer);
begin
    if temp = nil then 
        exit;
    if level_of_tree = target then 
        Write (temp^.data, ' ');
    level_of_tree:= level_of_tree + 1;
    level_printing_node (temp^.left, level_of_tree, target);
    level_printing_node (temp^.right, level_of_tree, target);
end;

{print tree's level}
procedure level_printing (input_tree: tree; target : integer);
begin
    level_printing_node (input_tree.root, 0, target);
end;

{function, which helps us to define the depth of the tree}
function tree_depth_node (temp: tree_node_link; 
                          level_of_tree: integer): integer;
var
    temp_1, temp_2: integer;
begin
    if (temp^.right = nil) and (temp^.left = nil) then
    begin
        tree_depth_node:= level_of_tree;
        exit;
    end;
    level_of_tree:= level_of_tree + 1;
    if temp^.right = nil then
    begin
        tree_depth_node := tree_depth_node (temp^.left, level_of_tree);
        exit;
    end
    else 
        if temp^.left = nil then
    begin
        tree_depth_node:= tree_depth_node (temp^.right, level_of_tree);
        exit;
    end
    else
    begin
        temp_1:= tree_depth_node (temp^.right, level_of_tree);
        temp_2:= tree_depth_node (temp^.left, level_of_tree);
        if temp_1 >= temp_2 then 
            tree_depth_node:= temp_1
        else 
            tree_depth_node:= temp_2;
    end;
end;

{function, which defines the depth of the tree}
function tree_depth(input_tree: tree): integer;
begin
    tree_depth:= tree_depth_node (input_tree.root, 0);
end;


procedure nodes_matching (temp: tree_node_link; var labels: 
                          array of tree_node_link; var number: integer);
begin
    if temp = nil then 
        exit;
    nodes_matching (temp^.left, labels, number);
    labels [number] := temp;
    number:= number + 1;
    nodes_matching (temp^.right, labels, number);
end;

{counting tree's nodes}
function count_nodes_in_our_tree (temp: tree_node_link): integer;
begin
    if temp = nil then
    begin
        count_nodes_in_our_tree:= 0;
        exit;
    end;
    count_nodes_in_our_tree:= count_nodes_in_our_tree (temp^.left) + 
    count_nodes_in_our_tree (temp^.right) + 1;
end;

{wrting labels of our tree}
function find_by_label (find: tree_node_link; labels: array of tree_node_link; 
                        size: integer): integer;
var
    i: integer;
begin
    for i := 0 to size-1 do
        if labels[i] = find then
            find_by_label := i;
end;

{help us to make the special kind of the response output}
procedure graphviz_output_node (var output: text; temp: tree_node_link; 
                               labels: array of tree_node_link; size, 
                               direction: integer);
begin
    if temp = nil then exit;
    if direction = 1 then
        Writeln (output, '    ', find_by_label (temp^.parent, labels, size), 
                 ' -> ', find_by_label (temp, labels, size), ' [label = "R"]');
    if direction = -1 then
        Writeln (output, '    ', find_by_label (temp^.parent, labels, size), 
                 ' -> ', find_by_label (temp, labels, size), ' [label = "L"]');
    graphviz_output_node (output, temp^.left, labels, size, -1);
    graphviz_output_node (output, temp^.right, labels, size, 1);
end;

{special kind of the response output}
procedure graphviz_output (input_tree: tree);
var
    nodes, number, i: integer;
    labels: array of tree_node_link;
    output: text;
begin
    assign (output, './result.dot');
    rewrite (output);
    nodes:= count_nodes_in_our_tree (input_tree.root);
    setlength (labels, nodes);
    number:= 0;
    nodes_matching (input_tree.root, labels, number);
    writeln (output, 'digraph');
    writeln (output, '{');
    for i := 0 to nodes - 1 do 
        writeln(output, '    ', i, ' [label = "', labels[i]^.data, '"]');
    graphviz_output_node (output, input_tree.root^.left, labels, nodes, -1);
    graphviz_output_node (output, input_tree.root^.right, labels, nodes, 1);
    writeln (output, '}');
    setlength (labels, 0);
    close (output);
end;
{help us to clean our tree}
procedure clear_tree_node (input: tree_node_link);
begin
    if input = nil then
        exit;
    clear_tree_node(input^.left);
    clear_tree_node(input^.right);
    dispose (input);
end;

{this function clears our tree}
procedure clear_tree (var input_tree: tree);
begin
    clear_tree_node (input_tree.root);
end;

{min depth of our tree ( this function can find it )}
function tree_depth_min_node (temp: tree_node_link; 
                              level_of_our_tree: integer): integer;
var
    temp_1, temp_2: integer;
begin
    if (temp^.right = nil) and (temp^.left = nil) then
    begin
        tree_depth_min_node:= level_of_our_tree;
        exit;
    end;
    level_of_our_tree:= level_of_our_tree + 1 ;
    if temp^.right = nil then
    begin
        tree_depth_min_node:= tree_depth_min_node(temp^.left,level_of_our_tree);
        exit;
    end
    else if temp^.left = nil then
    begin
        tree_depth_min_node:=tree_depth_min_node(temp^.right,level_of_our_tree);
        exit;
    end
    else
    begin
        temp_1:= tree_depth_min_node (temp^.right, level_of_our_tree);
        temp_2:= tree_depth_min_node (temp^.left, level_of_our_tree);
        if temp_1 <= temp_2 then 
            tree_depth_min_node:= temp_1
        else 
            tree_depth_min_node:= temp_2;
    end;
end;

{min depth of our tree ( this function can find it )}
function tree_depth_min (input_tree: tree): integer;
begin
    tree_depth_min:= tree_depth_min_node (input_tree.root, 0);
end;

{print depth of our tree}
procedure tree_depth_print (input_tree: tree);
begin
    Writeln (tree_depth_min (input_tree) + 1, ' ', tree_depth (input_tree) + 1);
end;

begin
    Writeln ('Enter mode: ');
    Readln (mode);
    Writeln ('Enter a sequence of elements: ');
    tree_creating (tree_input);
    if mode = 1 then
    begin
        Writeln;
        tree_print (tree_input);
        Writeln;
    end
    else 
        if mode = 2 then
    begin
        Writeln;
        for i := tree_depth (tree_input) downto 0 do
        begin
            level_printing (tree_input, i);
            Writeln;
        end;
        Writeln;
    end
    else if mode = 3 then
    begin
        Writeln;
        tree_depth_print (tree_input);
        Writeln;
    end
    else 
        if mode = 4 then 
            graphviz_output (tree_input);
    clear_tree (tree_input);
end.
