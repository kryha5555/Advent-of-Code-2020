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

%% Calculate result for part 1
tic
fields = ["byr";"iyr";"eyr";"hgt";"hcl";"ecl";"pid"];
fieldCount=0;
validPassports = 0;

for i = 1:length(inputArray)
    if isempty(inputArray{i}) % end of i-th passport
        if fieldCount == 7
            validPassports = validPassports + 1;
        end
        fieldCount = 0;
        
    else
        for j = 1:size(fields)
            fieldCount = fieldCount + contains(inputArray{i},fields(j));
        end
    end
    
end
validPassports
toc