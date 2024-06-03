function s = maxmin_norm(s,maxi,mini)
if nargin <3
    mini = min(s);
end
if nargin < 2
    maxi = max(s);
end

s = (s - mini)/(maxi - mini);