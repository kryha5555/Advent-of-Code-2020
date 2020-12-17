%% Import data
clear
clc

inputArray = importdata('input.txt');

%% Calculate result for part 2
tic
cycles = 6;
grid = double(cell2mat(inputArray) == '#');
grid = padarray(grid,[cycles+1 cycles+1 cycles+1 cycles+1],0);
gridNext = grid;

for c = 1:cycles
    for w = 2:size(grid,4) - 1
        for z = 2:size(grid,3) - 1
            for y = 2:size(grid,2) - 1
                for x = 2:size(grid,1) - 1
                    neig = sum(sum(sum(sum( ...
                        grid(x-1:x+1, y-1:y+1, z-1:z+1, w-1:w+1))))) ...
                        - grid(x,y,z,w);
                    
                    if grid(x,y,z,w) && ( neig < 2 || neig > 3 )
                        gridNext(x,y,z,w) = 0;
                    end
                    
                    if ~grid(x,y,z,w) && neig == 3
                        gridNext(x,y,z,w) = 1;
                    end
                end
            end
        end
    end
    grid = gridNext;
end
part2 = sum(sum(sum(sum(grid(:,:,:,:)))))
toc