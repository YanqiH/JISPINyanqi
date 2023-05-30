function [pos, error] = pso_G(S,F,H,m)
N=200;    %粒子个数
D=1;     %粒子维数
T=500;    %最大迭代次数
c1=1.8;   %学习因子c1
c2=1.8;   %学习因子c2
Wmax=0.4; %惯性权重最大值
Wmin=0.2;  %惯性权重最小值
Xmax=1e6;    %位置x最大值  M
Xmin=1;   %位置x最小值  
% Ymax=1e6;    %位置x最大值 G  
% Ymin=1;   %位置x最小值
% Zmin=1.4187;   %m
% Zmax=1.4187;
% Gmin=80;
% Gmax=120; %Gain
Vmax=0.5;    %速度最大值
Vmin=-0.5;   %速度最小值
%%%%%%初始化种群个体(位置和速度)%%%%%%%%%%%%%%%%%%
x=[rand(N,1)*(Xmax-Xmin)+Xmin];
v=rand(N,D)*(Vmax-Vmin)+Vmin;
%%%%%%初始化个体最优位置和最优值%%%%%%%%%%%%%%%%%%
p=x;
pbest=ones(N,1);
for i=1:N
    pbest(i)=costFunc_G(x(i,:),S,F,H,m);
end

%%%%%%初始化全局最优位置和最优值%%%%%%%%%%%%%%%%%%
[gbest,id] = min(pbest);
g = p(id,:);
gb=ones(1,T);
for i=1:T
    for j=1:N
     %%%%%%更新个体最优位置和最优值%%%%%%%%%%%%%%%%%%
       if(costFunc_G(x(j,:),S,F,H,m) < pbest(j))
           p(j,:)=x(j,:);
           pbest(j)=costFunc_G(x(j,:),S,F,H,m);
       end
     %%%%%%更新全局最优位置和最优值%%%%%%%%%%%%%%%%%% 
       if(pbest(j) < gbest)
           g=p(j,:);
           gbest = pbest(j);
       end
     %%%%%%计算动态惯性权重值%%%%%%%%%%%%%%%%%%   
       w=Wmax-(Wmax-Wmin)*(i/T)^2;
     %%%%%%更新位置和速度%%%%%%%%%%%%%%%%%%
       v(j,:)=w*v(j,:)+c1*rand*(p(j,:)-x(j,:))+c2*rand*(g-x(j,:));
       x(j,:)=x(j,:)+v(j,:);
       
     %%%%%%边界条件的处理 (限制速度与定位范围)%%%%%%%%%%%%%%%%%% 
     for ii=1:D
         if(v(j,ii)> Vmax)||(v(j,ii)<Vmin)
             v(j,ii)=rand*(Vmax-Vmin)+Vmin;
         end
     end 
     if(x(j,1)> Xmax)||(x(j,1)<Xmin)
         x(j,1) = rand*(Xmax-Xmin) + Xmin;
     end
%      if(x(j,2)> Ymax)||(x(j,2)<Ymin)
%          x(j,2) = rand*(Ymax-Ymin) + Ymin;
%      end
    end
    %%%%%%记录全局最优值%%%%%%%%%%%%%%%%%% 
    gb(i)=gbest;
%     Xmax = max(x(:,1));
%     Xmin = min(x(:,1));
%     Ymax = max(x(:,2));
%     Ymin = min(x(:,2));
end

%%%%%%输出最优定位结果%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 pos = g;    %最优值
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
end

