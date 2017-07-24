function g = hzval(num,denom,z)
%
% g = hzval(num,denom,z);
%
[n,m] = size(num);
g = 1;
for k=1:n,
  g = g .* (z.*z.*num(k,1)   + z.*num(k,2)   + num(k,3)  ) ./ ...
           (z.*z.*denom(k,1) + z.*denom(k,2) + denom(k,3));
end;
return;

