% Hilbert分析
% envelop,tf,h,angle从参数分别为包络、瞬时频率、输入信号的解析信号、相位
function [envelop,tf,h,angle] = HilbertAnalysis(y,fs)
h = hilbert(y);
Ts = 1/fs;
envelop = abs(h);
angle = unwrap(angle(h));% 平滑相位
tf = diff(angle)/2/pi/Ts;
end