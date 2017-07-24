function [num,denom] = nlp_bp(b,gain,wcl,wcu)
%
% [num,denom] = nlp_bp(a,gain,wcl,wcu)
%
%   This function will translate the NLP filter given by "a" and "gain" 
% into a BP filter with a pass band of wcl to wcu. 
% For Butterworth gain is equal to 1.
% 

[n,m] = size(b);
if abs(b(n,1)) > eps,
  num   = zeros( 2*n  , m );
  denom = zeros( 2*n  , m );
else
  num   = zeros( 2*n-1, m );
  denom = zeros( 2*n-1, m );
end;  

wc = sqrt(abs(wcl*wcu));
wb = abs( max(wcu,wcl) - min(wcu,wcl) );

g = 1.0;

for k=1:n,
  if abs( b(k,1) ) > eps,
     d(5) = 1;
     d(4) = b(k,2)*wb/(wc*wc*b(k,1));
     d(3) = (2/(wc^2) + b(k,3)*wb*wb/(b(k,1)*wc^4));
     d(2) = b(k,2)*wb/(b(k,1)*wc^4);
     d(1) = 1/(wc^4);
     rd = roots(d);
     
     denom( 2*k-1, : ) = pmulti(pmulti(1,rd(1)),rd(2));
     num(   2*k-1, 3 ) = 1/b(k,1);
     
     g = g *           num(2*k-1,3)                         ... 
           / sqrt(  (denom(2*k-1,3)-denom(2*k-1,1)*wc*wc)^2 ...
                  + (denom(2*k-1,2)*wc)^2                   );

     denom( 2*k, : )   = pmulti(pmulti(1,rd(3)),rd(4));
     num(   2*k, 1 )   = wb*wb/(wc^4);
     
     g = g *            num(2*k,1) * wc * wc             ... 
           / sqrt(   (denom(2*k,3)-denom(2*k,1)*wc*wc)^2 ...
                   + (denom(2*k,2)*wc)^2                 );

  else
     denom( 2*k - 1, 1 ) = b(k,2);
     denom( 2*k - 1, 2 ) = wb*b(k,3);
     denom( 2*k - 1, 3 ) = wc*wc*b(k,2);
     num(   2*k - 1, 2 ) = wb;
     g = g *            num(2*k-1,2) * wc                    ... 
           / sqrt(   (denom(2*k-1,3)-denom(2*k-1,1)*wc*wc)^2 ...
                   + (denom(2*k-1,2)*wc)^2                 );
  
  end;
end;

if abs(num(1,3)) > eps,
  num(1,3) = num(1,3)*gain/g;
else;
  num(1,2) = num(1,2)*gain/g;
end;

return;

