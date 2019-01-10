%% Test MC on generated data

function Out = TestMConGeneratedData()
% mxn data matrix M with rank r
m = 500;
n = 500;
r = 10;

U0 = rand(m,r);
V0 = rand(r,n);

W = double(rand(m,n) > 0.4);  % observed matrix

%ground truth 
M0 = U0*V0; %+ones(m,n);

% adding column outiers
M = M0;
ratio = 0.2;
CoutN = round(n*ratio);
Omat = randn(m,CoutN)*2;
M(:,end - CoutN + 1:end) = M(:,end - CoutN + 1:end) + Omat;

%% Test ORMC
tic
out = ORMC(M.*W,W,r,1000);

% plot objective value
obj = out.re;
figure(1)
plot(1:length(obj),obj);
%plot weighted of all columns
figure(2)
weighted = out.weight;
plotweighted(weighted)
%test re on inliers
M_est = out.matrix;
toc
E = M0 - M_est;
E(:,end - CoutN + 1:end) = [];
RE = norm(E,'fro')/norm(M0(:,1:end - CoutN),'fro');
Out.ORMC = RE;
Out.weighted = weighted;
end

















