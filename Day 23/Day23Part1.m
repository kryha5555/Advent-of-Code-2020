%% Import data
clear
clc

input = dec2base(importdata('input.txt'),10)-'0';

%% Setup game
tic
moves = 100;

for move = 1:moves
    %% Select cups to pick up
    current = input(1);
    inputShifted = circshift(input,-1);
    pickup = inputShifted(1:3);
    input = input(~ismember(input,pickup));
    dest = current-1;
    
    %% Find destination cup
    while true
        if dest > 0 && ~any(pickup == dest) 
            break
        end
        
        if dest > 0
            dest = dest-1;
        else
            dest = max(input);
        end
    end
    destIdx = find(input == dest);
    
    %% Prepare cups for next round
    input = [input(1:destIdx) pickup input(destIdx+1:end)];
    input = circshift(input,-1);
end

%% Shift cups so #1 is first
while input(1) ~= 1
    input = circshift(input,-1);
end

%% Calculate result for part 1
part1 = char(input(2:end)+'0')
toc