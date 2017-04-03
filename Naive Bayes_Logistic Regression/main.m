function [] = main(file)

data = readData(file);
trainData = [];
testData = [];
[trainData, testData] = splitData(data);

splitRandRatios = [0.01, 0.02, 0.03, 0.125, 0.625, 1];

naiveBayes = zeros(length(splitRandRatios),1);
logisticRegression = zeros(length(splitRandRatios),1);
[numTrain,~] = size(trainData);
%[numTest,~] = size(testData);

for j = 1:length(splitRandRatios)
    ratio = splitRandRatios(j);   
    sumNB = 0;
    sumLR = 0;
    for k = 1:5
        randTrain = trainData(randperm(size(trainData,1)),:);
        randTrain = randTrain(1:ceil(ratio*numTrain),:);
        
        nbLabels = trainNaiveBayes(randTrain, testData);
        accuracyNB = test(testData(:,end),nbLabels);
        sumNB = sumNB + accuracyNB;
        
        lrLabels = trainLogisticRegression(randTrain, testData);
        accuracyLR = test(testData(:,end),lrLabels);
        sumLR = sumLR + accuracyLR;
    end
    
    naiveBayes(j) = sumNB/5;
    logisticRegression(j) = sumLR/5;    
end

plot(splitRandRatios,naiveBayes,'-k',splitRandRatios,logisticRegression,'-r');
display(naiveBayes);
display(logisticRegression);
end