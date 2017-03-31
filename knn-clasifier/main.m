% load the faces data
load faces.mat

% compute the training distance
% i.e distance of each train data point from all other points
distanceTrain = computeDistance(traindata, traindata);

% compute the testing ditance 
% i.e distance of each test data point from train data point 
distanceTest = computeDistance(testdata, traindata);

% array of k value for multiple k-NN classifier
k = [1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];

% initialize train error and test error 
trainError = zeros(size(k));
testError = zeros(size(k));

for i = 1:11
   trainError(i) = knn(distanceTrain, trainlabels, trainlabels, k(i));
   testError(i) = knn(distanceTest, testlabels, trainlabels, k(i));
end

% Plot the train vs test error for different values of k 
plot(k,trainError,'r',k,testError,'g');
xlabel('k');
ylabel('error');
legend('Training Error', 'Testing Error');
title('Error comparison for training and test error for different k-nn');
saveas(gcf, 'error.png');