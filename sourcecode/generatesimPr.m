function [sim] = generatesimPr(hrx, cal_rx_ang_a)
n = 0;
for i = 0 : 0.5 : 5
    for j = 0 : 0.5 : 5
        n = n + 1;
        Pt = 25;
        A=[1.25, 1.25];
        B=[1.25, 3.75];
        C=[3.75, 1.25];
        D=[3.75, 3.75];
        Rx=[i, j];
        % hrx = 2;
        %
        H=[3 - hrx, 3 - hrx, 3 - hrx, 3 - hrx];
        % N = 50;

        %%%%%%%%%%%%%%%%inputs%%%%%%%%%%%%%%%%%%%%%
        noi = 0.01;
        % cal_rx_ang_a = 3;
        %         cal_rx_ang_a = 0;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % [Adata, Bdata, Cdata, Ddata] = pr_random_fromcsv(Adata_csv, Bdata_csv, Cdata_csv, Ddata_csv);
        [Adata_los, Bdata_los, Cdata_los, Ddata_los, simPr(n, :), rx_ang_fin_a] = pr_los(n, cal_rx_ang_a, noi, Pt, A, B, C, D, Rx, H);
        sim(n, 1) = i;
        sim(n, 2) = j;
        sim(n, 3) = Adata_los;
        sim(n, 4) = Bdata_los;
        sim(n, 5) = Cdata_los;
        sim(n, 6) = Ddata_los;
        
    end
end
