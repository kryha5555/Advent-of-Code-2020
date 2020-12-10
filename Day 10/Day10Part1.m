%% Import data
clear
clc

inputArray = importdata('input.txt');

%% Calculate result for part 1
tic
inputArray = sort([0; inputArray; max(inputArray)+3]);
diffs = zeros(size(inputArray,1)-1,1);

for i = 1:length(diffs)
   diffs(i) = inputArray(i+1)-inputArray(i); 
end

part1 = sum(diffs==1)*sum(diffs==3)
toc