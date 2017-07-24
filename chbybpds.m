function [epsilon,n] = chbybpds(ripple,wsl,wcl,wcu,wsu,atten)
%
% [epsilon,n] = chbybpds(ripple,wsl,wcl,wcu,wsu,atten);
%
%   This function will calculate the epsilon and order of Chebyshev filter 
% required to meet a Band-Pass specification. The specification is given 
% a as
%     allowable ripple in the pass-band (rip in dB), 
%     lower stop frequency (wsl - in rad/sec), 
%     lower cut-off frequency (wcl in rad/sec), 
%     upper cut-off frequency (wcu in rad/sec),
%     upper stop frequency (wsu in rad/sec) 
% and a maximum attenuation in the stop-band (atten in dB). 
%

su = abs((wcl*wcu-wsu*wsu)/(wsu*abs(wcu-wcl)));
sl = abs((wcl*wcu-wsl*wsl)/(wsl*abs(wcu-wcl)));

su = min(su,sl);

epsilon = sqrt(10^(ripple/10)-1);

n = ceil(acosh(sqrt(10^(abs(atten)/10)-1)/epsilon)/acosh(su));

return;

