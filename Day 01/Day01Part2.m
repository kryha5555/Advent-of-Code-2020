%% Import data
clear
clc
inputArray = importdata('input.txt');

%% Calculate result for part 2
tic
len = length(inputArray);

for i=1:len
    for j=i+1:len
        for k=j+1:len
            if inputArray(i) + inputArray(j) + inputArray(k) == 2020
                inputArray(i) * inputArray(j) * inputArray(k)
                toc
                return
            end
        end
    end
end