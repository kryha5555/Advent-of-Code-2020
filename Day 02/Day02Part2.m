%% Import data
clear
clc

fid = fopen('input.txt');
inputArray= textscan(fid,'%f%*c%f%c%*c%s');
fclose(fid);

%% Calculate result for part 2
tic
valid=0;

for i=1:length(inputArray{1})
    minOcc = inputArray{1}(i);
    maxOcc = inputArray{2}(i);
    character = inputArray{3}(i);
    password = inputArray{4}{i};
    
    if xor(password(minOcc)==character, password(maxOcc)==character)
        valid = valid+1;
    end
end

valid
toc