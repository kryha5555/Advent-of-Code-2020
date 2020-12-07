%% Import data
clear
clc

inputArray = importdata('input.txt');
A = arrayfun(@(x) split(x),inputArray,'UniformOutput',false);

%% Calculate result for part 1
tic
G = digraph();

for i=1:length(A)
    for j = 5:length(A{i})
        if length( A{i}{j}) == 1
            G = addedge(G, string(A{i}{j+1}) + " " + string(A{i}{j+2}), ...
                string(A{i}{1}) + " " + string(A{i}{2}));
        end
    end
end
part1 = length(nearest(G,"shiny gold",Inf))
toc