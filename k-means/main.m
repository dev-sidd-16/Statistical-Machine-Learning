function [] = main(dataset)

arr = load(dataset);
x = 2:10;


y = [];
for k = 2:10
    [clusters,centres,J] = my_kmeans(arr, k);
    y = [y; J];
end

plot(x,y);
title('Objective function vs No. of Clusters');
%filename1 = strcat('plots/',num2str(iter),'.fig');
%filename2 = strcat('plots/',num2str(iter),'.png');
saveas(gcf,'kmeans.fig');
saveas(gcf,'kmeans.png');

end