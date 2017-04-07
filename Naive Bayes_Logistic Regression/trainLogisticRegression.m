function lrLabels = trainLogisticRegression(trainData, testData)

[m,n] = size(trainData);
weights = rand(n,1);
eta = 0.01;
nEpochs = 100;

for epoch = 1:nEpochs
    for i=1:m
        y = trainData(i,end);
        if y == -1
            y = 0;
        end
        X = trainData(i,1:n-1);
        y_hat = lrPredict(X,weights);
        weights(1:1) = weights(1:1) + (eta * (y-y_hat));
        weights(2:end) = weights(2:end) + ((eta * (y-y_hat)) .* X');
    end   
end

[p,~] = size(testData);
lrLabels = zeros(p,1);

for i=1:p
    
    X = testData(i,1:n-1);
    y_hat = lrPredict(X,weights);
    if y_hat >= 0.5
        lrLabels(i) = 1;
    else
        lrLabels(i) = -1;
    end
end

end