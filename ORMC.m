% ORMC  % 2017-10-19
% object function min ||X-UV-b1^T||2,1  S.T. U'U = i

function out = ORMC(X,N,r,NITER)

%% Input: 
%   X: data matrix
%   N: observed matrix
%   r : the rank of disered matrix
%   NITER: the number of iteration 
fprintf('Test ORMC')
%%  initialize
[m,n] = size(X);
z = find(N ~= 0);  
nz = find(N == 0);
X(nz) = 0;
data = X(z); % the value of known entries 
d = ones(n,1);   % weighted
[U, S, V] = svds(X,r);
V = S*V';
V = V';
re = [];
tic
for k = 1:NITER
    
    % update D
    temp_d = sqrt(d);
    D = spdiags(temp_d,0,n,n);
     
   % update U 
    temp1 = X*D^2*V;
    [Us,sigma,Ud] = svd(temp1,'econ'); % stable
    U = Us*Ud';
    
    % update V_deta
    V = X'*U;
   % update known data
     Xn = U*V';
     X = Xn;
     X(z)= data;
    
    % update D
    tempE = X - Xn;
    t_Bi = sum(tempE.*tempE,1);
    Bi = sqrt(t_Bi + eps)';
    d = 0.5./(Bi);
    obj = sum(sqrt(t_Bi));
    
    % convergence
    if k>2
    if abs(obj - re(k-1))/re(k-1) < 1e-7
        break;     
    end
    end
    re(k) = obj;
    % display
    if mod(k,50)==0
    display(strcat('In the ',num2str(k), '-th iteration'));
    end
end
t1 = toc;
display(strcat('the time of iteration is£º',num2str(t1),'s'));
out.matrix = X;
out.U = U;
out.V = V;
out.re = re;
[~,index] = sort(Bi);
out.index = index;
out.weight = d;

