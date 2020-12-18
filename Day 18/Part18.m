%% Import data
clear
clc

inputArray = importfile('input.txt');

%% Calculate result for part 1
tic
inputArray = strrep(inputArray,'+','/'); % '/' has same precedence level as '*'
part1 = sum(arrayfun(@(x) eval(x),inputArray))
toc

%% Calculate result for part 2
inputArray = strrep(inputArray,'*','-'); % '-' has lower precedence level than '*'
part2 = sum(arrayfun(@(x) eval(x),inputArray))
toc

%% Override operators
function n = mrdivide(a,b) % override '/' operator so it works like '+'
    n = a+b;
end

function n = minus(a,b) % override '-' operator so it works like '*'
    n = a*b;
end