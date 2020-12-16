%% Import data
clear
clc

inputArray = importfile('input.txt');

%% Parse data
tic
fields = [];
fieldNames = [];
tickets = [];

i = 1;
while inputArray(i,1) ~= ""
    fieldNames = [fieldNames; inputArray(i,1)];
    fields = [fields; inputArray(i,2:3), inputArray(i,4:5)];
    i = i+1;
end
fields = str2double(fields);

i = i+2;
ticket = str2double(rmmissing(inputArray(i,:)));

i = i+3;
while i <= size(inputArray,1)
    tickets = [tickets; inputArray(i,:)];
    i = i+1;
end
tickets = str2double((tickets));
tickets = tickets(:,1:size(fields,1));

%% Calculate valid tickets and result for part 1
validTickets = [];
part1 = 0;

for t = 1:size(tickets,1)
    current = tickets(t,:);
    validity = []; % rows -> ticket values, cols -> fields, 1 if valid
    
    for f = 1:size(fields,1)
        validity = [validity; % applies to each value of ticket
                    (current >= fields(f,1) & current <= fields(f,2)) | ...
                    (current >= fields(f,3) & current <= fields(f,4)) ];
    end
    
    if any(sum(validity) == 0) % if some fields are invalid
        part1 = part1 + sum(current(sum(validity) == 0)); % sum values in invalid fields
    else
        validTickets = [validTickets; current]; % mark ticket as valid
    end
end
part1
toc

%% Calculate available fields for each column of tickets
isFieldAvailable = zeros(length(ticket));

for c = 1:size(validTickets,2)
    current = validTickets(:,c);
    
    for f = 1:size(fields,1)
        isFieldAvailable(c,f) = ...
            all((current >= fields(f,1) & current <= fields(f,2)) | ...
                (current >= fields(f,3) & current <= fields(f,4)) );
    end
end

%% Assign columns to fields
fieldAssignments = zeros(size(ticket));
validAssignments = sum(isFieldAvailable,2);

for i = 1:length(isFieldAvailable)
    column = find(validAssignments == i); % from smallest to largest value
    field = find(isFieldAvailable(column,:) == 1); % find only available field 
    isFieldAvailable(column,:) = NaN; % mark column as assigned
    isFieldAvailable(:,field) = NaN; % mark field as assigned
    fieldAssignments(field) = column; % assign column to field
end

%% Calculate result for part 2
part2 = 1;

for i = 1:6 % 6 fields starting with "departure"
    part2 = part2 * ticket(fieldAssignments(i));
end
part2
toc