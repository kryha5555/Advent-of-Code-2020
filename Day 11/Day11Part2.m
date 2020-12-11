%% Import data
clear
clc

inputArray = importdata('input.txt');

%% Calculate result for part 2
tic
grid = double(cell2mat(inputArray));
gridPadded = padarray(grid,[1 1],NaN);
gridNew = grid;

while true
    for i=2:size(grid,1)+1
        for j=2:size(grid,2)+1         
            if grid(i-1,j-1) == 'L' && findNs(gridPadded,i,j) == 0
                gridNew(i-1,j-1) = '#';
            elseif grid(i-1,j-1) == '#' && findNs(gridPadded,i,j) >= 5
                gridNew(i-1,j-1) = 'L';
            end
        end
    end
    
    if isequal(grid,gridNew)
        part2 = sum(sum(gridNew == '#'))
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
        seat = 1;
        while true
            row = i + deltas(d,1)*seat;
            col = j + deltas(d,2)*seat;
            
            if M(row,col) == '#'
               ns = ns + 1;
               break
            elseif M(row,col) == 'L'
               break
            elseif M(row,col) == '.'
                seat = seat+1;
            else % == NaN, out of bounds
                break
            end
        end
    end
end