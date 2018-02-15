function [ Normalized ] = Normalize( input )
%NORMALIZE Summary of this function goes here
%   Detailed explanation goes here
Normalized = zeros(size(input));
mi = min(input);
ma = max(input);
ra = ma-mi;
for i=1:size(input,1);
Normalized(i,:) = (input(i,:)-mi)./ra;
end

