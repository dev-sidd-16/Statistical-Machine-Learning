function nLabels = trainNaiveBayes(trainData, testData)

[m,n] = size(trainData);
positive = ones(10,n-1);
posCount = 0;
negative = ones(10,n-1);
negCount = 0;

for i=1:m
    if trainData(i,end) == 1
        for j=1:n-1
            positive(trainData(i,j),j) = positive(trainData(i,j),j) + 1;
        end
        posCount = posCount + 1;
    elseif trainData(i,end) == -1
        for j=1:n-1
            negative(trainData(i,j),j) = negative(trainData(i,j),j) + 1;
        end
        negCount = negCount + 1;
    end          
end


[p,q] = size(testData);
nLabels = zeros(p,1);

for i=1:p
    probPos = 1;
    probNeg = 1;
    for j=1:q-1
        probPos = probPos * (positive(testData(i,j),j)/posCount);
        probNeg = probNeg * (negative(testData(i,j),j)/negCount);
    end
    probPos = probPos * (posCount/m);
    probNeg = probNeg * (negCount/m);
    
    if probPos >= probNeg
        nLabels(i) = 1;
    else
        nLabels(i) = -1;
    end
end


end