%% Import data
clear
clc

fid = fopen('input.txt');
inputArray= textscan(fid,'%c%f');
fclose(fid);

%% Calculate result for part 1
tic
pos = [0;0]; %E+ W- / N+ S-
a = 90;

for i = 1:length(inputArray{1})
    action = inputArray{1}(i);
    value = inputArray{2}(i);
    
    switch action
        case 'F'
            pos = pos + [((a == 90) - (a == 270))*value;
                         ((a == 0) - (a == 180))*value];
        case {'N','S','E','W'}
            pos = pos + [((action == 'E') - (action == 'W'))*value;
                         ((action == 'N') - (action == 'S'))*value];
        case {'L','R'}  
            a = mod(a + ((action == 'R') - (action == 'L'))*value,360);
    end
end
part1 = sum(abs(pos))
toc