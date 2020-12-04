clear
clc

A ={};
fid = fopen('input.txt');
req = ["byr";"iyr";"eyr";"hgt";"hcl";"ecl";"pid"];
ecl = ["amb";"blu";"brn";"gry";"grn";"hzl";"oth"];
tline = fgetl(fid);
A{end+1} = textscan(tline,'%s%s%s%s%s%s%s');

while ~feof(fid)
    tline = fgetl(fid);
    %     A{end+1} = tline;
    if length(tline)
        A{end+1} =textscan(tline,'%s%s%s%s%s%s%s%s');
    else
        A{end+1} = char([]);
    end
    
end
fclose(fid);
A{end+1} = char([]);

A = A';
valid = 0;
output = 0;
for i = 1:length(A)
    %     size(A{i})
    if isempty(A{i})
%         disp("NEW ONE")
        if valid == 7
            output = output+1;
        end
        valid=0;
    else
        
        for j = 1:length(A{i})
            if A{i}{j} ~= ""
                x =  textscan(string(A{i}{j}),'%s%s','Delimiter',':');
                switch string(x(1))
                    case req(1)
                        y = double(string((x(2))));
                        if y>=1920 && y <=2002
                            valid = valid+1;
                        end
                    case req(2)
                        y = double(string((x(2))));
                        if y>=2010 && y <=2020
                            valid = valid+1;
                        end
                    case req(3)
                        y = double(string((x(2))));
                        if y>=2020 && y <=2030
                            valid = valid+1;
                        end
                    case req(4)
                        y = char(string((x(2))));
                        z = str2double(y(1:end-2));
                        if y(end-1:end) == 'cm'
                            if z>=150 && z <=193
                                valid = valid+1;
                            end
                        else
                            if z>=59 && z <=76
                                valid = valid+1;
                            end
                        end
                    case req(5)
                        y = char(string((x(2))));
                        if  regexp(y, '#[a-fA-F0-9]{6}')
%                          if y(1) == '#' && length(y)==7 && sum(isstrprop(y(2:end),'xdigit'))==6
                           valid = valid+1;
                        end
                    case req(6)
                        y = char(string((x(2))));
                        if sum(contains(ecl,y)) == 1
                            valid = valid+1;
                        end
                    case req(7)
                        y = char(string((x(2))));
                        if length(y) == 9
                            valid = valid+1;
                        end
                end
            end
        end
    end
end
output