%% Import data
clear
clc

fid = fopen('input.txt');
inputArray= textscan(fid,'%s');
fclose(fid);

%% Rearrange data
tic
timestamp = str2double(inputArray{1}{1});
buses = str2double(regexp(inputArray{1}{2},'\d*','Match'));

%% Calculate result for part 1
[m,idx] = min(arrayfun(@(bus) bus - mod(timestamp,bus), buses));
part1 = buses(idx)*m
toc

%% Calculate result for part 2
departures = find(str2double(regexp(strrep( ...
    inputArray{1}{2},'x','0'),'\d*','Match')))-1;

rems = rem(buses - departures,buses) - buses;
N = prod(buses) ./ buses;
[~,M] = gcd(N,buses);
part2 = mod(sum(rems .* N .* M), prod(buses))
toc