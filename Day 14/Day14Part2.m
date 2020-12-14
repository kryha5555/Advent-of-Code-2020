%% Import data
clear
clc

fid = fopen('input.txt');
inputArray = textscan(fid,'%s');
fclose(fid);

%% Calculate result for part 2
tic
inputArray = string(inputArray{1});
inputArray = inputArray(inputArray~='=');
bits = 36;
i = 1;
mem = containers.Map('KeyType','double','ValueType','double');

while i <= length(inputArray)
    if inputArray(i) == "mask"
        i = i+1;
        where1 = strfind(inputArray(i),'1');
        whereX = strfind(inputArray(i),'X');
    else
        address = str2double(regexp(inputArray(i),'\d*','Match'));
        i = i+1;
        value = str2double(inputArray(i));
        binary = dec2bin(address,bits);
        binary(where1) = '1';
        perm = ff2n(length(whereX));
        
        for j = 1:length(perm)
            binary(whereX) = perm(j,:) + '0';
            mem(bin2dec(binary)) = value;
            % fprintf("Value %d written to %d (from %d)\n",value,bin2dec(binary),address);
        end
    end
    i = i+1;
end
part2 = sum(cell2mat(values(mem)))
toc