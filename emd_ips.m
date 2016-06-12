function [imf,r] = emd_ips(x,ips)
% Empiricial Mode Decomposition (Hilbert-Huang Transform)
% imf = emd(x)
% Func : findpeaks
% 返回类型为cell类型，一次为一次IMF,二次IMF、。。。、最后残差
x   = transpose(x(:));
imf = x';
while ~ismonotonic(x) % 若信号x不单调，则开始进行emd分解
   x1 = x;
   sd = Inf;
   while (sd > ips) || ~isimf(x1) %
      s1 = getspline(x1);% 对信号极大值进行三次样条插值
      s2 = -getspline(-x1);% 对信号极小值进行三次样条插值
      x2 = x1-(s1+s2)/2;
      
      sd = sum((x1-x2).^2)/sum(x1.^2);
      x1 = x2;
   end
   
   imf = [imf x1'];
   x          = x-x1;
end
r = x;% 剩余残差
end

% FUNCTIONS
%{
function u = ismonotonic(x)

u1 = length(findpeaks(x))*length(findpeaks(-x));
if u1 > 0, u = 0;
else;      u = 1; end

function u = isimf(x)

N  = length(x);
u1 = sum(x(1:N-1).*x(2:N) < 0);
u2 = length(findpeaks(x))+length(findpeaks(-x));
if abs(u1-u2) > 1, u = 0;
else;              u = 1; end

function s = getspline(x)

N = length(x);
p = findpeaks(x);
s = spline([0 p N+1],[0 x(p) 0],1:N);
%}
