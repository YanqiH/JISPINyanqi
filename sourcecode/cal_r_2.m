function [out] = cal_r_2(data,Pt,g,m,H)
% [e,I]=min(error);
% data_pre=pre(data);
data_pre = data;
G = g;
pt_pr=Pt/mean(data_pre);
A=1e-4;
D=(G*((m + 1) * A * pt_pr * (H ^ (m + 1)))/(2 * pi))^(1/(m+3));
r=abs((D^2-H^2))^(0.5);
out=r;
end

