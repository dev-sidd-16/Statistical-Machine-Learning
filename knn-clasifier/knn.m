function totalError = knn(distance, labelsTest, labelsTrain, k)

[m,n] = size(distance);

nn = zeros(m,k);
dist = zeros(n,2);

% loop to calculate the k-nearest neighbor of each point in data set
for i = 1:m
    for j = 1:n
        dist(j,2) = j;
    end
    
    dist(:,1) = distance(i,:);
    % sort distance of all train points from the test point in ascending
    % order
    dist = sortrows(dist, 1);
    nn(i,:) = dist(1:k,2);
    
end

error = zeros(m,1);
totalError = 0;

for i = 1:m
    % loop to check if points are mis-classified
    for j = 1:k
        if(labelsTest(i,1) ~= labelsTrain(nn(i,j)))
            error(i,1) = error(i,1) + 1;
        end
    end
    % calculate the error using majority voting
    % in case of a tie, class is assumed to be correctly labeled
    if (error(i,1) > (k/2))
        totalError = totalError + 1;
    end
end

% normalize the errors
error = error./k;
totalError = totalError/m;


end