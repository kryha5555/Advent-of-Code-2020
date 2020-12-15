%% Import data
clear
clc

inputArray = importdata('input.txt');

%% Calculate result for part 1
tic
stop = 2020;
part1 = numberSpoken(inputArray,stop)
toc

%% Calculate result for part 2
stop = 30000000;
part2 = numberSpoken(inputArray,stop)
toc

%% Helper function
function n = numberSpoken(A,stop)
    lastSeen = zeros(stop,1); % max possible value is equal to stop number
                         
    for i = 1:length(A)
        lastSeen(A(i)+1) = i;
    end 
    prev = 0;
    
    for i = length(A)+1:stop-1
        if lastSeen(prev+1)
            next = i - lastSeen(prev+1);
        else
            next = 0;
        end
        lastSeen(prev+1) = i;
        prev = next;        
    end
    n = prev;
end