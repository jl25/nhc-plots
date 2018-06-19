function [cell_str] = arr_to_cell_str(x)
    cell_str = num2cell(x);
    for i = 1:size(cell_str, 2)
        cell_str{i} = num2str(cell_str{i});
    end
end