%% Import data
clear
clc

inputArray = importdata('input.txt');
rules = arrayfun(@(x) split(x),inputArray,'UniformOutput',false);

%% Calculate result for part 1
tic
G = digraph();

for i=1:length(rules)
    for j = 5:length(rules{i})
        if length( rules{i}{j}) == 1
            G = addedge(G, string(rules{i}{j+1}) + " " + string(rules{i}{j+2}), ...
                string(rules{i}{1}) + " " + string(rules{i}{2}));
        end
    end
end
part1 = length(nearest(G,"shiny gold",Inf))
toc