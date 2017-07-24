function [epsilon,n] = chbylpds(wc,rip,ws,atten)
%
% [epsilon,n] = chbylpds(wc,rip,ws,atten)
%
%   This function will calculate the epsilon and order of Chebyshev filter 
% required to meet the Low-Pass specification. 
% The specification is given as 
%       a cut off frequency (wc in rad/sec), 
%       an allowable ripple in the pass-band (rip in dB), 
%       a stop frequency (ws in rad/sec) 
%   and a maximum attenuation in the stop-band (atten in dB). 

epsilon = sqrt(10^(rip/10)-1);

n = ceil(acosh(sqrt(10^(abs(atten)/10)-1)/epsilon)/acosh(ws/wc));

return;
