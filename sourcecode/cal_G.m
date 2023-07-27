function [out1, out2] = cal_G(Rx, out1, H, Pt, Adata_los_n, Bdata_los_n, Cdata_los_n, Ddata_los_n)
m(1) = out1(1);
m(2) = out1(2);
m(3) = out1(3);
m(4) = out1(4);
A=[1.25, 1.25];
B=[1.25, 3.75];
C=[3.75, 1.25];
D=[3.75, 3.75];
Adet=pi*((5.9e-2)/2)^2;

A_pre=Adata_los_n;
B_pre=Bdata_los_n;
C_pre=Cdata_los_n;
D_pre=Ddata_los_n;

%A_f: ptpr of A
%D_a: reference D
[A_f,D_a]=pre2(Pt,A_pre,A,Rx,H(1));
[B_f,D_b]=pre2(Pt,B_pre,B,Rx,H(2));
[C_f,D_c]=pre2(Pt,C_pre,C,Rx,H(3));
[D_f,D_d]=pre2(Pt,D_pre,D,Rx,H(4));

[G_A,error_A]=pso_G(A_f,D_a,H(1),m(1));
[G_B,error_B]=pso_G(B_f,D_b,H(2),m(2));
[G_C,error_C]=pso_G(C_f,D_c,H(3),m(3));
[G_D,error_D]=pso_G(D_f,D_d,H(4),m(4));

out1=[G_A;G_B;G_C;G_D];
out2=[error_A;error_B;error_C;error_D];
end

% G_a = (2 * pi * D_a^(ma + 3))/((ma + 1) * Adet * A_f * H(1)*(ma + 1));
% end