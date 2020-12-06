%% Import data
clear
clc

inputArray ={};

fid = fopen('input.txt');
inputArray{end+1} = fgetl(fid);

while ~feof(fid)
    inputArray{end+1} = fgetl(fid);
end

inputArray{end+1} = char([]);

fclose(fid);

%% Calculate result for both parts
tic
anyone = [];
everyone = 'a':'z';
part1 = 0;
part2 = 0;

for i = 1:length(inputArray)
    if isempty(inputArray{i})
        part1 = part1 + length(anyone);
        part2 = part2 + length(everyone);
        anyone = [];
        everyone = 'a':'z';       
    else
        anyone = union(anyone,inputArray{i});
        everyone = intersect(everyone,inputArray{i});
    end
end
part1
part2
toc