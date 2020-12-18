%% Import data
clear
clc

inputArray = importfile('input.txt');

%% Input to RPN
tic
rpn = [];

for i = 1:length(inputArray)
    str = char(inputArray(i));
    expression = [];
    stack = [];
    
    for j = length(str):-1:1
        token = str(j);
        if isstrprop(token,'digit')
            expression = [expression token];
        elseif token == '+' || token == ')'
            stack = [stack token];
        elseif token == '*'
            while ~isempty(stack) && stack(end) == '+'
                expression = [expression stack(end)];
                stack(end) = [];
            end
            stack = [stack token];
        elseif token == '('
            while stack(end) ~= ')'
                expression = [expression stack(end)];
                stack(end) = [];
            end
            stack(end) = [];
        end
    end
    
    while ~isempty(stack)
        expression = [expression stack(end)];
        stack(end) = [];
    end
    rpn = [rpn; string(expression)];
end

%% Calculate result for part 2
part2 = 0;

for i = 1:length(rpn)
    str = char(rpn(i));
    stack = [];
    
    for j = 1:length(str)
        token = str(j);
        if isstrprop(token,'digit')
            stack = [stack, str2double(token)];
        else
            op1 = stack(end);
            op2 = stack(end-1);
            stack(end-1:end) = [];
            stack(end+1) = eval([num2str(op2),token,num2str(op1)]);
        end
    end
    part2 = part2 + stack;
end
part2
toc