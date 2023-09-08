clear
N = 2601;
NumLevel = 3;
pt = 25;

A = [1.25, 1.25];
B = [1.25, 3.75];
C = [3.75, 1.25];
D = [3.75, 3.75];
% 记得改h
hrx = 2;
H = 3 - hrx;

m0 = csvread('m_all_0.csv',0,0,[0, 0, N-1, 3]);
m85 = csvread('m_all_85.csv',0,0,[0, 0, N-1, 3]);
m200 = csvread('m_all_200.csv',0,0,[0, 0, N-1, 3]);

G0 = csvread('G_all_0.csv',0,0,[0, 0, N-1, 3]);
G85 = csvread('G_all_85.csv',0,0,[0, 0, N-1, 3]);
G200 = csvread('G_all_200.csv',0,0,[0, 0, N-1, 3]);

Pr0 = csvread('simulationPrh0.csv',0,0,[0, 0, N-1, 5]);
Pr85 = csvread('simulationPrh85.csv',0,0,[0, 0, N-1, 5]);
Pr200 = csvread('simulationPrh200.csv',0,0,[0, 0, N-1, 5]);

% prepare
[Rx, m_a, m_b, m_c, m_d, G_a, G_b, G_c, G_d, Pr_a, Pr_b, Pr_c, Pr_d] = preparefun(m0, m85, m200, G0, G85, G200, Pr0, Pr85, Pr200);

for i = 1 : 3
    % Max Pr_a in h0,1,2
    maxPr(1, i) = max(Pr_a(:,i + 2));
    % Max Pr_b in h0,1,2
    maxPr(2, i) = max(Pr_b(:,i + 2));
    % Max Pr_c in h0,1,2
    maxPr(3, i) = max(Pr_c(:,i + 2));
    % Max Pr_d in h0,1,2
    maxPr(4, i) = max(Pr_d(:,i + 2));
    
    % Min Pr_a in h0,1,2
    minPr(1, i) = min(Pr_a(:,i + 2));
    % Min Pr_b in h0,1,2
    minPr(2, i) = min(Pr_b(:,i + 2));
    % Min Pr_c in h0,1,2
    minPr(3, i) = min(Pr_c(:,i + 2));
    % Min Pr_d in h0,1,2
    minPr(4, i) = min(Pr_d(:,i + 2));
    
    %suc_contourf = plot_contourf(N, Rx(:,1), Rx(:,2), Pr_b(:, i+2));
end

% measuredPr: received Pr
% measuredPr = Pr200;
measuredPr = Pr0;
% calculate diff for each level, the min is the height
[diff_0, diff_85, diff_200] = predicts(measuredPr, m0, m85, m200, G0, G85, G200);
diff_levels = [diff_0, diff_85, diff_200];
abs_diff = abs(diff_levels);
[min_diff, pred_h_index] = min(abs_diff);
% when pred_h determined, determine m, G 
% pred_m = m200;
% pred_G = G200;
% pred_h = 2;
pred_m = m0;
pred_G = G0;
pred_h = 0;

% positioning, Pr = measurePr
result = positioning_in_h(N, measuredPr, pred_h, pred_m, pred_G);
pe_min = min(result(:, 5));
pe_max = max(result(:, 5));
pe_avg = mean(result(:, 5));
% don't forget to writematrix
% writematrix(result, 'resulth200.csv');