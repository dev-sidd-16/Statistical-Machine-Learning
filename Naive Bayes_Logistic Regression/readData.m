function [arr] = readData(file)
fid = fopen(file);
arr = [];
tline = fgets(fid);
while ischar(tline)
    a = strsplit(tline,',');
    [~,n] = size(a);
    x = [];
    for i = 2:n
        ch = str2num(a{i});
        if isempty(ch)
            ch = 5;
        end            
        x = [x, ch];
    end
    if x(n-1) == 2   x(n-1) = 1; end
    if x(n-1) == 4   x(n-1) = -1; end
    arr = [arr; x];
    tline = fgets(fid);
end

fclose(fid);

end