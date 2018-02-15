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
end
ARRAY = round(Normalize(ARRAY(:,1:17)).*100);
[w,r]= relieff(ARRAY,elabel,4);
w(1,1:8);
[selectedFeatures] = feast('relief',8,ARRAY,elabel);
[selectedFeatures2] = feast('mim',8,ARRAY,elabel);
[selectedFeatures3] = feast('mrmr',8,ARRAY,elabel);
[selectedFeatures4] = feast('cmim',8,ARRAY,elabel);
[selectedFeatures5] = feast('jmi',8,ARRAY,elabel);
[selectedFeatures6] = feast('disr',8,ARRAY,elabel);
[selectedFeatures7] = feast('cife',8,ARRAY,elabel);
[selectedFeatures8] = feast('icap',8,ARRAY,elabel);
[selectedFeatures9] = feast('condred',8,ARRAY,elabel);
% [selectedFeatures10] = feast('cmi',8,ARRAY,elabel);
d5 = [w(1,1:8)';selectedFeatures;selectedFeatures2;selectedFeatures3;selectedFeatures4;selectedFeatures5;selectedFeatures6;selectedFeatures7;selectedFeatures8;selectedFeatures9;];
% 
% % where algName is:
% %  mim, mrmr, cmim, jmi, disr, cife, icap, condred, cmi, relief
