function [preparerandomh] = step1(sureh, N, Pr0, Pr4, Pr8, Pr12, Pr16, Pr200)

% randomly get N heights
for i = 1 : N
    
    % ====确定h for Rx 固定h
    %     sureh = 1;
    random_h = sureh;
    
    % ======random a h for Rx:随机h
%         random_h = randi(6);
    
    % (x, y, h) and Prs of Rx
    preparerandomh(i, 1) = Pr0(i, 1);
    preparerandomh(i, 2) = Pr0(i, 2);
    if random_h == 1
        preparerandomh(i, 3) = 0;
        % Pr for 4 LEDs
        preparerandomh(i, 4) = Pr0(i, 3);
        preparerandomh(i, 5) = Pr0(i, 4);
        preparerandomh(i, 6) = Pr0(i, 5);
        preparerandomh(i, 7) = Pr0(i, 6);
    elseif random_h == 2
        preparerandomh(i, 3) = 0.4;
        preparerandomh(i, 4) = Pr4(i, 3);
        preparerandomh(i, 5) = Pr4(i, 4);
        preparerandomh(i, 6) = Pr4(i, 5);
        preparerandomh(i, 7) = Pr4(i, 6);
    elseif random_h == 3
        preparerandomh(i, 3) = 0.8;
        preparerandomh(i, 4) = Pr8(i, 3);
        preparerandomh(i, 5) = Pr8(i, 4);
        preparerandomh(i, 6) = Pr8(i, 5);
        preparerandomh(i, 7) = Pr8(i, 6);
    elseif random_h == 4
        preparerandomh(i, 3) = 1.2;
        preparerandomh(i, 4) = Pr12(i, 3);
        preparerandomh(i, 5) = Pr12(i, 4);
        preparerandomh(i, 6) = Pr12(i, 5);
        preparerandomh(i, 7) = Pr12(i, 6);
    elseif random_h == 5
        preparerandomh(i, 3) = 1.6;
        preparerandomh(i, 4) = Pr16(i, 3);
        preparerandomh(i, 5) = Pr16(i, 4);
        preparerandomh(i, 6) = Pr16(i, 5);
        preparerandomh(i, 7) = Pr16(i, 6);
    elseif random_h == 6
        preparerandomh(i, 3) = 2;
        preparerandomh(i, 4) = Pr200(i, 3);
        preparerandomh(i, 5) = Pr200(i, 4);
        preparerandomh(i, 6) = Pr200(i, 5);
        preparerandomh(i, 7) = Pr200(i, 6);
    end
    
    
end


