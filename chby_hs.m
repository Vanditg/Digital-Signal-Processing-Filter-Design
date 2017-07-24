function [a,gain] = chby_hs(e,n)
%
%  [a,gain] = chby_hs(e,n);
% 
% This function will generate an array of coefficients and a gain term
% which make up the H(s) for an nth order Chebyshev filter 
% with e setting the ripple.

b(1) = 1;
a2 = (sqrt(1+(1/e^2))+1/e)^(1/n);
a1 = 0.5*(a2-1/a2);
b1 = 0.5*(a2+1/a2);
a2 = 1;
for k=1:n/2,
 bw = exp(j*pi*(2*k+n-1)/(2*n));
 b = pmulti(pmulti(1,a1*real(bw)+j*b1*imag(bw))  ...
                    ,a1*real(bw)-j*b1*imag(bw));
 a(k,:) = real(b);
 a2 = a2*a(k,3);
end;
gain = 1/sqrt(1+e*e);
if rem(n,2)>eps,
  a((n+1)/2,:) = [0 1 a1]; 
  gain = 1;
  a2 = a2*a1;
end;
gain = gain*a2; 
return;

