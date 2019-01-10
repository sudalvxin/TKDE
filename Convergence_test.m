%% Test MC on generated data

function Out = Convergence_test()
% mxn data matrix M with rank r
m = 500;
n = 500;
r = 10;

U0 = rand(m,r);
V0 = rand(r,n);

cset = [0.3 0.4 0.5 0.6 0.7];

for i=1:length(cset)
temp = cset(i);
W = double(rand(m,n) > temp);  % observed matrix
Omega = find(W);

%ground truth 
M0 = U0*V0; %+ones(m,n);
% adding column outiers
M = M0;
ratio = 0.2;
CoutN = round(n*ratio);
Omat = randn(m,CoutN)*2;
M(:,end - CoutN + 1:end) = M(:,end - CoutN + 1:end) + Omat;

%% Test

tic
out = ORMC(M.*W,W,r,80);
% plot objective value
obj(i,:) = out.re;
end
Out.obj = obj;

% Plot
x = 1:80;
h =  plot(x,obj(1,:),x,obj(2,:),x,obj(3,:),x,obj(4,:),x,obj(5,:));
set(h,'LineWidth',2.0);
s = gca;
set(s, 'Fontname', 'Times new roman','FontSize',16); 
set(gca,'linewidth',1.5); 
hl = legend('p=0.7', 'p=0.6','p=0.5','p=0.4','p=0.3');
set(hl,'Orientation','vertical','FontSize',16);
ylabel('objective value');
xlabel('Iteration k');
















