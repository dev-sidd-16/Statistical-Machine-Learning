function [clusters,centres,J] = my_kmeans(arr, K)

clusters = arr;
[m,n] = size(arr);

% initialize cluster centres
centres = [1];
for i = 2:K
    centres = [centres;(i-1)*floor(m/K) + 1];
end

prev = 1000000;
change = 1;
while change ~= 0
    
    J = 0;
    distanceMatrix = zeros(K,m);
    %% calculate distance of each data point from cluster centre
    for i = 1:K
        for j = 1:m
            distanceMatrix(i,j) = calc_distance(clusters(centres(i),1:n-1),clusters(j,1:n-1));
        end
    end
    
    %% assign clusters
    for i = 1:m
        if length(find(centres == i)) == 0
            min_idx = find(distanceMatrix(:,i) == min(distanceMatrix(:,i)));
            if length(min_idx) > 1
                min_idx = min_idx(end);
            end
            try
                clusters(i,end) = min_idx;
            catch
                
            end
            %         else
            %             try
            %                 clusters(i,end) = find(centres == i);
            %             catch
            %             end
        end
        
    end
    
    %% check if any cluster is empty, break the largest clusters
    for i = 1:K
        cluster = clusters(find(clusters(:,end) == i),:);
        [p,~] = size(cluster);
        if p == 0
            maxClusterSize = 0;
            maxCluster = i;
            for j = 1:K
                if j ~= i
                    [q,~] = size(find(clusters(:,end) == j));
                    if q > maxClusterSize
                        maxClusterSize = q;
                        maxCluster = j;
                    end
                end
            end
        end
        
        if p == 0
            count = 0;
            for j = 1:m
                if clusters(j,end) == maxCluster
                    clusters(j,end) = i;
                    count = count + 1;
                end
                
                if(count == maxClusterSize/2)
                    break;
                end
            end
        end
        
    end
    
    %% update cluster centre
    
    for i = 1:K
        cluster = clusters(find(clusters(:,end) == i),:);
        [p,q] = size(cluster);
        distanceCluster = zeros(p,p);
        dist = zeros(1,p);
        for j = 1:p
            for k = 1:p
                distanceCluster(j,k) = calc_distance(cluster(j,:),cluster(k,:));
            end
            dist(j) = sum(distanceCluster(j,:));
        end
        try
            idx = find(dist(:) == min(dist));
        catch
        end
        
        if length(idx) > 1
            idx = idx(end);
        end
        
        for j = 1:m
            if(calc_distance(clusters(j,1:n-1),cluster(idx,1:n-1)) == 0)
                centres(i) = j;
            end
        end
    end
    
    for i = 1:K
        cluster = clusters(find(clusters(:,end) == i),:);
        [p,q] = size(cluster);
        %distanceCluster = zeros(p,p);
        %dist = zeros(1,p);
        for j = 1:p
            J = J + (calc_distance(cluster(j,:),clusters(centres(i),:)))^2;
        end
    end
    %J = J;
    change = prev - J;
    prev = J;
    %display(J);
end


end
