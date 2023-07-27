function [diff_0, diff_85, diff_200] = predicts(Pr, m0, m85, m200, G0, G85, G200)
% predict

dataset(:, 1) = Pr(:, 3);
dataset(:, 2) = Pr(:, 4);
dataset(:, 3) = Pr(:, 5);
dataset(:, 4) = Pr(:, 6);

% use m0, G0 to position
hrx = 0;
tM = 'trainedModel0.mat';
[result_d0, X_estih0] = predict_h(Pr, m0, G0, hrx, tM);

% use m85, G85 to position
hrx = 0.85;
tM = 'trainedModel85.mat';
[result_d85, X_estih85] = predict_h(Pr, m85, G85, hrx, tM);

% use m200, G200 to position
hrx = 2;
tM = 'trainedModel200.mat';
[result_d200, X_estih200] = predict_h(Pr, m200, G200, hrx, tM);

% for test
real_xy(1) = Pr(200, 1);
real_xy(2) = Pr(200, 2);

% estimated x
est_xy_0(1) = X_estih0(200, 1);
% estimated y
est_xy_0(2) = X_estih200(200, 2);

% 4 distances 
est_d_0(:) = result_d0(200, :);
est_h_0 = 0;

est_xy_85(1) = X_estih85(200, 1);
est_xy_85(2) = X_estih85(200, 2);
est_d_85(:) = result_d85(200, :);
est_h_85 = 0.85;

est_xy_200(1) = X_estih200(200, 1);
est_xy_200(2) = X_estih200(200, 2);
est_d_200(:) = result_d200(200, :);
est_h_200 = 2;

A = [1.25, 1.25];
B = [1.25, 3.75];
C = [3.75, 1.25];
D = [3.75, 3.75];
htx = 3;
% Rx-A real distance
real_da_0 = ((real_xy(1) - A(1))^2 + (real_xy(2) - A(2))^2 + (est_h_0 - htx)^2)^0.5;

% estimated Rx-A distance using m0, G0
est_da_0 = ((est_xy_0(1) - A(1))^2 + (est_xy_0(2) - A(2))^2 + (est_h_0 - htx)^2)^0.5;
est_db_0 = ((est_xy_0(1) - B(1))^2 + (est_xy_0(2) - B(2))^2 + (est_h_0 - htx)^2)^0.5;
est_dc_0 = ((est_xy_0(1) - C(1))^2 + (est_xy_0(2) - C(2))^2 + (est_h_0 - htx)^2)^0.5;
est_dd_0 = ((est_xy_0(1) - D(1))^2 + (est_xy_0(2) - D(2))^2 + (est_h_0 - htx)^2)^0.5;

% estimated Rx-A distance using m85, G85
est_da_85 = ((est_xy_85(1) - A(1))^2 + (est_xy_85(2) - A(2))^2 + (est_h_85 - htx)^2)^0.5;
est_db_85 = ((est_xy_85(1) - B(1))^2 + (est_xy_85(2) - B(2))^2 + (est_h_85 - htx)^2)^0.5;
est_dc_85 = ((est_xy_85(1) - C(1))^2 + (est_xy_85(2) - C(2))^2 + (est_h_85 - htx)^2)^0.5;
est_dd_85 = ((est_xy_85(1) - D(1))^2 + (est_xy_85(2) - D(2))^2 + (est_h_85 - htx)^2)^0.5;

% estimated Rx-A distance using m200, G200
est_da_200 = ((est_xy_200(1) - A(1))^2 + (est_xy_200(2) - A(2))^2 + (est_h_200 - htx)^2)^0.5;
est_db_200 = ((est_xy_200(1) - B(1))^2 + (est_xy_200(2) - B(2))^2 + (est_h_200 - htx)^2)^0.5;
est_dc_200 = ((est_xy_200(1) - C(1))^2 + (est_xy_200(2) - C(2))^2 + (est_h_200 - htx)^2)^0.5;
est_dd_200 = ((est_xy_200(1) - D(1))^2 + (est_xy_200(2) - D(2))^2 + (est_h_200 - htx)^2)^0.5;

% est_d_0: calculated d
% est_da_0: using estRx to calcuated d
diff_0 = est_d_0(1) - est_da_0 + est_d_0(2) - est_db_0 + est_d_0(3) - est_dc_0 + est_d_0(4) - est_dd_0;
diff_85 = est_d_85(1) - est_da_85 + est_d_85(2) - est_db_85 + est_d_85(3) - est_dc_85 + est_d_85(4) - est_dd_85;
diff_200 = est_d_200(1) - est_da_200 + est_d_200(2) - est_db_200 + est_d_200(3) - est_dc_200 + est_d_200(4) - est_dd_200;



% writematrix(yresult1, 'predictmg50.csv');
end