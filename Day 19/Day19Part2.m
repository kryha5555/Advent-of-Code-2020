%% Import data
clear
clc

fid = fopen('input.txt');
inputArray= string(splitlines(fscanf(fid,'%c')));
fclose(fid);

%% Parse input
tic
rulesArray = inputArray(1:find(inputArray == "")-1);
messages = inputArray(find(inputArray == "")+1:end);
rules = strings(length(rulesArray),1);

for i = 1:length(rulesArray)
    rule = split(rulesArray(i), ': ');
    rules(str2double(rule(1))+1) = strip(rule(2),'both','"');
end

%% Create regexes and check if messages fully matches the patterns
prev = -1;
part2 = 0;
n = 2;

while true 
    pattern = evalRule(rules,0);  
    part2 = 0;

    for i = 1:length(messages)
        if strlength(regexp(messages(i),pattern,'Match')) == strlength(messages(i))
            part2 = part2+1;
        end
    end
    
    if part2 == prev
        break
    end
    
    rules(8+1) =  rules(8+1)  + " | " + join(repelem("42",n));
    rules(11+1) = rules(11+1) + " | " + join(repelem("42",n)) + " " + ...
                                        join(repelem("31",n));
    prev = part2;
    n = n+1;
end
part2
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