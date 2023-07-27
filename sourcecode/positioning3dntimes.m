tic
clear
NumLevel = 3;
pt = 25;

% sureh = 1-6: 0, 0.4, 0.8, 1.2, 1.6, 2 m
n = 121;
sureh = 6;
% 重复次数
ret = 15;

cal_rx_ang_a = 3;

if sureh == 1
    hrx = 0;
elseif sureh == 2
    hrx = 0.4;
elseif sureh == 3
    hrx = 0.8;
elseif sureh == 4
    hrx = 1.2;
elseif sureh == 5
    hrx = 1.6;
elseif sureh == 6
    hrx = 2;
end

% m0 = csvread('m_all_0.csv',0,0,[0, 0, N-1, 3]);
m0 = csvread('v4_3_m_all_0.csv',0,0,[0, 0, n-1, 3]);
m4 = csvread('v4_3_m_all_4.csv',0,0,[0, 0, n-1, 3]);
m8 = csvread('v4_3_m_all_8.csv',0,0,[0, 0, n-1, 3]);
m12 = csvread('v4_3_m_all_12.csv',0,0,[0, 0, n-1, 3]);
m16 = csvread('v4_3_m_all_16.csv',0,0,[0, 0, n-1, 3]);
m200 = csvread('v4_3_m_all_2.csv',0,0,[0, 0, n-1, 3]);


% G0 = csvread('G_all_0.csv',0,0,[0, 0, N-1, 3]);
G0 = csvread('v4_3_G_all_0.csv',0,0,[0, 0, n-1, 3]);
G4 = csvread('v4_3_G_all_4.csv',0,0,[0, 0, n-1, 3]);
G8 = csvread('v4_3_G_all_8.csv',0,0,[0, 0, n-1, 3]);
G12 = csvread('v4_3_G_all_12.csv',0,0,[0, 0, n-1, 3]);
G16 = csvread('v4_3_G_all_16.csv',0,0,[0, 0, n-1, 3]);
G200 = csvread('v4_3_G_all_2.csv',0,0,[0, 0, n-1, 3]);

succ = 0;
m = 0;
% calculate diff for each level, the min is the height
for i = 1 : n

    m = m + 1;

    %repeat for 5 times
    for retimes = 1 : ret

        Pr = generatesimPr(hrx, cal_rx_ang_a);

        % 准备每一层的m,g
        % [Rx, m_a, m_b, m_c, m_d, G_a, G_b, G_c, G_d, Pr_a, Pr_b, Pr_c, Pr_d] = preparefun(m0, m4, m8, m12, m16, m200, G0, G4, G8, G12, G16, G200, Pr0, Pr4, Pr8, Pr12, Pr16, Pr200);
        [Rx, m_a, m_b, m_c, m_d, G_a, G_b, G_c, G_d] = preparefun_for5times(m0, m4, m8, m12, m16, m200, G0, G4, G8, G12, G16, G200, Pr);

        % 准备要用来定位的Rx(x, y, h, pr）,121个位置每个随机h, 确定的h用sureh:1-6
        preparerandomh = step1_sureh(sureh, n, Pr);

        [diff_0(retimes), diff_4(retimes), diff_8(retimes), diff_12(retimes), diff_16(retimes), diff_200(retimes)] = step2(preparerandomh(i, :), m0, m4, m8, m12, m16, m200, G0, G4, G8, G12, G16, G200);
        real_h = preparerandomh(i, 3);

        % estimate h: pred_h_index
        diff_levels(retimes, :) = [diff_0(retimes), diff_4(retimes), diff_8(retimes), diff_12(retimes), diff_16(retimes), diff_200(retimes)];
        abs_diff(retimes, :) = abs(diff_levels(retimes, :));
        [min_diff(retimes), pred_h_index_all(retimes)] = min(abs_diff(retimes, :));
    end

    pred_h_index = mode(pred_h_index_all);


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

end

pe_min_cm = min(result(:, 7)) * 100;
pe_max_cm = max(result(:, 7)) * 100;
pe_avg_cm = mean(result(:, 7)) * 100;
succpercent = succ/n;

toc
disp(['runtime:',num2str(toc)]);