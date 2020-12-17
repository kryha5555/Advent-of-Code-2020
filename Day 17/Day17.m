%% Import data
clear
clc

inputArray = importdata('input.txt');

%% Rearrange data data
tic
grid = double(cell2mat(inputArray) == '#');
cycles = 6;

%% Calculate result for part 1
dim = 3;
part1 = conwayCubes(grid,dim,cycles)
toc

%% Calculate result for part 2
dim = 4;
part2 = conwayCubes(grid,dim,cycles)
toc

%% Helper function
function n = conwayCubes(A,dim,cycles)
    A = padarray(A,cycles*ones(1,dim),0);
    nextA = A;
    convKernel = ones(3*ones(1,dim));
    convKernel(ceil(end/2)) = 0;
    
    for c = 1:cycles
        convArray = convn(A,convKernel,'same');
        nextA(A & ( convArray < 2 | convArray > 3 )) = 0;
        nextA(~A & convArray == 3) = 1;
        A = nextA;
    end   
    n = sum(A,'all');
end
