tic
clear
% N = 2601;

NumLevel = 3;
pt = 25;

A = [1.25, 1.25];
B = [1.25, 3.75];
C = [3.75, 1.25];
D = [3.75, 3.75];

% sureh = 1-6: 0, 0.4, 0.8, 1.2, 1.6, 2 m
N = 121;
sureh = 3;
n = N;

% use route
% n = 38;
% routerefxyz = csvread('routerefxyz.csv',0,0,[0, 0, n-1, 2]);

% m0 = csvread('m_all_0.csv',0,0,[0, 0, N-1, 3]);
m0 = csvread('v4_3_m_all_0.csv',0,0,[0, 0, N-1, 3]);
m4 = csvread('v4_3_m_all_4.csv',0,0,[0, 0, N-1, 3]);
m8 = csvread('v4_3_m_all_8.csv',0,0,[0, 0, N-1, 3]);
m12 = csvread('v4_3_m_all_12.csv',0,0,[0, 0, N-1, 3]);
m16 = csvread('v4_3_m_all_16.csv',0,0,[0, 0, N-1, 3]);
m200 = csvread('v4_3_m_all_2.csv',0,0,[0, 0, N-1, 3]);


% G0 = csvread('G_all_0.csv',0,0,[0, 0, N-1, 3]);
G0 = csvread('v4_3_G_all_0.csv',0,0,[0, 0, N-1, 3]);
G4 = csvread('v4_3_G_all_4.csv',0,0,[0, 0, N-1, 3]);
G8 = csvread('v4_3_G_all_8.csv',0,0,[0, 0, N-1, 3]);
G12 = csvread('v4_3_G_all_12.csv',0,0,[0, 0, N-1, 3]);
G16 = csvread('v4_3_G_all_16.csv',0,0,[0, 0, N-1, 3]);
G200 = csvread('v4_3_G_all_2.csv',0,0,[0, 0, N-1, 3]);

Pr0 = csvread('v4_3_simulationPr_0.csv',0,0,[0, 0, N-1, 5]);
Pr4 = csvread('v4_3_simulationPr_4.csv',0,0,[0, 0, N-1, 5]);
Pr8 = csvread('v4_3_simulationPr_8.csv',0,0,[0, 0, N-1, 5]);
Pr12 = csvread('v4_3_simulationPr_12.csv',0,0,[0, 0, N-1, 5]);
Pr16 = csvread('v4_3_simulationPr_16.csv',0,0,[0, 0, N-1, 5]);
Pr200 = csvread('v4_3_simulationPr_2.csv',0,0,[0, 0, N-1, 5]);

% 准备要用来定位的Rx(x, y, h, pr）,121个位置每个随机h, 确定的h用sureh:1-6
preparerandomh = step1(sureh, N, Pr0, Pr4, Pr8, Pr12, Pr16, Pr200);

% 用route里的坐标来做定位
% preparerandomh = step1_route(routerefxyz, n, Pr0, Pr4, Pr8, Pr12, Pr16, Pr200);


% 准备每一层的m,g
[Rx, m_a, m_b, m_c, m_d, G_a, G_b, G_c, G_d, Pr_a, Pr_b, Pr_c, Pr_d] = preparefun(m0, m4, m8, m12, m16, m200, G0, G4, G8, G12, G16, G200, Pr0, Pr4, Pr8, Pr12, Pr16, Pr200);


succ = 0;
m = 0;
% calculate diff for each level, the min is the height
for i = 1 : n
%     i = 121;
    %     if ((preparerandomh(i, 1) == 0) || (mod(preparerandomh(i, 1), 0.5) == 0))
    %         if ((preparerandomh(i, 2) == 0) || (mod(preparerandomh(i, 2), 0.5) == 0))
    m = m + 1;
    [diff_0, diff_4, diff_8, diff_12, diff_16, diff_200] = step2(preparerandomh(i, :), m0, m4, m8, m12, m16, m200, G0, G4, G8, G12, G16, G200);
    real_h = preparerandomh(i, 3);
    
    
    % estimate h:
    diff_levels = [diff_0, diff_4, diff_8, diff_12, diff_16, diff_200];
    abs_diff = abs(diff_levels);
    [min_diff, pred_h_index] = min(abs_diff);
    
    % when pred_h determined, determine m, G
    if pred_h_index == 1
        pred_m = m0;
        pred_G = G0;
        pred_h = 0;
    elseif pred_h_index == 2
        pred_m = m4;
        pred_G = G4;
        pred_h = 0.4;
    elseif pred_h_index == 3
        pred_m = m8;
        pred_G = G8;
        pred_h = 0.8;
    elseif pred_h_index == 4
        pred_m = m12;
        pred_G = G12;
        pred_h = 1.2;
    elseif pred_h_index == 5
        pred_m = m16;
        pred_G = G16;
        pred_h = 1.6;
    elseif pred_h_index == 6
        pred_m = m200;
        pred_G = G200;
        pred_h = 2;
    end
    
    % positioning, Pr = preparerandomh
    result(m, :) = step4(i, preparerandomh(i, :), pred_h, pred_m, pred_G);
    if result(m, 3) == result(m, 6)
        succ = succ + 1;
    end
    %         end
    %     end
end

pe_min = min(result(:, 7));
pe_max = max(result(:, 7));
pe_avg = mean(result(:, 7));
succpercent = succ/N;

% don't forget to writematrix
% writematrix(result, 'resulth3d_h0_3.csv');
% save('predict3d_h0_3.mat')

toc
% writematrix(result, 'result3d_h2_5.csv')
% save('predict3d_h2_5.mat')