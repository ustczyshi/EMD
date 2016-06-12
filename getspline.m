function s = getspline(x)

N = length(x);
p = findpeaks(x);
s = spline([0 p N+1],[0 x(p) 0],1:N);
% 三次样条插值，根据[0 p N+1],[0 x(p) 0]得到样条函数，在带入1:N 计算，插入点的值
end