function b = pmulti(a,z);
%
%   b = pmulti(a,z);
%
%   This function will multiply a polynomial "a" with a first-order 
% polynomial described by a zeros "z".

n = length(a);
b = zeros(1,n+1);
b(1) = a(1);

for k=2:n,
  b(k) = a(k) - z*a(k-1);
end;

b(n+1) = - z*a(n);

return;
