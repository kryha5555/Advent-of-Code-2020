%% Import data
clear
clc
inputArray = importdata('input.txt');

%% Calculate result for part 1
tic
len = length(inputArray);

for i=1:len
    for j=i+1:len
        if inputArray(i) + inputArray(j)==2020
            inputArray(i) * inputArray(j)
            toc
            return
        end
    end
end