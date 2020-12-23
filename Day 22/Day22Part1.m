%% Import data
clear
clc

fid = fopen('input.txt');
inputArray= string(splitlines(fscanf(fid,'%c')));
fclose(fid);

%% Parse input 
tic
player1 = str2double(inputArray(2:find(inputArray == "")-1));
player2 = str2double(inputArray(find(inputArray == "Player 2:")+1:end));

%% Calculate game result
p1 = 1;
p2 = 1;

while ~(isempty(player1) || isempty(player2))
    
    if player1(1) > player2(1)
        player1 = [player1; player1(1); player2(1)];
    else
        player2 = [player2; player2(1); player1(1)];
    end
    
    player1(1) = [];
    player2(1) = [];
end

%% Determine winner
if isempty(player1)
    player = player2;
else
    player = player1;
end

%% Calculate result for part 1
part1 = sum(player.*fliplr(1:length(player))')
toc