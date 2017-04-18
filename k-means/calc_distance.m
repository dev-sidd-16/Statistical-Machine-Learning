function distance = calc_distance(a,b)
try
    distance = sqrt(sum((a-b).^2));
catch
end
end