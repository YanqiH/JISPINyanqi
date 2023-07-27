function [x, rx_ang_fin] = cal_xy_los(n, rx_ang_a, Pt, H, Adata_los, Bdata_los, Cdata_los, Ddata_los, A, B, C, D)
Adet=1e-4;
pt_pr_a = Pt/Adata_los;
pt_pr_b = Pt/Bdata_los;
pt_pr_c = Pt/Cdata_los;
pt_pr_d = Pt/Ddata_los;

theta = 70;

% m = 1;
m = -log10(2)/log10(cosd(theta));
% rx_ang_fin = 0;

if rx_ang_a == 0
    rx_ang_fin = rx_ang_a;
    
    De_a=(((m + 1) * Adet * pt_pr_a * (H(1) ^ (m + 1)))/(2 * pi))^(1/(m + 3));
    De_b=(((m + 1) * Adet * pt_pr_b * (H(2) ^ (m + 1)))/(2 * pi))^(1/(m + 3));
    De_c=(((m + 1) * Adet * pt_pr_c * (H(3) ^ (m + 1)))/(2 * pi))^(1/(m + 3));
    De_d=(((m + 1) * Adet * pt_pr_d * (H(4) ^ (m + 1)))/(2 * pi))^(1/(m + 3));
    
else
    %     rng(0, 'twister');
    %     ang_min = -rx_ang_a;
    %     ang_max = rx_ang_a;
    %     r = abs((ang_max - ang_min)).*rand(1000,1) + ang_min;
    %     rx_ang_fin = r(n + 100);
    rx_ang_fin = rx_ang_a;
    
    %     rx_ang_fin = rx_ang_a;
    De_a=(((m + 1) * Adet * pt_pr_a * cos(theta - rx_ang_fin) * (H(1) ^ (m)))/(2 * pi))^(1/(m + 2));
    %De_b=(((m + 1) * Adet * pt_pr_b * cos(theta - rx_ang_fin) * (H(2) ^ (m)))/(2 * pi))^(1/(m + 2));
    De_b=(((m + 1) * Adet * pt_pr_b * (H(2) ^ (m + 1)))/(2 * pi))^(1/(m + 3));
    
    De_c=(((m + 1) * Adet * pt_pr_c * cos(theta + rx_ang_fin) * (H(3) ^ (m)))/(2 * pi))^(1/(m + 2));
    De_d=(((m + 1) * Adet * pt_pr_d * (H(4) ^ (m + 1)))/(2 * pi))^(1/(m + 3));
    
    %De_d=(((m + 1) * Adet * pt_pr_d * cos(theta - rx_ang_fin) * (H(4) ^ (m)))/(2 * pi))^(1/(m + 2));
    
end
r1=abs((De_a^2-H(1)^2))^(0.5);
r2=abs((De_b^2-H(2)^2))^(0.5);
r3=abs((De_c^2-H(3)^2))^(0.5);
r4=abs((De_d^2-H(4)^2))^(0.5);

x1=A(1);
y1=A(2);
x2=B(1);
y2=B(2);
x3=C(1);
y3=C(2);
x4=D(1);
y4=D(2);
a=[x2-x1,y2-y1;x3-x1,y3-y1;x4-x1,y4-y1];
b=0.5.*[(r1^2-r2^2)+(x2^2+y2^2)-(x1^2+y1^2);(r1^2-r3^2)+(x3^2+y3^2)-(x1^2+y1^2);(r1^2-r4^2)+(x4^2+y4^2)-(x1^2+y1^2)];
x=(a'*a)^(-1)*a'*b;


end