%% Import data
clear
clc

input = dec2base(importdata('input.txt'),10)-'0';

%% Fill the input
input = [input max(input)+1:1000000];

%% Iterate over moves
tic
moves = 10000000;
next = zeros(size(input));

for i = 1:9
    idx = find(input == i);
    
    if idx == length(input)
        idx = 0;
    end
    next(i) = input(idx+1);
end

next(10:end-1) = 11:1000000;
next(end) = input(1);
current = input(1);

for move = 1:moves
    pickup1 = next(current);
    pickup2 = next(pickup1);
    pickup3 = next(pickup2);    
    dest = current-1;
    
    if dest == 0
        dest = length(input);
    end
    
    while pickup1 == dest || pickup2 == dest || pickup3 == dest
        dest = dest-1;
        if dest == 0
            dest = length(input);
        end
    end
    next(current) = next(pickup3);
    next(pickup3) = next(dest);
    next(dest) = pickup1;
    current = next(current); 
end

%% Calculate result for part 2
part2 = next(1)*next(next(1))
toc