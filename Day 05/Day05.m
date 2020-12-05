%% Import data
clear
clc

inputArray = importdata('input.txt');
%% Calculate seat IDs
tic
seatIDs = [];

for i = 1:length(inputArray)
    bot = 0;
    top = 127;
    
    for j = 1:7
        diff = top-bot+1;
        if inputArray{i}(j)== 'F'
            top = top-diff/2;
        else
            bot = bot+diff/2;
        end
    end
    row = top;
    
    bot = 0;
    top = 7;
    
     for j = 8:10
        diff = top-bot+1;
        if inputArray{i}(j)== 'L'
            top = top-diff/2;
        else
            bot = bot+diff/2;
        end
    end
    col = top;

    seatIDs = [seatIDs row*8+col];
end
seatIDs = sort(seatIDs);

%% Calculate answer for part 1
part1 = seatIDs(end)

%% Calculate answer for part 2
part2 = setdiff(seatIDs(1):seatIDs(end), seatIDs)
toc