function [num,denom] = nlp_lp(a,gain,wc);
%
% [num,denom] = nlp_lp(a,gain,wc)
%
%   This function will translate the NLP filter given by "a" and "gain" 
% into a Low-Pass filter with a cutoff of wc.  For Butterworth gain = 1.
% 

[n,m] = size(a);

if m~=3, 
  disp('The input a is not a valid H(s) array.');
  return;
end;

for k=1:n,
  num(k,:) = [0 0 1];
  denom(k,:) = [a(k,1)/(wc*wc) a(k,2)/wc a(k,3)];
end;

num(1,3) = gain;

return;
