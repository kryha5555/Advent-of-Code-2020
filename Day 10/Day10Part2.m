%% Import data
clear
clc

inputArray = importdata('input.txt');

%% Calculate result for part 2
tic
inputArray = sort([0; inputArray; max(inputArray)+3]);
len = length(inputArray); % real lenght of input

inputArray = [inputArray; nan; nan]; % pad array to prevent index exceeding
paths = zeros(size(inputArray)); % number of possible paths to each adapter
paths(1) = 1;

for i = 1:len-1
    for j = 1:3 % from i-th adapter you can reach to at most i+3-th one
        if inputArray(i+j) - inputArray(i) > 3            
            break % if you can't reach j-th next adapter 
        end
       
        paths(i+j) = paths(i+j) + paths(i); 
        %fprintf("From %d you can get to %d\n", inputArray(i),inputArray(i+j));
    end
end

part2 = paths(end)
toc