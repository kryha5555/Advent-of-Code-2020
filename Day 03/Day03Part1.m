%% Import data
clear
clc

inputArray=double(char(importdata('input.txt')));
grid=zeros(size(inputArray));
grid(inputArray==double('#')) = 1;

%% Calculate result for part 1
sum=0;

for i=1:size(grid,1)-1
  row = mod(i,size(grid,1))+1;
  col = mod(3*i,size(grid,2))+1;
  sum= sum + grid(row,col);
end

sum