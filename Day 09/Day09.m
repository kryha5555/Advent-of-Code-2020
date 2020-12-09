%% Import data
clear
clc
inputArray = importdata('input.txt');

%% Calculate result for part 1
tic
preambleLength = 25;

for i = preambleLength+1:length(inputArray)
    if ~checkIfValid2(inputArray(i-preambleLength:i-1),inputArray(i))
        part1 = inputArray(i)
        toc
        break
    end
end

%% Calculate result for part 2
for head = 1:length(inputArray)
    partSum = 0;
    
    for i = head:length(inputArray)
        partSum = partSum + inputArray(i);
        
        if partSum > part1
            break
        elseif partSum == part1
            part2 = min(inputArray(head:i))+max(inputArray(head:i))
            toc
            return
        end
    end
end

%% Helper function - more elegant solution
function valid = checkIfValid(P, n)
    valid = false;
    for i = 1:length(P)
        if any(P(P~=P(i)) == n-P(i))
            valid = true;
            return
        end
    end
end

%% Helper function - faster solution
function valid = checkIfValid2(A, n)
    valid = false;
    for i = 1:length(A)
        for j = 1:length(A)
            if i ~=j
                if A(i)+A(j)== n
                    valid = true;
                    return
                end
            end
        end
    end
end