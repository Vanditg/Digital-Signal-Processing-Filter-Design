function [a,gain] = chbyhs(e,n)
%
% [a,gain] = chbyhs(e,n)
%

b(1) = 1;
a2 = (sqrt(1+(1/e^2))+1/e)^(1/n);
a1 = 0.5*(a2-1/a2);
b1 = 0.5*(a2+1/a2);
sum = 1.0;

l = n/2;

for k=1:l,
 bw = exp(j*pi*(2*k+n-1)/(2*n));
 b(k,1:3) = pmulti(pmulti(1,a1*real(bw)-j*b1*imag(bw)),a1*real(bw)+j*b1*imag(bw));
 sum = sum*b(k,3);
end;
if(2*k~=n)
  b(k+1,2:3) = pmulti(1,-a1);
  sum = sum*a1;
end;
a = real(b);
k = n;
gain = 1;
while (k/2-floor(k/2))==0, k=k/2; end;
if k==1, gain = 1/sqrt(1+e*e); end;
gain = gain*sum;
return;

