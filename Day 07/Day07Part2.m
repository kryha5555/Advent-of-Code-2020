%% Import data
clear
clc

inputArray = importdata('input.txt');
rules = arrayfun(@(x) split(x),inputArray,'UniformOutput',false);

%% Calculate result for part 2
tic
G = digraph();

for i=1:length(rules)
    for j = 5:length(rules{i})
        if length( rules{i}{j}) == 1
            G = addedge(G, string(rules{i}{1}) + " " + string(rules{i}{2}), ...
                string(rules{i}{j+1}) + " " + string(rules{i}{j+2}), ...
                double(rules{i}{j} - '0')); % weight
        end
    end
end
part2 = findCost(G,"shiny gold")
toc

%% Helper function
function cost = findCost(G,node)
    s = successors(G,node);
    w = G.Edges.Weight(findedge(G,node,s));
    cost=0;
    if ~isempty(s)
        for i = 1:length(s)
            cost = cost + w(i)*(1+findCost(G,s(i)));
        end
    end
end