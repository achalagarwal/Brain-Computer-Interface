Mean = zeros(1,40);
Std = zeros(1,40);
Median = zeros(1,40);
Max = zeros(1,40);
Min = zeros(1,40);
Skew = zeros(1,40);
Kurtosis = zeros(1,40);
Power = zeros(1,40);
Normal = zeros(1,40);
Data = data(1,:,:);
data2 = data.^2;
Data2 = data2(1,:,:);
HjorthActivity = zeros(1,40);
for i=1:40
Mean(i) = mean(data(1,i,:));
Std(i) = std(data(1,i,:));
Median(i) = median(data(1,i,1:8064));
Power(i) = mean(data2(1,i,:));
for j = 1:8064
Normal(i,j) = (data(1,i,j)-Mean(i))./Std(i);
HjorthActivity(i) = HjorthActivity(i) + (data(1,i,j)-Mean(i))^2;
end
HjorthActivity(i) = HjorthActivity(i)/8064;
end
Var = Std.^2;
FirstDiff = zeros(1,40);
for i =1:40
   for j=1:8063
       diff = abs(data(1,i,j)-data(1,i,j+1));
       FirstDiff(i) = FirstDiff(i)+diff;
   end
   FirstDiff(i) = FirstDiff(i)/8063;
end
NormalFirstDiff = FirstDiff./Std;
SecondDiff = zeros(1,40);
for i =1:40
   for j=1:8062
       diff = abs(data(1,i,j)-data(1,i,j+2));
       SecondDiff(i) = SecondDiff(i)+diff;
   end
   SecondDiff(i) = SecondDiff(i)/8062;
end
NormalSecondDiff = SecondDiff./Std;

FiniteDiff = zeros(40);
SecondFiniteDiff = zeros(40);
for i =1:40
   for j=2:8063
       diff = (data(1,i,j+1)-data(1,i,j-1))/2/(60/8064);
       diff2 = (data(1,i,j+1)+data(1,i,j-1)-2*(data(1,i,j)))/((60/8064)^2);
       SecondFiniteDiff(i,j) = diff2;
       FiniteDiff(i,j) = diff;
   end
end
StdFiniteDiff = zeros(1,40);
StdSecondFiniteDiff = zeros(1,40);
for i=1:40
    StdFiniteDiff(i) = std(FiniteDiff(i,:));
    StdSecondFiniteDiff(i) = std(SecondFiniteDiff(i,:));
end
Mobility = StdFiniteDiff./Std;
SecondMobility = StdSecondFiniteDiff./StdFiniteDiff;
Complexity = SecondMobility./Mobility;
for i=1:40
Skew(i) = sum((data(1,i,:)-Mean(i)).^3)/39/(Std(i)^3);
end
for i = 1:40
    Kurtosis(i) = sum((data(1,i,:)-Mean(i)).^4)/39/(Std(i)^4);
end
Complexity = Normalize(Complexity');
StdFiniteDiff = Normalize(StdFiniteDiff');
StdSecondFiniteDiff = Normalize(StdSecondFiniteDiff');
Kurtosis = Normalize(Kurtosis');
Mobility = Normalize(Mobility');
Skew = Normalize(Skew');
HjorthActivity = Normalize(HjorthActivity');
Power = Normalize(Power');
