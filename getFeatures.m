function [ Features ] = getFeatures( data,k )
% ARRAY = zeros(40*32,15);
% count = 1;
% elabel = zeros(40*32,1);
%for k=1:40
Mean = zeros(1,32);
Std = zeros(1,32);
Median = zeros(1,32);
Max = zeros(1,32);
Min = zeros(1,32);
Skew = zeros(1,32);
Kurtosis = zeros(1,32);
Power = zeros(1,32);
Normal = zeros(1,32);
Data = data(k,:,:);
data2 = data.^2;
Data2 = data2(k,:,:);
HjorthActivity = zeros(1,32);
for i=1:32
Min(i) = min(data(k,i,:));
Max(i) = max(data(k,i,:));
Mean(i) = mean(data(k,i,:));
Std(i) = std(data(k,i,:));
Median(i) = median(data(k,i,1:8064));
Power(i) = mean(data2(k,i,:));
for j = 1:8064
Normal(i,j) = (data(k,i,j)-Mean(i))./Std(i);
HjorthActivity(i) = HjorthActivity(i) + (data(k,i,j)-Mean(i))^2;
end
HjorthActivity(i) = HjorthActivity(i)/8064;
end
Var = Std.^2;
FirstDiff = zeros(1,32);
for i =1:32
   for j=1:8063
       diff = abs(data(k,i,j)-data(k,i,j+1));
       FirstDiff(i) = FirstDiff(i)+diff;
   end
   FirstDiff(i) = FirstDiff(i)/8063;
end
NormalFirstDiff = FirstDiff./Std;
SecondDiff = zeros(1,32);
for i =1:32
   for j=1:8062
       diff = abs(data(k,i,j)-data(k,i,j+2));
       SecondDiff(i) = SecondDiff(i)+diff;
   end
   SecondDiff(i) = SecondDiff(i)/8062;
end
NormalSecondDiff = SecondDiff./Std;

FiniteDiff = zeros(32);
SecondFiniteDiff = zeros(32);
for i =1:32
   for j=2:8063
       diff = (data(k,i,j+1)-data(k,i,j-1))/2/(60/8064);
       diff2 = (data(k,i,j+1)+data(k,i,j-1)-2*(data(k,i,j)))/((60/8064)^2);
       SecondFiniteDiff(i,j) = diff2;
       FiniteDiff(i,j) = diff;
   end
end
StdFiniteDiff = zeros(1,32);
StdSecondFiniteDiff = zeros(1,32);
for i=1:32
    StdFiniteDiff(i) = std(FiniteDiff(i,:));
    StdSecondFiniteDiff(i) = std(SecondFiniteDiff(i,:));
end
Mobility = StdFiniteDiff./Std;
SecondMobility = StdSecondFiniteDiff./StdFiniteDiff;
Complexity = SecondMobility./Mobility;
for i=1:32
Skew(i) = sum((data(k,i,:)-Mean(i)).^3)/39/(Std(i)^3);
end
for i = 1:32
    Kurtosis(i) = sum((data(k,i,:)-Mean(i)).^4)/39/(Std(i)^4);
end
Complexity = Normalize(Complexity');
StdFiniteDiff = Normalize(StdFiniteDiff');
StdSecondFiniteDiff = Normalize(StdSecondFiniteDiff');
Kurtosis = Normalize(Kurtosis');
Mobility = Normalize(Mobility');
Skew = Normalize(Skew');
HjorthActivity = Normalize(HjorthActivity');
Power = Normalize(Power');

Features = [FirstDiff',HjorthActivity,Kurtosis,Mean',Median',Mobility,NormalFirstDiff',NormalSecondDiff',Power,SecondDiff',SecondMobility',Skew,Std',StdFiniteDiff,StdSecondFiniteDiff,Complexity,Var',Min',Max'];
% for z = 1:32
%     ARRAY(count,:) = W(z,:);
%     elabel(count,1)= getEmotion(labels(ceil(count/32),:));
%     count = count+1;
% end

end