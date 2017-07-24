function n = bwhpdsgn(wc,ws,atten)
%
%  n = bwhpdsgn(wc,ws,atten)
%
%   This function will calculate the order of Butterworth filter required 
% to meet the High-Pass specification. 
% The specification is given as 
%       a cut-off frequency (wc in rad/sec), 
%       a stop frequency (ws in rad/sec) 
%   and a maximum attenuation in the stop-band (atten in dB). 

n = ceil(atten/(-20*log10(wc/ws)));

return;
