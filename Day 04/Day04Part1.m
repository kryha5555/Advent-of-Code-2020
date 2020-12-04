clear
clc

A ={};
fid = fopen('input.txt');
req = ["byr";"iyr";"eyr";"hgt";"hcl";"ecl";"pid"];
tline = fgetl(fid);
A{end+1} = tline;

while ~feof(fid)
    tline = fgetl(fid);
    A{end+1} = tline;
end
fclose(fid);
A{end+1} = char([]);

A = A';
ctr=0;
count = 0;

for i = 1:size(A)
    if A{i} == ""
        if ctr == 7
            count = count + 1;
        end
        ctr = 0;
        
    else
        for j = 1:size(req)
            ctr = ctr + contains(A{i},req(j));
        end
    end
    
end
count


