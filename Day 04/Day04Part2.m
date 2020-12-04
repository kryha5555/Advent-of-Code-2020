%% Import data
clear
clc

inputArray ={};

fid = fopen('input.txt');
inputArray{end+1} = textscan(fgetl(fid),'%s%s%s%s%s%s%s');

while ~feof(fid)
    tline = fgetl(fid);
    
    if isempty(tline)
        inputArray{end+1} = char([]);
    else
        inputArray{end+1} =textscan(tline,'%s%s%s%s%s%s%s%s');
    end
end
inputArray{end+1} = char([]);
fclose(fid);

%% Calculate result for part 2
tic
fields = ["byr";"iyr";"eyr";"hgt";"hcl";"ecl";"pid"];
eyeColors = ["amb";"blu";"brn";"gry";"grn";"hzl";"oth"];
validFieldCount = 0;
validPassports = 0;

for i = 1:length(inputArray)
    if isempty(inputArray{i}) % end of i-th passport
        if validFieldCount == 7 % all fields are valid
            validPassports = validPassports+1; % found valid passport
        end
        validFieldCount=0;
    else
        for j = 1:length(inputArray{i}) % for each possible field
            if ~isempty(inputArray{i}{j}) % if field is not empty
                field =  textscan(string(inputArray{i}{j}),'%s%s','Delimiter',':');
                value = cell2mat(field{2});
                
                switch string(field(1))
                    case fields(1)
                        value = str2double(value);
                        if value>=1920 && value <=2002
                            validFieldCount = validFieldCount+1;
                        end
                        
                    case fields(2)
                        value = str2double(value);
                        if value>=2010 && value <=2020
                            validFieldCount = validFieldCount+1;
                        end
                        
                    case fields(3)
                        value = str2double(value);
                        if value>=2020 && value <=2030
                            validFieldCount = validFieldCount+1;
                        end
                        
                    case fields(4)
                        height = str2double(value(1:end-2));
                        if strcmp(value(end-1:end),"cm")
                            if height>=150 && height <=193
                                validFieldCount = validFieldCount+1;
                            end
                        else
                            if height>=59 && height <=76
                                validFieldCount = validFieldCount+1;
                            end
                        end
                        
                    case fields(5)
                        if  regexp(value, '#[a-fA-F0-9]{6}')
                            validFieldCount = validFieldCount+1;
                        end
                        
                    case fields(6)
                        if any(contains(eyeColors,value))
                            validFieldCount = validFieldCount+1;
                        end
                        
                    case fields(7)
                        if length(value) == 9
                            validFieldCount = validFieldCount+1;
                        end
                end
            end
        end
    end
end
validPassports
toc