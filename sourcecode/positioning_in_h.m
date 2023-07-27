function [result] = positioning_in_h(N, measuredPr, hrx, m, G)
% measurePr: 2601 * 6
% m, G: 2601 * 4
Pt = 25;
A = [1.25, 1.25];
B = [1.25, 3.75];
C = [3.75, 1.25];
D = [3.75, 3.75];
H = [3 - hrx, 3 - hrx, 3 - hrx, 3 - hrx];
Rx(:, 1) = measuredPr(:, 1);
Rx(:, 2) = measuredPr(:, 2);

for i = 1 : N
    
    ra = cal_r(measuredPr(i, 3), Pt, G(i, 1), m(i, 1), H(1));
    rb = cal_r(measuredPr(i, 4), Pt, G(i, 2), m(i, 2), H(2));
    rc = cal_r(measuredPr(i, 5), Pt, G(i, 3), m(i, 3), H(3));
    rd = cal_r(measuredPr(i, 6), Pt, G(i, 4), m(i, 4), H(4));
    xe = cal_xy(A, B, C, D, ra, rb, rc, rd);
    pe = ((xe(1) - Rx(i, 1))^2 + (xe(2) - Rx(i, 2))^2)^0.5;
    
    result(i, 1) = Rx(i, 1);
    result(i, 2) = Rx(i, 2);
    result(i, 3) = xe(1);
    result(i, 4) = xe(2);
    result(i, 5) = pe;
end
end