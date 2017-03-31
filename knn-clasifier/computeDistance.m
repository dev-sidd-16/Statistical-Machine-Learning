function distance = computeDistance(data1, data2)

[m,~] = size(data1);
[n,~] = size(data2);
distance = zeros(m,n);

for i = 1:m
    for j = 1:n
        % calculate the cosine distance between two data points
        distance(i,j) = cosineDistance(data1(i,:), data2(j,:));
    end
end

end