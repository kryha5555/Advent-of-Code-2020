function input = importfile(filename, dataLines)
%IMPORTFILE Import data from a text file
%  INPUT = IMPORTFILE(FILENAME) reads data from text file FILENAME for
%  the default selection.  Returns the data as a string array.
%
%  INPUT = IMPORTFILE(FILE, DATALINES) reads data for the specified row
%  interval(s) of text file FILENAME. Specify DATALINES as a positive
%  scalar integer or a N-by-2 array of positive scalar integers for
%  dis-contiguous row intervals.
%
%  Example:
%  input = importfile("D:\Git\Advent-of-Code-2020\Day 18\input.txt", [1, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 18-Dec-2020 13:21:25

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [1, Inf];
end

%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 1);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = "VarName1";
opts.VariableTypes = "string";
opts = setvaropts(opts, 1, "WhitespaceRule", "preserve");
opts = setvaropts(opts, 1, "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
input = readtable(filename, opts);

%% Convert to output type
input = table2array(input);
end