
%%%%%%����Ⱥ�㷨��λ��%%%%%%%%%%%%%%%%%%
%%%%%%��ʼ��%%%%%%%%%%%%%%%%%%
function [pos, error] = pso_m_G(S,F,H)
N=200;    %���Ӹ���
D=2;     %����ά��
T=500;    %����������
c1=1.8;   %ѧϰ����c1
c2=1.8;   %ѧϰ����c2
Wmax=0.4; %����Ȩ�����ֵ
Wmin=0.2;  %����Ȩ����Сֵ
Xmax=2000;    %λ��x���ֵ  M
Xmin=1;   %λ��x��Сֵ  
Ymax=1e4;    %λ��x���ֵ G  
Ymin=1e4;   %λ��x��Сֵ
% Zmin=1.4187;   %m
% Zmax=1.4187;
% Gmin=80;
% Gmax=120; %Gain
Vmax=0.5;    %�ٶ����ֵ
Vmin=-0.5;   %�ٶ���Сֵ
%%%%%%��ʼ����Ⱥ����(λ�ú��ٶ�)%%%%%%%%%%%%%%%%%%
x=[rand(N,1)*(Xmax-Xmin)+Xmin,rand(N,1)*(Ymax-Ymin)+Ymin];
v=rand(N,D)*(Vmax-Vmin)+Vmin;
%%%%%%��ʼ����������λ�ú�����ֵ%%%%%%%%%%%%%%%%%%
p=x;
pbest=ones(N,1);
for i=1:N
    pbest(i)=costFunc(x(i,:),S,F,H);
end

%%%%%%��ʼ��ȫ������λ�ú�����ֵ%%%%%%%%%%%%%%%%%%
[gbest,id] = min(pbest);
g = p(id,:);
gb=ones(1,T);
for i=1:T
    for j=1:N
     %%%%%%���¸�������λ�ú�����ֵ%%%%%%%%%%%%%%%%%%
       if(costFunc(x(j,:),S,F,H) < pbest(j))
           p(j,:)=x(j,:);
           pbest(j)=costFunc(x(j,:),S,F,H);
       end
     %%%%%%����ȫ������λ�ú�����ֵ%%%%%%%%%%%%%%%%%% 
       if(pbest(j) < gbest)
           g=p(j,:);
           gbest = pbest(j);
       end
     %%%%%%���㶯̬����Ȩ��ֵ%%%%%%%%%%%%%%%%%%   
       w=Wmax-(Wmax-Wmin)*(i/T)^2;
     %%%%%%����λ�ú��ٶ�%%%%%%%%%%%%%%%%%%
       v(j,:)=w*v(j,:)+c1*rand*(p(j,:)-x(j,:))+c2*rand*(g-x(j,:));
       x(j,:)=x(j,:)+v(j,:);
       
     %%%%%%�߽������Ĵ��� (�����ٶ��붨λ��Χ)%%%%%%%%%%%%%%%%%% 
     for ii=1:D
         if(v(j,ii)> Vmax)||(v(j,ii)<Vmin)
             v(j,ii)=rand*(Vmax-Vmin)+Vmin;
         end
     end 
     if(x(j,1)> Xmax)||(x(j,1)<Xmin)
         x(j,1) = rand*(Xmax-Xmin) + Xmin;
     end
     if(x(j,2)> Ymax)||(x(j,2)<Ymin)
         x(j,2) = rand*(Ymax-Ymin) + Ymin;
     end
    end
    %%%%%%��¼ȫ������ֵ%%%%%%%%%%%%%%%%%% 
    gb(i)=gbest;
%     Xmax = max(x(:,1));
%     Xmin = min(x(:,1));
%     Ymax = max(x(:,2));
%     Ymin = min(x(:,2));
end

%%%%%%������Ŷ�λ���%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 pos = g;    %����ֵ
 error = gb(end);
%  F=S(:,1);
% step=(Freq_max-Freq_min)/(Num-1);
% f=Freq_min:step:Freq_max;
% w=2*pi*f;
% R=g(1);
% C=g(2);
% m=g(3);
% Gain=g(4);
% Rs=3.6;
% cosphi=1;
% Zin=50;
% Adet=1.96e-7;
% L=1e-18;
% D=0.05;
% Hlos=(m+1)*Adet.*cosphi.^(m+1)./(2*pi.*D.^2);
% Zn=zeros(1,length(w));
% Y=zeros(1,length(w));
% for i=1:length(w)
% Zn(i)=R/(1+w(i)*1i*C*R);
% Y(i)=20*log10(Hlos*abs(Zn(i)^2/((Zn(i)+Rs+Zin+1i*w(i)*L)*R)))+Gain;
% end
%  plot(f,Y,'r',S(:,1),S(:,2),'LineWidth',2);
%  title('pso_fit')
% figure
%  plot(gb);
%  xlabel('��������');
%  ylabel('��Ӧ��ֵ');
%  title('��Ӧ�Ƚ�������');
%  pause();
end
 %%%%%%��ͼ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 


   
   
   
   