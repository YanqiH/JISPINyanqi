function [diff_0, diff_4, diff_8, diff_12, diff_16, diff_200] = step2(Pr, m0, m4, m8, m12, m16, m200, G0, G4, G8, G12, G16, G200)
% predict

% use m0, G0 to position
hrx = 0;
% tM = 'trainedModel_v4_3_0.mat';
tM = 'v5_tM_0.mat';
[result_d0, X_estih0] = step3(Pr, m0, G0, hrx, tM);

% use m4, G4 to position
hrx = 0.4;
% tM = 'trainedModel_v4_3_4.mat';
tM = 'v5_tM_4.mat';
[result_d4, X_estih4] = step3(Pr, m4, G4, hrx, tM);

% use m8, G8 to position
hrx = 0.8;
% tM = 'trainedModel_v4_3_8.mat';
tM = 'v5_tM_8.mat';
[result_d8, X_estih8] = step3(Pr, m8, G8, hrx, tM);

% use m12, G12 to position
hrx = 1.2;
% tM = 'trainedModel_v4_3_12.mat';
tM = 'v5_tM_12.mat';
[result_d12, X_estih12] = step3(Pr, m12, G12, hrx, tM);

% use m16, G16 to position
hrx = 1.6;
% tM = 'trainedModel_v4_3_16.mat';
tM = 'v5_tM_16.mat';
[result_d16, X_estih16] = step3(Pr, m16, G16, hrx, tM);

% use m200, G200 to position
hrx = 2;
% tM = 'trainedModel_v4_3_2.mat';
tM = 'v5_tM_2.mat';
[result_d200, X_estih200] = step3(Pr, m200, G200, hrx, tM);

% estimated x
est_xy_0(1) = X_estih0(1);
est_xy_4(1) = X_estih4(1);
est_xy_8(1) = X_estih8(1);
est_xy_12(1) = X_estih12(1);
est_xy_16(1) = X_estih16(1);
est_xy_200(1) = X_estih200(1);
% estimated y
est_xy_0(2) = X_estih0(2);
est_xy_4(2) = X_estih4(2);
est_xy_8(2) = X_estih8(2);
est_xy_12(2) = X_estih12(2);
est_xy_16(2) = X_estih16(2);
est_xy_200(2) = X_estih200(2);

% 4 distances 
est_d_0(:) = result_d0(1, :);
est_h_0 = 0;
est_d_4(:) = result_d4(1, :);
est_h_4 = 0.4;
est_d_8(:) = result_d8(1, :);
est_h_8 = 0.8;
est_d_12(:) = result_d12(1, :);
est_h_12 = 1.2;
est_d_16(:) = result_d16(1, :);
est_h_16 = 1.6;
est_d_200(:) = result_d200(1, :);
est_h_200 = 2;

A = [1.25, 1.25];
B = [1.25, 3.75];
C = [3.75, 1.25];
D = [3.75, 3.75];
htx = 3;
% Rx-A real distance
% real_da_0 = ((real_xy(1) - A(1))^2 + (real_xy(2) - A(2))^2 + (est_h_0 - htx)^2)^0.5;

% estimated Rx-A distance using m0, G0
est_da_0 = ((est_xy_0(1) - A(1))^2 + (est_xy_0(2) - A(2))^2 + (est_h_0 - htx)^2)^0.5;
est_db_0 = ((est_xy_0(1) - B(1))^2 + (est_xy_0(2) - B(2))^2 + (est_h_0 - htx)^2)^0.5;
est_dc_0 = ((est_xy_0(1) - C(1))^2 + (est_xy_0(2) - C(2))^2 + (est_h_0 - htx)^2)^0.5;
est_dd_0 = ((est_xy_0(1) - D(1))^2 + (est_xy_0(2) - D(2))^2 + (est_h_0 - htx)^2)^0.5;

% estimated Rx-A distance using m4, G4
est_da_4 = ((est_xy_4(1) - A(1))^2 + (est_xy_4(2) - A(2))^2 + (est_h_4 - htx)^2)^0.5;
est_db_4 = ((est_xy_4(1) - B(1))^2 + (est_xy_4(2) - B(2))^2 + (est_h_4 - htx)^2)^0.5;
est_dc_4 = ((est_xy_4(1) - C(1))^2 + (est_xy_4(2) - C(2))^2 + (est_h_4 - htx)^2)^0.5;
est_dd_4 = ((est_xy_4(1) - D(1))^2 + (est_xy_4(2) - D(2))^2 + (est_h_4 - htx)^2)^0.5;

% estimated Rx-A distance using m8, G8
est_da_8 = ((est_xy_8(1) - A(1))^2 + (est_xy_8(2) - A(2))^2 + (est_h_8 - htx)^2)^0.5;
est_db_8 = ((est_xy_8(1) - B(1))^2 + (est_xy_8(2) - B(2))^2 + (est_h_8 - htx)^2)^0.5;
est_dc_8 = ((est_xy_8(1) - C(1))^2 + (est_xy_8(2) - C(2))^2 + (est_h_8 - htx)^2)^0.5;
est_dd_8 = ((est_xy_8(1) - D(1))^2 + (est_xy_8(2) - D(2))^2 + (est_h_8 - htx)^2)^0.5;

% estimated Rx-A distance using m12, G12
est_da_12 = ((est_xy_12(1) - A(1))^2 + (est_xy_12(2) - A(2))^2 + (est_h_12 - htx)^2)^0.5;
est_db_12 = ((est_xy_12(1) - B(1))^2 + (est_xy_12(2) - B(2))^2 + (est_h_12 - htx)^2)^0.5;
est_dc_12 = ((est_xy_12(1) - C(1))^2 + (est_xy_12(2) - C(2))^2 + (est_h_12 - htx)^2)^0.5;
est_dd_12 = ((est_xy_12(1) - D(1))^2 + (est_xy_12(2) - D(2))^2 + (est_h_12 - htx)^2)^0.5;

% estimated Rx-A distance using m16, G16
est_da_16 = ((est_xy_16(1) - A(1))^2 + (est_xy_16(2) - A(2))^2 + (est_h_16 - htx)^2)^0.5;
est_db_16 = ((est_xy_16(1) - B(1))^2 + (est_xy_16(2) - B(2))^2 + (est_h_16 - htx)^2)^0.5;
est_dc_16 = ((est_xy_16(1) - C(1))^2 + (est_xy_16(2) - C(2))^2 + (est_h_16 - htx)^2)^0.5;
est_dd_16 = ((est_xy_16(1) - D(1))^2 + (est_xy_16(2) - D(2))^2 + (est_h_16 - htx)^2)^0.5;

% estimated Rx-A distance using m200, G200
est_da_200 = ((est_xy_200(1) - A(1))^2 + (est_xy_200(2) - A(2))^2 + (est_h_200 - htx)^2)^0.5;
est_db_200 = ((est_xy_200(1) - B(1))^2 + (est_xy_200(2) - B(2))^2 + (est_h_200 - htx)^2)^0.5;
est_dc_200 = ((est_xy_200(1) - C(1))^2 + (est_xy_200(2) - C(2))^2 + (est_h_200 - htx)^2)^0.5;
est_dd_200 = ((est_xy_200(1) - D(1))^2 + (est_xy_200(2) - D(2))^2 + (est_h_200 - htx)^2)^0.5;

% real distance: just for test
real_da = ((Pr(1) - A(1))^2 + (Pr(2) - A(2))^2 + (Pr(3) - htx)^2)^0.5;
real_db = ((Pr(1) - B(1))^2 + (Pr(2) - B(2))^2 + (Pr(3) - htx)^2)^0.5;
real_dc = ((Pr(1) - C(1))^2 + (Pr(2) - C(2))^2 + (Pr(3) - htx)^2)^0.5;
real_dd = ((Pr(1) - D(1))^2 + (Pr(2) - D(2))^2 + (Pr(3) - htx)^2)^0.5;

% est_d_0: calculated d
% est_da_0: using estRx to calcuated d
diff_0_all = [est_d_0(1) - est_da_0, est_d_0(2) - est_db_0, est_d_0(3) - est_dc_0, est_d_0(4) - est_dd_0];
diff_4_all = [est_d_4(1) - est_da_4, est_d_4(2) - est_db_4, est_d_4(3) - est_dc_4, est_d_4(4) - est_dd_4];
diff_8_all = [est_d_8(1) - est_da_8, est_d_8(2) - est_db_8, est_d_8(3) - est_dc_8, est_d_8(4) - est_dd_8];
diff_12_all = [est_d_12(1) - est_da_12, est_d_12(2) - est_db_12, est_d_12(3) - est_dc_12, est_d_12(4) - est_dd_12];
diff_16_all = [est_d_16(1) - est_da_16, est_d_16(2) - est_db_16, est_d_16(3) - est_dc_16, est_d_16(4) - est_dd_16];
diff_2_all = [est_d_200(1) - est_da_200, est_d_200(2) - est_db_200, est_d_200(3) - est_dc_200, est_d_200(4) - est_dd_200];
var0 = var(diff_0_all);
var4 = var(diff_4_all);
var8 = var(diff_8_all);
var12 = var(diff_12_all);
var16 = var(diff_16_all);
var2 = var(diff_2_all);

std0 = std(diff_0_all);
std4 = std(diff_4_all);
std8 = std(diff_8_all);
std12 = std(diff_12_all);
std16 = std(diff_16_all);
std2 = std(diff_2_all);


diff_0 = abs(est_d_0(1) - est_da_0) + abs(est_d_0(2) - est_db_0) + abs(est_d_0(3) - est_dc_0) + abs(est_d_0(4) - est_dd_0);
diff_4 = abs(est_d_4(1) - est_da_4) + abs(est_d_4(2) - est_db_4) + abs(est_d_4(3) - est_dc_4) + abs(est_d_4(4) - est_dd_4);
diff_8 = abs(est_d_8(1) - est_da_8) + abs(est_d_8(2) - est_db_8) + abs(est_d_8(3) - est_dc_8) + abs(est_d_8(4) - est_dd_8);
diff_12 = abs(est_d_12(1) - est_da_12) + abs(est_d_12(2) - est_db_12) + abs(est_d_12(3) - est_dc_12) + abs(est_d_12(4) - est_dd_12);
diff_16 = abs(est_d_16(1) - est_da_16) + abs(est_d_16(2) - est_db_16) + abs(est_d_16(3) - est_dc_16) + abs(est_d_16(4) - est_dd_16);
diff_200 = abs(est_d_200(1) - est_da_200) + abs(est_d_200(2) - est_db_200) + abs(est_d_200(3) - est_dc_200) + abs(est_d_200(4) - est_dd_200);



% writematrix(yresult1, 'predictmg50.csv');
end