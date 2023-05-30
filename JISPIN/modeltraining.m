
clear all;
tic
n = 0;
% for i = 0 : 0.25 : 0.5
%     for j = 0 : 0.25 : 0.5
for i = 0 : 0.5 : 5
    for j = 0 : 0.5 : 5

        % for i = 0 : 0.1 : 0.5
        %     for j = 0 : 0.1 : 0.5
        n = n + 1;
        Pt = 25;
        A=[1.25, 1.25];
        B=[1.25, 3.75];
        C=[3.75, 1.25];
        D=[3.75, 3.75];
        Rx=[i, j];
        hrx = 2;
        %
        H=[3 - hrx, 3 - hrx, 3 - hrx, 3 - hrx];
        % N = 50;

        %%%%%%%%%%%%%%%%inputs%%%%%%%%%%%%%%%%%%%%%
        noi = 0.01;
        cal_rx_ang_a = 3;
        %         cal_rx_ang_a = 0;
        est_rx_ang_a = 0;
        is_pso = 0;
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
                simPra(n, :) = Adata_los_n;
                simPrb(n, :) = Bdata_los_n;
                simPrc(n, :) = Cdata_los_n;
                simPrd(n, :) = Ddata_los_n;
                nstart = (n-1)*50 + 1;
                nend = n * 50;
                dataset(nstart:nend, 1) = Adata_los_n(:);
                dataset(nstart:nend, 2) = Bdata_los_n(:);
                dataset(nstart:nend, 3) = Cdata_los_n(:);
                dataset(nstart:nend, 4) = Ddata_los_n(:);
                dataset(nstart:nend, 5) = n;
                % dataset is used for train classifier, 6505*5
        else

        end

        end
    end
end


toc
disp(['runtime:',num2str(toc)]);
% writematrix(sim,'simulationPr_h2_10.csv')
