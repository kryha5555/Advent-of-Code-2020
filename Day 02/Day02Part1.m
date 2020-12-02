clear
clc

fid = fopen('input.txt');
inputArray= textscan(fid,'%f%*c%f%c%*c%s');
fclose(fid);

tic
valid=0;

for i=1:length(inputArray{1})
    minOcc = inputArray{1}(i);
    maxOcc = inputArray{2}(i);
    character = inputArray{3}(i);
    password = inputArray{4}{i};
    
    occurences = length(strfind(password,character));
    if occurences>= minOcc && occurences <=maxOcc
        valid = valid+1;
    end
end

valid
toc