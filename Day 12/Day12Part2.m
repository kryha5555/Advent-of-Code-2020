%% Import data
clear
clc

fid = fopen('input.txt');
inputArray= textscan(fid,'%c%f');
fclose(fid);

%% Calculate result for part 2
tic
pos = [0;0]; %E+ W- / N+ S-
velocity = [10;1]; %E+ W- / N+ S-

for i = 1:length(inputArray{1})
    action = inputArray{1}(i);
    value = inputArray{2}(i);
    
    switch action
        case 'F'
            pos = pos + velocity*value;
        case {'N','S','E','W'}
            velocity = velocity + [((action == 'E') - (action == 'W'))*value;
                                   ((action == 'N') - (action == 'S'))*value];
        case {'L','R'}
            a = deg2rad(value);
            rotM = [cos(a) ((action == 'R') - (action == 'L'))*sin(a);
                    ((action == 'L') - (action == 'R'))*sin(a) cos(a)];
            velocity = rotM*velocity;
    end
end
part2 = sum(abs(pos))
toc