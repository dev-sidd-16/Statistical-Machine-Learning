function [trainData, testData] = splitData(data)

trainLength = (2/3)*length(data);
trainData = data(1:trainLength,:);
testData = data(trainLength+1:end,:);

end