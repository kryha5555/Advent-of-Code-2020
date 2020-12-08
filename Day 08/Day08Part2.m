%% Import data
clear
clc

inputArray = importdata('input.txt');

%% Calculate result for part 2
tic
j = 1;
found = 0;

while ~found
    j = j + 1;
    i = 1;
    accumulator =  0;
    copyArray = inputArray;
    visited = zeros(size(inputArray.data));
    
    if copyArray.textdata{j} == "nop"
        copyArray.textdata{j} = "jmp";
    elseif copyArray.textdata{j} == "jmp"
        copyArray.textdata{j} = "nop";
    end
    
    while true
        if i > length(copyArray.data)
            found = 1;
            break;
        end
        if visited(i)
            break;
        end
        visited(i) = 1;
               
        switch copyArray.textdata{i}
            case "nop"
                i = i + 1;
            case "acc"
                accumulator = accumulator + copyArray.data(i);
                i = i + 1;
            case "jmp"
                i = i +  copyArray.data(i);
        end
    end
end
part2 = accumulator 
toc