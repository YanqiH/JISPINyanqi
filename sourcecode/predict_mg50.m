clear

N = 2601;
simPr = csvread('simulationPrh200.csv',0,0,[0, 0, N-1, 5]);
% simPr = csvread('simulationPr31.csv',0,0,[0, 0, N-1, 5]);
m_all_csv = csvread('m_all.csv', 0, 0,[0, 0, 2600, 3]);
g_all_csv = csvread('G_all.csv', 0, 0,[0, 0, 2600, 3]);
m_all = round(m_all_csv);
g_all = round(g_all_csv);
y = csvread('y.csv');

dataset(:, 1) = simPr(:, 3);
dataset(:, 2) = simPr(:, 4);
dataset(:, 3) = simPr(:, 5);
dataset(:, 4) = simPr(:, 6);
dataset(:, 5) = [1 : 2601];

% for i = 1 : 2601
%     no(i) = i;
% end
% per = 0.9;
% samp = round(N * per);
% y = datasample(no, samp);
% for i = 1 : samp
%     j = y(i);
%     dataset(i, 1) = simPr(j, 3);
%     dataset(i, 2) = simPr(j, 4);
%     dataset(i, 3) = simPr(j, 5);
%     dataset(i, 4) = simPr(j, 6);
% end
% dataset(1 : samp, 5) = y(:);

% 用function的方法
% yfit = trainClassifier(dataset)
% yresult1 = yfit.ClassificationKNN.Y;
% y_result(:, 1) = yresult1;

% 用导出模型的方法,文件是trainedModel.mat
% load('trainedModel.mat')
% yresult1 = trainedModel.predictFcn(dataset(:, 1:4));
% 
% writematrix(yresult1, 'predictmg50.csv');
