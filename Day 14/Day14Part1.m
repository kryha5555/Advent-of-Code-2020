%% Import data
clear
clc

fid = fopen('input.txt');
inputArray = textscan(fid,'%s');
fclose(fid);

%% Calculate result for part 1
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
        where0 = strfind(inputArray(i),'0');
    else
        address = str2double(regexp(inputArray(i),'\d*','Match'));
        i = i+1;
        binary = dec2bin(double(inputArray(i)),bits);
        binary(where1) = '1';
        binary(where0) = '0';
        mem(address) = bin2dec(binary);
        % fprintf("Value %d (from %d) written to %d\n",bin2dec(binary),double(inputArray(i)),address);
    end
    i = i+1;
end
part1 = sum(cell2mat(values(mem)))
toc