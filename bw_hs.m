function a = bw_hs(n)
%
%  a = bw_hs(n);
% 
% This function will generate an array of coefficients 
% which make up the H(s) for an nth order Butterworth filter.
% The coefficients (a) are in a 3 x m array, where m = int( (n+1)/2 ).  

for k=1:n/2,
  b = pmulti(pmulti(1,exp(-j*pi*(2*k+n-1)/(2*n))) ...
                     ,exp( j*pi*(2*k+n-1)/(2*n)));
  % trim off any imaginary parts ( should only be roundoff error ).
  a(k,:) = real(b);
end;

% insert Odd order single pole.
if rem(n,2)>eps,
 a((n+1)/2,:) = [0 1 1];
end;
return;

