function [result] = step4(i, measuredPr, pred_h, m, G)
% measurePr: 2601 * 6
% m, G: 2601 * 4
Pt = 25;
A = [1.25, 1.25];
B = [1.25, 3.75];
C = [3.75, 1.25];
D = [3.75, 3.75];
H = [3 - pred_h, 3 - pred_h, 3 - pred_h, 3 - pred_h];
Rx(1) = measuredPr(1);
Rx(2) = measuredPr(2);


ra = cal_r(measuredPr(4), Pt, G(i, 1), m(i, 1), H(1));
rb = cal_r(measuredPr(5), Pt, G(i, 2), m(i, 2), H(2));
rc = cal_r(measuredPr(6), Pt, G(i, 3), m(i, 3), H(3));
rd = cal_r(measuredPr(7), Pt, G(i, 4), m(i, 4), H(4));
xe = cal_xy(A, B, C, D, ra, rb, rc, rd);
pe = ((xe(1) - Rx(1))^2 + (xe(2) - Rx(2))^2)^0.5;

result(1) = Rx(1);
result(2) = Rx(2);
result(3) = measuredPr(3);
result(4) = xe(1);
result(5) = xe(2);
result(6) = pred_h;
result(7) = pe;

end