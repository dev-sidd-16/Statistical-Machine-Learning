function y_hat = lrPredict(X,weights)
[~,n] = size(X);
ynew = weights(1);
for j=1:n-1
    ynew = ynew + (weights(1+j)*X(j));
end
y_hat = 1 / (1 + exp(-ynew));
end