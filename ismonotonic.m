function u = ismonotonic(x)% ÅĞ¶ÏÊÇ·ñµ¥µ÷

u1 = length(findpeaks(x))*length(findpeaks(-x));
    if u1 > 0, 
        u = 0;
    else
        u = 1;
    end
end