function [result_d, X] = step3(Pr, m_csv, g_csv, hrx, tM)
% predict in h0
load(tM)
p_mg = trainedModel.predictFcn(Pr(:, 4:7));

pt = 25;
H = 3 - hrx;
A = [1.25, 1.25];
B = [1.25, 3.75];
C = [3.75, 1.25];
D = [3.75, 3.75];
i = 1;
% real position
Rx(1) = Pr(i, 1);
Rx(2) = Pr(i, 2);

pra = Pr(i, 4);
prb = Pr(i, 5);
prc = Pr(i, 6);
prd = Pr(i, 7);

% ma = m_csv(p_mg(i), 1);
% mb = m_csv(p_mg(i), 2);
% mc = m_csv(p_mg(i), 3);
% md = m_csv(p_mg(i), 4);
% 
% ga = g_csv(p_mg(i), 1);
% gb = g_csv(p_mg(i), 2);
% gc = g_csv(p_mg(i), 3);
% gd = g_csv(p_mg(i), 4);
ma = m_csv(p_mg, 1);
mb = m_csv(p_mg, 2);
mc = m_csv(p_mg, 3);
md = m_csv(p_mg, 4);

ga = g_csv(p_mg, 1);
gb = g_csv(p_mg, 2);
gc = g_csv(p_mg, 3);
gd = g_csv(p_mg, 4);

[ra_test, da_esti] = cal_1r(pt, pra, ma, ga, H);
[rb_test, db_esti] = cal_1r(pt, prb, mb, gb, H);
[rc_test, dc_esti] = cal_1r(pt, prc, mc, gc, H);
[rd_test, dd_esti] = cal_1r(pt, prd, md, gd, H);
% estimate position
X(i, :) = cal_xy(A, B, C, D, ra_test, rb_test, rc_test, rd_test);
error_fin_test(i) = ((X(i, 1)-Rx(1))^2+(X(i, 2)-Rx(2))^2)^0.5;

result(i, 1) = Rx(1);
result(i, 2) = Rx(2);
result(i, 3) = X(i, 1);
result(i, 4) = X(i, 2);
result(i, 5) = error_fin_test(i);
result_d(i, 1) = da_esti;
result_d(i, 2) = db_esti;
result_d(i, 3) = dc_esti;
result_d(i, 4) = dd_esti;

end