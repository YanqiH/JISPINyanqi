function [Outl1, Outl2, Outl3, label_x, label_y] = prepareLevel(Rx, Inl1, Inl2, Inl3)
%prepare m, G or Pr for each LED

N = 2601;
k = 0;
coord_x = 1;
coord_y = 0;
ref_x = Rx(:, 1);
ref_y = Rx(:, 2);
for i = 1 : length(ref_x)
    
    coord_y = coord_y + 1;
    
    k = k + 1;
    Outl1(coord_x, coord_y) = Inl1(k);
    Outl2(coord_x, coord_y) = Inl2(k);
    Outl3(coord_x, coord_y) = Inl3(k);
    
    label_x(coord_x, coord_y) = ref_x(k);
    label_y(coord_x, coord_y) = ref_y(k);
    if (i == N)
        break
    elseif ref_x(i+1) ~= ref_x(i)
        coord_x = coord_x + 1;
        coord_y = 0;
    end
end