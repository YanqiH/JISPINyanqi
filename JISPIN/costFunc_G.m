function [ RMS ] = costFunc_G( sigma,P,D,H,m)
% m=sigma(1);
G=sigma(1);
Pin=P(1,:);
Pout=P(2,:);
% M=S;
% X=F';
% w=2*pi*X;
% R=sigma(1);
% C=sigma(2);
% m=sigma(3);
% Gain=sigma(4);
% Rs=3.6;
% cosphi=0.5;
% Zin=50;
% Adet=1.96e-7;
% L=1e-18;
% D=0.05;
% Hlos=(m+1)*Adet.*cosphi.^(m+1)./(2*pi.*D.^2);
error=zeros(1,length(D));
Dc=zeros(1,length(D));
A=pi*((5.9e-2)/2)^2;
pt_pr=Pin./Pout;
 
for i=1:length(D)
% Dc(i)=((Pout(i)*(m+1)*A*1^(m+1)*Hc)/(Pin(i)*2*pi))^(0.5);
Dc(i)=(G*((m + 1) * A * pt_pr(i) * (H ^ (m + 1)))/(2 * pi))^(1/(m+3));
error(i)=abs(D(i)-Dc(i));
end
% for k=1:length(w)
%  Zn=R./(1+w(k)*1i*C*R);    
%  P(k)=20*log10(Hlos*abs(Zn.^2/((Zn+Rs+Zin+1i*w(k)*L)*R)))+Gain;
%  error(k)=abs(P(k)-M(k))^2;
% end
RMS=sum(error)/length(D);
end
