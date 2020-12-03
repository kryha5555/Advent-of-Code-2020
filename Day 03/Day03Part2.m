%% Import data
clear
clc

inputArray=double(char(importdata('input.txt')));
grid=zeros(size(inputArray));
grid(inputArray==double('#')) = 1;

%% Calculate result for part 2
slopeRow=[1,1,1,1,2];
slopeCol=[1,3,5,7,1];
product = 1;

for slope=1:length(slopeRow)
    sum=0; 
    for i=1:1/slopeRow(slope)*size(grid,1)-1
        row = mod(slopeRow(slope)*i,size(grid,1))+1;
        col = mod(slopeCol(slope)*i,size(grid,2))+1;
        sum= sum+ grid(row,col);
    end
    product = product *sum;
end
product