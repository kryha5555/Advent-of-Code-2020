%% Import data
clear
clc

inputArray = importdata('input.txt');

%% Calculate result for part 1
tic
grid = double(cell2mat(inputArray));
gridPadded = padarray(grid,[1 1],NaN);
gridNew = grid;

while true
    for i=2:size(grid,1)+1
        for j=2:size(grid,2)+1         
            if grid(i-1,j-1) == 'L' && findNs(gridPadded,i,j) == 0
                gridNew(i-1,j-1) = '#';
            elseif grid(i-1,j-1) == '#' && findNs(gridPadded,i,j) >= 4
                gridNew(i-1,j-1) = 'L';
            end
        end
    end
    
    if isequal(grid,gridNew)
        part1 = sum(sum(gridNew == '#'))
        toc
        return
    end
    
    grid = gridNew;
    gridPadded(2:end-1,2:end-1) = gridNew;
end

%% Count the neighbours
function ns = findNs(M,i,j)
    deltas = [[-1,-1];[-1,0];[-1,1];[0,-1];[0,1];[1,-1];[1,0];[1,1]];
    ns = 0;

    for d = 1:length(deltas)
        row = i + deltas(d,1);
        col = j + deltas(d,2);
        
        if M(row,col) == '#'
            ns = ns + 1;
        end
    end
end