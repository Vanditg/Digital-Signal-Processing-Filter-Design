% Filter Design set.
fs    = 8e3;
f1    = 1e3;
f2    = 2e3;
% Low pass design
del1 = 250;
wc = tan(pi*(f1)/fs);
ws = tan(pi*(f1+del1)/fs);
[elp,nlp] = chbylpds( wc, 1, ws, 40 )
% >> elp =    0.5088
% >> nlp =    9
[alp,glp] = chby_hs( elp, nlp );
[nlp,dlp] = nlp_lp( alp, glp, wc );
[nzlp,dzlp] = hs_z( nlp, dlp );
w = [0:pi/512:pi];
frlp = hzval( nzlp, dzlp, exp(i*w) );
d = zeros( 512, 1 );
d(32) = 1;
h_lp = implement_hz( nzlp, dzlp, d );
% band pass design
del2 = 250;
wsl = tan(pi*(f1-del2)/fs);
wcl = tan(pi*(f1)/fs);
wcu = tan(pi*(f2)/fs);
wsu = tan(pi*(f2+del2)/fs);
nbp = bwbpdsgn( wsl, wcl, wcu, wsu, -40 )
% >> nbp =    12
abp = bw_hs( nbp );
[nbp,dbp] = nlp_bp( abp, 1, wcl, wcu );
[nzbp,dzbp] = hs_z( nbp, dbp );
frbp = hzval( nzbp, dzbp, exp(i*w) );
h_bp = implement_hz( nzbp, dzbp, d );

% High Pass design
wch = tan(pi*(f2)/fs);
wsh = tan(pi*(f2-del2)/fs);
[ehp,nhp] = chbyhpds( wch, 1, wsh, -40 )
% >> ehp =    0.5088
% >> nhp =    10
[ahp,ghp] = chby_hs( ehp, nhp );
[nhp,dhp] = nlp_hp( ahp, ghp, wch );
[nzhp,dzhp] = hs_z( nhp, dhp );
frhp = hzval( nzhp, dzhp, exp(i*w) );
h_hp = implement_hz( nzhp, dzhp, d );
% Plot the results.
figure(1);
plot( w,abs(frlp),'-', w,abs(frbp),':', w,abs(frhp),'-.' );
title( 'Frequency Responses of the Three Filters' );

figure(2);
subplot(311),plot( h_lp(1:132) );
title( 'Impulse Responses of the Three Filters' );
subplot(312),plot( h_bp(1:132) );
subplot(313),plot( h_hp(1:132) );

%%
% Range of values for cutoff.
w1 = tan(pi*800/8000);
w2 = tan(pi*900/8000);
% Stop band frequency 
w3 = tan(pi*2000/8000);

% Start the search for a cutoff at edge 
wc = w2;
g = 0.71; % Set cutoff gain to start loop 
while g > 0.707 % loop while gain too high
    wc = (9*wc+w1)/10; % Shift design cutoff 1/10 of the way towards w1
    [e,n] = chbylpds( wc, 0.5, w3, -40 );  % Design filter  
    g = 1/(1+e*e*(cosh(n*acosh(w2/wc)))^2); % Gain at 3 dB point
end;

e
n
g
f = 8000*atan(wc)/pi
f2 = 8000 * atan( w2 )/ pi
%
%wc =
%    0.4086
%
%e =
%    0.3493
%
%n =
%     5
%
%g =
%    0.7230
%
%f =
%  842.5191
%
%f2 =
%  900
%

% Move back one step and build filter
%wc = wc + (wc-w1)/9;
%[e,n] = chbylpds( wc, 0.5, w3, -40 );   
 
% Build this filter 
[a,g] = chby_hs( e, n );
[n,d] = nlp_lp( a, g, wc );
[nz,dz] = hs_z( n, d );
fr = hzval( nz, dz, exp(i*w) );
h = implement_hz( nz, dz, d );

% Plot the results.
figure(3);
plot( w,abs(fr),'-', [0 pi*f/4000 pi*f/4000 0], [1 1 0.944 0.944], 'g',...
      [0 pi*900/4000 pi*900/4000  0], [1 1 0.707 0.707], 'r',...
      [pi pi*2000/4000 pi*2000/4000], [ 0.01 0.01 0.1], 'r' );
title( 'Frequency Responses of the Iteratively Designed Filter' );

