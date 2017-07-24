function n = bwbpdsgn(wsl,wcl,wcu,wsu,atten)
%
% n = bwbpdsgn(wsl,wcl,wcu,wsu,atten);
%
%   This function will calculate the order of Butterworth filter 
% required to meet a Band-Pass specification. The specification is given 
% a as
%     lower stop frequency (wsl - in rad/sec), 
%     lower cut-off frequency (wcl in rad/sec), 
%     upper cut-off frequency (wcu in rad/sec),
%     upper stop frequency (wsu in rad/sec) 
% and a maximum attenuation in the stop-band (atten in dB). 
%

su = abs((wcl*wcu-wsu*wsu)/(wsu*abs(wcu-wcl)));
sl = abs((wcl*wcu-wsl*wsl)/(wsl*abs(wcu-wcl)));

su = min(su,sl);

n = ceil(atten/(-20*log10(su)));


return;

