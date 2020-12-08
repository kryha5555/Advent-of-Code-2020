%% Import data
clear
clc

inputArray = importdata('input.txt');

%% Calculate result for part 1
tic
i = 1;
accumulator =  0;
visited = zeros(size(inputArray.data));

while true
    if visited(i)
        break;
    end
    visited(i) = 1;
    
    switch inputArray.textdata{i}
        case "nop"
            i = i + 1;
        case "acc"
            accumulator = accumulator + inputArray.data(i);
            i = i + 1;
        case "jmp"
            i = i +  inputArray.data(i);
    end
end
part1 = accumulator
toc