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
            G = addedge(G, string(A{i}{1}) + " " + string(A{i}{2}), ...
                string(A{i}{j+1}) + " " + string(A{i}{j+2}), ...
                double(A{i}{j} - '0')); % weight
        end
    end
end
part2 = findCost(G,"shiny gold")
toc

%% Helper function
function c = findCost(G,node)
    s = successors(G,node);
    w = G.Edges.Weight(findedge(G,node,s));
    c=0;
    if ~isempty(s)
        for i = 1:length(s)
            c = c + w(i)*(1+findCost(G,s(i)));
        end
    end
end