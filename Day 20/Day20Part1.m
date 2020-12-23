%% Import data
clear
clc

inputArray = string(importdata('input.txt'));

%% Parse data
tic
ids = [];
tiles = {};
i = 1;

while i <= length(inputArray)
    if mod(i,11) == 1
        ids = [ids; str2double(regexp(inputArray(i),'\d*','Match'))];
    else
        tiles{end+1} = char(inputArray(i:i+9));
        i = i+9;
    end
    i = i+1;
end

%% Map tiles ids to edges
presentIn = containers.Map();

for i = 1:length(tiles)
    tile = tiles{i};
    tileArray = cell(1,8);
    tileArray{1} = tile(1,:);
    tileArray{2} = tile(end,:);
    tileArray{3} = tile(:,1)';
    tileArray{4} = tile(:,end)';
    tileArray{5} = fliplr(tile(1,:));
    tileArray{6} = fliplr(tile(end,:));
    tileArray{7} = fliplr(tile(:,1)');
    tileArray{8} = fliplr(tile(:,end)');
    
    for j = 1:8
        if isKey(presentIn,tileArray{j})
            presentIn(tileArray{j}) = [presentIn(tileArray{j}) ids(i)];
        else
            presentIn(tileArray{j}) = ids(i);
        end
    end
end
presentInArray = [keys(presentIn); values(presentIn)];

%% Find edges present in only one tile
singleEdges = containers.Map('KeyType','double', 'ValueType','any');

for i = 1:length(keys(presentIn))
    if length(presentInArray{2,i}) == 1
        x = presentInArray{2,i}(1);
        
        if isKey(singleEdges,x)
            singleEdges(x) = singleEdges(x) + 1;
        else
            singleEdges(x) = 1;
        end
    end
end

singleEdgesArray = cell2mat([keys(singleEdges); values(singleEdges)]);

%% Tiles with 4 single edges are corners
part1 = prod(singleEdgesArray(1,singleEdgesArray(2,:) == 4))
toc