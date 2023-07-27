tic
clear
pt = 25;
n = 121;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sureh = 1-6: 0, 0.4, 0.8, 1.2, 1.6, 2 m
sureh = 3;
% 最大重复次数maxrepeat, 默认重复次数ret=1
maxrepeat = 50;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ret = 1;
s_maxrepeat = num2str(maxrepeat);
cal_rx_ang_a = 3;

if sureh == 1
    hrx = 0;
    s_sureh = '0';
elseif sureh == 2
    hrx = 0.4;
    s_sureh = '4';
elseif sureh == 3
    hrx = 0.8;
    s_sureh = '8';
elseif sureh == 4
    hrx = 1.2;
    s_sureh = '12';
elseif sureh == 5
    hrx = 1.6;
    s_sureh = '16';
elseif sureh == 6
    hrx = 2;
    s_sureh = '2';
end
resultfilename = ['resultesth_h' s_sureh '_repeat' s_maxrepeat 'times.csv'];


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

rx_121coodinate = csvread('rx121coordinate.csv',0,0,[0, 0, n-1, 1]);
% 设立边界(m)：在距离区域边界cadre米的范围内才重复多次定位
cadre = 0.5;

% 成功预测h的个数
succ = 0;

m = 0;
% calculate diff for each level, the min is the height
for i = 1 : n

    m = m + 1;

    % 判断是否在边界
    if ((abs(rx_121coodinate(i, 1) - 5) <= cadre) | (abs(rx_121coodinate(i, 2) - 5) <= cadre) | (abs(rx_121coodinate(i, 1)) - 0 <= cadre) | (abs(rx_121coodinate(i, 2)) - 0 <= cadre))
        ret = maxrepeat;
    else
        % 如果不在边界是否要更改迭代次数（迭代=使用多次估计的h来决定最终h）
        ret = maxrepeat;  % 无论在不在边界都使用maxrepeat的次数
        % ret = 1;  %不在边界则只估计一次h，并把它当做最终估计的h
        % continue;  % 不在边界的话就不做定位了，针对只想看边界迭代次数影响的情况
    end

    %repeat for ret times
    for retimes = 1 : ret

        Pr = generatesimPr(hrx, cal_rx_ang_a);

        % 准备每一层的m,g
        % [Rx, m_a, m_b, m_c, m_d, G_a, G_b, G_c, G_d, Pr_a, Pr_b, Pr_c, Pr_d] = preparefun(m0, m4, m8, m12, m16, m200, G0, G4, G8, G12, G16, G200, Pr0, Pr4, Pr8, Pr12, Pr16, Pr200);
        [Rx, m_a, m_b, m_c, m_d, G_a, G_b, G_c, G_d] = preparefun_for5times(m0, m4, m8, m12, m16, m200, G0, G4, G8, G12, G16, G200, Pr);

        % 准备要用来定位的Rx(x, y, h, pr）确定的h用sureh:1-6
        preparerandomh = step1_1point(sureh, i, Pr);

        [diff_0(retimes), diff_4(retimes), diff_8(retimes), diff_12(retimes), diff_16(retimes), diff_200(retimes)] = step2_1point(preparerandomh, m0, m4, m8, m12, m16, m200, G0, G4, G8, G12, G16, G200);
        real_h = preparerandomh(3);

        % estimate h: pred_h_index
        diff_levels(retimes, :) = [diff_0(retimes), diff_4(retimes), diff_8(retimes), diff_12(retimes), diff_16(retimes), diff_200(retimes)];
        abs_diff(retimes, :) = abs(diff_levels(retimes, :));
        [min_diff(retimes), pred_h_index_all(retimes)] = min(abs_diff(retimes, :));
    end

    pred_h_index = mode(pred_h_index_all);


    % when pred_h determined, determine m, G
    if pred_h_index == 1
        pred_h = 0;
    elseif pred_h_index == 2
        pred_h = 0.4;
    elseif pred_h_index == 3
        pred_h = 0.8;
    elseif pred_h_index == 4
        pred_h = 1.2;
    elseif pred_h_index == 5
        pred_h = 1.6;
    elseif pred_h_index == 6
        pred_h = 2;
    end
    result(i, 1) = preparerandomh(3);
    result(i, 2) = pred_h;

    % positioning, Pr = preparerandomh

    if pred_h == preparerandomh(3)
        succ = succ + 1;
    end

end

succpercent = succ/n;

toc
disp(['runtime:',num2str(toc)]);
result_all(:,1) = Rx(:,1);
result_all(:,2) = Rx(:,2);
result_all(:,3) = result(:,1);
result_all(:,4) = result(:,2);
% example : writematrix(result_all, 'resultesth_h4_repeat50times.csv');
% writematrix(result_all, resultfilename);
[counts, edges] = histcounts(result(:,2))