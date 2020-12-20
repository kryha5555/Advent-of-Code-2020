%% Import data
clear
clc

fid = fopen('input.txt');
inputArray= string(splitlines(fscanf(fid,'%c')));
fclose(fid);

%% Parse input and create regex
tic
rulesArray = inputArray(1:find(inputArray == "")-1);
messages = inputArray(find(inputArray == "")+1:end);
rules = strings(length(rulesArray),1);

for i = 1:length(rulesArray)
    rule = split(rulesArray(i), ': ');
    rules(str2double(rule(1))+1) = strip(rule(2),'both','"');
end
pattern = evalRule(rules,0);

%% Check if message fully matches the pattern
part1 = 0;

for i = 1:length(messages)
    if strlength(regexp(messages(i),pattern,'Match')) == strlength(messages(i))
        part1 = part1+1;
    end
end
part1
toc

%% Evaluate rule
function ret = evalRule(rules,idx)
    if contains("ab",rules(idx+1))
        ret = rules(idx+1);
    else
        subrules = split(rules(idx+1), "|");

        for i = 1:length(subrules)
            symbols = double(regexp(subrules(i),'\d*','Match'));
            subrules(i) = '';
            
            for j = 1:length(symbols)
                subrules(i) = subrules(i) + evalRule(rules,symbols(j));
            end
        end
        ret = '(' + join(subrules,"|") + ')';
    end
end