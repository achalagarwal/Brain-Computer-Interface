%test
function [max] = analyse(trie)
m = size(trie,2);
n = size(trie,1);
count = zeros(19,1)
for i=1:m
    for j=1:n
        count(trie(j,i))= count(trie(j,i))+1;
        
    end
end

[out,idx] = sort(count,1,'descend');
max = idx(1:7,1)