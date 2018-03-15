con = [c1;c2;c3;c4;c5;c6;c7;c8;c9;c10];
con2 = zeros(1,19)
for i=1:size(con,1)
    con2(con(i,1)) = con2(con(i,1))+1;
end
[out,idx] = sort(con2,2,'descend')

%3,6,11,12,8