function level = select_level(x1,mra)
x1 = maxmin_norm(x1);
crossc = zeros(1,3);
for i = 1:3
    temp = sum(mra(:,i),2);
    temp = maxmin_norm(temp);
    [xcf,~] = xcorr(x1,temp);
    crossc(i) = max(xcf);
end
[~,level] = max(crossc);
