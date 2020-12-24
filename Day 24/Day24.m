%% Import data
clear
clc

inputArray = (importdata('input.txt'));

%% Parse data
tic
inputArray = replace(inputArray,'se','a'); % a = se
inputArray = replace(inputArray,'sw','b'); % b = sw
inputArray = replace(inputArray,'ne','c'); % c = ne
inputArray = replace(inputArray,'nw','d'); % d = nw

%% Calculate tiles with black side up 
len = 131;
mid = ceil(len/2);
tiles = ones(len,len);

for i = 1:length(inputArray)
    q = mid; r = mid;
    
    for j = 1:length(inputArray{i})
        switch inputArray{i}(j)
            case 'e'
                q = q+1;
            case 'w'
                q = q-1;
            case 'a' % se
                r = r+1;
            case 'b' %sw
                q = q-1;
                r = r+1;
            case 'c' % ne
                q = q+1;
                r = r-1;
            case 'd' %nw
                r = r-1;
        end
    end
    tiles(q,r) = 1 - tiles(q,r);
end
part1 = sum(tiles == 0,'all')
toc

%% Game of Life
iter = 100;
tilesNext = tiles;
convKernel = [0 1 1; 1 0 1; 1 1 0];   

for i = 1:iter
     convArray = convn(1-tiles,convKernel,'same');
     tilesNext(~tiles & ( convArray == 0 | convArray > 2 )) = 1;
     tilesNext(tiles & ( convArray == 2 )) = 0;
     tiles = tilesNext;
end
part2 = sum(tiles == 0,'all')
toc