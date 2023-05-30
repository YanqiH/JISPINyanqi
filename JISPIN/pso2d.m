% file=dir('C:\Users\SDY\Desktop\VLC_position\0.895H\*.csv');
% fid = fopen(['C:\Users\SDY\Desktop\VLC_position\0.895H\',file.name],'r');
% data = textscan(fid, '%f %f','delimiter', ',');

% %
clear all;
tic

n = 0;
% for i = 0 : 0.25 : 0.5
%     for j = 0 : 0.25 : 0.5
% for i = 0 : 0.2 : 1
%     for j = 0 : 0.2 : 1
        
% for i = 0 : 0.1 : 0.5
%     for j = 0 : 0.1 : 0.5
i = 1;
j = 1;
        n = n + 1;
        Pt = 25;
        A=[1.25, 1.25];
        B=[1.25, 3.75];
        C=[3.75, 1.25];
        D=[3.75, 3.75];
        Rx=[i, j];
        hrx = 0.85;
        %
        H=[3 - hrx, 3 - hrx, 3 - hrx, 3 - hrx];
                % N = 50;
        
        %%%%%%%%%%%%%%%%inputs%%%%%%%%%%%%%%%%%%%%%
        noi = 0.01;
        cal_rx_ang_a = 3;
        %         cal_rx_ang_a = 0;
        est_rx_ang_a = 0;
        is_pso = 1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        if is_pso == 0
            % [Adata, Bdata, Cdata, Ddata] = pr_random_fromcsv(Adata_csv, Bdata_csv, Cdata_csv, Ddata_csv);
            [Adata_los, Bdata_los, Cdata_los, Ddata_los, simPr(n, :), rx_ang_fin_a] = pr_los(n, cal_rx_ang_a, noi, Pt, A, B, C, D, Rx, H);
            sim(n, 1) = i;
            sim(n, 2) = j;
            sim(n, 3) = Adata_los;
            sim(n, 4) = Bdata_los;
            sim(n, 5) = Cdata_los;
            sim(n, 6) = Ddata_los;
            [Xe, rx_ang_fin(n)] = cal_xy_los(n, est_rx_ang_a, Pt, H, Adata_los, Bdata_los, Cdata_los, Ddata_los, A, B, C, D);
            %             [Xe, rx_ang_fin(n)] = cal_xy_los(n, rx_ang_fin_a, Pt, H, Adata_los, Bdata_los, Cdata_los, Ddata_los, A, B, C, D);
            
            error_fin=((Xe(1)-Rx(1))^2+(Xe(2)-Rx(2))^2)^0.5;
            
            result(n, 1) = i;
            result(n, 2) = j;
            result(n, 3) = Xe(1);
            result(n, 4) = Xe(2);
            result(n, 5) = error_fin;
            
            simPra(n, :) = Adata_los;
            simPrb(n, :) = Bdata_los;
            simPrc(n, :) = Cdata_los;
            simPrd(n, :) = Ddata_los;
            
            rx_ang(n, 1) = rx_ang_fin_a;
        else if is_pso == 1
                [Adata_los_n, Bdata_los_n, Cdata_los_n, Ddata_los_n] = pr_los_n(n, cal_rx_ang_a, noi, Pt, A, B, C, D, Rx, H);
                Pr_50measure_4tx (:, 1) = Adata_los_n;
                Pr_50measure_4tx (:, 2) = Bdata_los_n;
                Pr_50measure_4tx (:, 3) = Cdata_los_n;
                Pr_50measure_4tx (:, 4) = Ddata_los_n;
                simPra(n, :) = Adata_los_n;
                simPrb(n, :) = Bdata_los_n;
                simPrc(n, :) = Cdata_los_n;
                simPrd(n, :) = Ddata_los_n;
                
                % m in out1
                [out1,out2] = build(Adata_los_n,Bdata_los_n,Cdata_los_n,Ddata_los_n,Pt,Rx,H);
                m_all(n, :) = out1(:,1);
                
                % G
                [G, error] = cal_G(Rx, out1, H, Pt, Adata_los_n(1:20), Bdata_los_n(1:20), Cdata_los_n(1:20), Ddata_los_n(1:20));
                G_all(n, :) = G(:,1);
                
                ra = cal_r_2(Adata_los_n(1:20), Pt, G(1), out1(1), H(1));
                rb = cal_r_2(Bdata_los_n(1:20), Pt, G(2), out1(2), H(2));
                rc = cal_r_2(Cdata_los_n(1:20), Pt, G(3), out1(3), H(3));
                rd = cal_r_2(Ddata_los_n(1:20), Pt, G(4), out1(4), H(4));
                X=cal_xy(A,B,C,D,ra,rb,rc,rd);
                error_fin=((X(1)-Rx(1))^2+(X(2)-Rx(2))^2)^0.5;
                ra_test=cal_r_test_2(Adata_los_n(21:50),Pt,G(1),out1(1,1),H(1));
                rb_test=cal_r_test_2(Bdata_los_n(21:50),Pt,G(2),out1(2,1),H(2));
                rc_test=cal_r_test_2(Cdata_los_n(21:50),Pt,G(3),out1(3,1),H(3));
                rd_test=cal_r_test_2(Ddata_los_n(21:50),Pt,G(4),out1(4,1),H(4));
                Xe=cal_xy(A,B,C,D,ra_test,rb_test,rc_test,rd_test);
                error_fin_test=((X(1)-Rx(1))^2+(X(2)-Rx(2))^2)^0.5;
                
                result(n, 1) = i;
                result(n, 2) = j;
                result(n, 3) = Xe(1);
                result(n, 4) = Xe(2);
                result(n, 5) = error_fin_test;
            
                
            end
            
        end
%     end
% end
% writematrix(Pr_50measure_4tx,'Pr_50measure_4tx_12_37.csv');

error_avg = mean(result(:, 5));
error_min = min(result(:, 5));
error_max = max(result(:, 5));

ref_x = result(:, 1);
ref_y = result(:, 2);
est_x = result(:, 3);
est_y = result(:, 4);
N = n;
toc
disp(['runtime:',num2str(toc)]);

% pe_cdf = result(:, 5) * 100;
%suc_dis = plot_distributions2(N, ref_x, ref_y, est_x, est_y, -0.5, 5.5, -0.5, 5.5);

% % suc_cdf = plot_cdf(pe_cdf);
% suc_contourf = plot_contourf(N, ref_x, ref_y, pe_cdf);
% suc_pcolor = plot_pcolor(N, ref_x, ref_y, pe_cdf);




% length_Pt=length(data(1,:))-1;
% length_point=length(data(:,1))-1;
% Pt=ones(length_Pt,length_point);
% for i=1:length_Pt
%     Pt(i,:)=Pt(i,:).*data(1,i).*1000;
% end
% D=data(:,5)';
% D(1)=[];
% data_r=data;
% data_r(1,:)=[];
% Pr=ones(length_point,length_Pt);
% for i=1:length_Pt
%     Pr(:,i)=data_r(:,i);
% end
% % Ptt=(Pt.*1e-3);
% % Prr=(Pr.*1e-3);
% [pos1, error1] = pso_positioning([Pt(4,:);Pr(:,4)'],D);