function [out1,out2] = build(Adata,Bdata,Cdata,Ddata,Pt,Rx,H)
A=[1.25, 1.25];
B=[1.25, 3.75];
C=[3.75, 1.25];
D=[3.75, 3.75];% A_pre=pre(Adata);
% B_pre=pre(Bdata);
% C_pre=pre(Cdata);
% D_pre=pre(Ddata);
A_pre=Adata;
B_pre=Bdata;
C_pre=Cdata;
D_pre=Ddata;
[A_f,D_a]=pre2(Pt,A_pre,A,Rx,H(1));
[B_f,D_b]=pre2(Pt,B_pre,B,Rx,H(2));
[C_f,D_c]=pre2(Pt,C_pre,C,Rx,H(3));
[D_f,D_d]=pre2(Pt,D_pre,D,Rx,H(4));
[c_a,e_a_1]=pso_m_G(A_f,D_a,H(1));
[c_b,e_b_1]=pso_m_G(B_f,D_b,H(2));
[c_c,e_c_1]=pso_m_G(C_f,D_c,H(3));
[c_d,e_d_1]=pso_m_G(D_f,D_d,H(4));
out1=[c_a;c_b;c_c;c_d];
out2=[e_a_1,e_b_1,e_c_1,e_d_1];
end

