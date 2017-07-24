function pz_plot( nz, dz )
%
% pz_plot( num, denom );
%

[n,m] = size(nz);

plot( cos(pi/256*[0:512]), sin(pi/256*[0:512]), '-' );
axis( [ -1.25 1.25 -1.25 1.25 ] );
hold on;

for k = 1:n
   z = roots( nz( k,:) )';
   p = roots( dz( k,:) )';
   plot( real(z), imag(z), 'o' );
   plot( real(p), imag(p), '+' );
end;

return;
