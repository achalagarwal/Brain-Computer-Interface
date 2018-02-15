ARRAY = zeros(40*32,19);
count = 1;
elabel = zeros(40*32,1);
for k=1:40
W = getFeatures(data,k);
for z = 1:32
    ARRAY(count,:) = W(z,:);
    elabel(count,1)= getEmotion(labels(ceil(count/32),:));
    count = count+1;
end
[w,r]= relieff(ARRAY,elabel,4);
end