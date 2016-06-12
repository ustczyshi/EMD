function u = isimf(x)

N  = length(x);
u1 = sum(x(1:N-1).*x(2:N) < 0);  % 过零点的个数
u2 = length(findpeaks(x))+length(findpeaks(-x)); % 极值点的个数
    if abs(u1-u2) > 1, 
        u = 0;
    else             
        u = 1;
    end
end