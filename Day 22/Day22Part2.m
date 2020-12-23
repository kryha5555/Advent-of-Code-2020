%% Import data
clear
clc

fid = fopen('input.txt');
inputArray = string(splitlines(fscanf(fid,'%c')));
fclose(fid);

%% Parse input
tic
player1 = str2double(inputArray(2:find(inputArray == "")-1));
player2 = str2double(inputArray(find(inputArray == "Player 2:")+1:end));

%% Calculate game result
p1 = 1;
p2 = 1;

[winner, deck] = crabCombat(player1, player2);

%% Calculate result for part 2
sum(deck.*fliplr(1:length(deck))')
toc

%% Helper function
function [winner, deck] = crabCombat(player1, player2)
    gamestate = [];

    while ~(isempty(player1) || isempty(player2))
        currentGamestate = [string(num2str(player1')), string(num2str(player2'))];

        if ~isempty(gamestate)
            if find(gamestate == currentGamestate) % found duplicate of state
                deck = player1;
                winner = 1;
                return
            end
        end
        gamestate = [gamestate; currentGamestate];

        if length(player1)-1 >= player1(1) && length(player2)-1 >= player2(1)
            winner = crabCombat(player1(2:2 + player1(1) - 1), ...
                                player2(2:2 + player2(1) - 1));
        else
            winner =  player1(1) > player2(1);
        end

        if winner == 1
            player1 = [player1; player1(1); player2(1)];
        else
            player2 = [player2; player2(1); player1(1)];
        end

        player1(1) = [];
        player2(1) = [];
    end

    if isempty(player1)
        deck = player2;
        winner = 2;
    else
        deck = player1;
        winner = 1;
    end
end
