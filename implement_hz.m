function g = implement_hz(num,denom,x)
%
% g = implement_hz(num,denom,x);
%

[n,m] = size(num);
y = x;
for k=1:n,
   g = second_order_Hz( y, num(k,:), denom(k,:) );
   y = g;
end;
return;

function z = second_order_Hz( x, b, a )

[len,width] = size(x);

if( abs( a(1) ) > eps )
   y  = b(1)/a(1) * x(3:len) ...
      + b(2)/a(1) * x(2:len-1) ...
      + b(3)/a(1) * x(1:len-2);
   for k = 3:len-2,
      y(k) = y(k) - a(2)/a(1) * y(k-1) - a(3)/a(1) * y(k-2);
   end;
   z = y(3:len-2);
else
   y  = b(2)/a(2) * x(2:len,:) ...
      + b(3)/a(2) * x(1:len-1,:);
   for k = 2:len-1,
      y(k) = y(k) - a(3)/a(2) * y(k-1);
   end;
end;

return;  
   