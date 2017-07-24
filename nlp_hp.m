function [num,denom] = nlp_hp(a,gain,wc);
% 
% [num,denom] = nlp_hp(a,gain,wc);
%
%   This function will translate the NLP filter given by "a" and "gain" 
% into a HP filter with a cutoff of wc.  For Butterworth gain = 1.
% 

[n,m] = size(a);

if m~=3, 
  disp('The input a is not a valid H(s) array.');
  return;
end;

for k=1:n,
  if a(k,1)>eps,
    num(k,:) = [1/(wc*wc) 0 0];
    denom(k,:) = [a(k,3)/(wc*wc) a(k,2)/wc a(k,1)];
  else
    num(k,:) = [0 1/wc 0];
    denom(k,:) = [0 a(k,3)/wc a(k,2)];
  end;
end;

if a(1,1)>eps,
  num(1,1) = gain*num(1,1);
else
  num(1,2) = gain*num(1,2);
end;

return;
