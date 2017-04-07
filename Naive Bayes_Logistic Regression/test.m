function accuracy = test(testLabels,nbLabels)

[m,~] = size(testLabels);
nbCount = length(find(testLabels == nbLabels));
accuracy = nbCount/m;

end