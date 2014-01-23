%
%% RoboticsLab Data Plotting
%
% [fileData, filePaths, numberOfPlots] = roboticslab_data_plotting(filePaths)
%
% This function can be used to create a MATLAB plot of tab-delimited textfile
% data exported using RoboticsLab's data acquisition function.
% This script can be run with or without an input argument of filepaths in
% the format shown below. Without arguments, a GUI dialog window will allow
% the user to select multiple files for plotting.
%
%
% Multiple file paths can be input or selected for plotting.
% The paths can be absolute or relative to the path of the script as shown below.
%
%
% filePaths{1} = 'C:\Users\Alex\Documents\MATLAB\RoboticsLab\test_data\Encoders.txt'
% filePaths{2} = 'test_data\Encoders.txt'
% [fileData, filePaths, numberOfPlots] = roboticslab_data_plotting(filePaths);
%
%
% If no input arguments are used, the user will be prompted to select the 
% files of interest using the familiar 'Open' dialog box. Multiple files can
% be selected at once.
%
% Author: Alex Alspach (alexalspach@simlab.co.kr)
% Copyright 2014 - SimLab Co., Ltd.

%%
function [fileData, filePaths, numberOfPlots] = roboticslab_data_plotting(filePaths)

% Clear text from screen and close all open figures
clc
close all

% Flag to note whether or not paths were input as function arguments
argsUsed = false;

% Info for parsing RoboticsLab data output files
tabDelimited = '\t';    %tab delimited
headerLines = 1;        %header is one line

% Checks if variable 'filePaths' already exists i.e. was input by the user
% as an argument of the function. If this doesnt already exist, the user
% will be prompted to select the files of interest using the familiar
% 'Open' dialog box. Multiple files can be selected at once.
if exist('filePaths')
    % number of plots to be created equals the number of data files input
    numberOfPlots = length(filePaths);
    argsUsed = true;
else
    % Calls GUI 'Open' dialog box. Multiple files can be selected at once.
    [fileName,pathName,~] = uigetfile({'*.txt';'*.*'},'Select RoboticsLab output files to plot','MultiSelect', 'on');
    
    % Determines how many files were selcted using the 'Open' dialog box
    % 'fileName' is a string only if one file is selected,
    % 'fileName' is a cell structure if multiple files are selected
    if (iscell(fileName))
        numberOfPlots = length(fileName);
        % Creates cell structure for filePaths
        filePaths = cell(numberOfPlots,1);
        for i=1:numberOfPlots
            filePaths{i} = strcat(pathName,fileName{i});
        end
    elseif (fileName ~= 0)
        numberOfPlots = 1;
        % Creates cell structure for filePaths (though there is only one)
        filePaths = cell(1,1);
        filePaths{1} = strcat(pathName,fileName);
    else
        % If no data files are input or selected
        numberOfPlots = 0;
        
        %help roboticslab_data_plotting
        
        fprintf('Please use ''help roboticslab_data_plotting''\nfor brief instructions on how to use this script\n');
        error('No Data files were selected.');
       
    end
end

% If at least one data file is input or selected, data is processed
if numberOfPlots > 0
    
    % One iteration for each data file input
    for i=1:numberOfPlots
        
        % Import data file and spits it up into header and data variables
        fileData = importdata(filePaths{i},tabDelimited,headerLines)
        
        % Determine the number variables (columns) to be plotted
        numberOfLines = size(fileData.data,2)-1;
        
        % Plot all data agaist time in file
        figure(i)
        plot(fileData.data(:,1),fileData.data(:,2:end))
        
        % Set plot title
        % Parses fileName or filePaths strings to determine plot title
        title_font_size = 16;
        filename_extension_length = 4; %including period e.g. '.txt'
        % (1:end-filename_extension_length) removes the last four chars
        if(argsUsed)
            title_temp = textscan(filePaths{i}, '%s', 'delimiter', '\\');
            title_temp = title_temp{1}{end};
            title_temp = title_temp(1:end-filename_extension_length)
            title(title_temp,'FontSize',title_font_size)
        else
            if (iscell(fileName))
                title(fileName{i}(1:end-filename_extension_length),'FontSize',title_font_size)
            else
                title(fileName(1:end-filename_extension_length),'FontSize',title_font_size)
            end
        end
        
        % Legend
        % Parses data header to get variable names for legend
        legendEntries = textscan(fileData.textdata{1}, '%s', 'delimiter', '\t');
        legendEntries{1}(1) = [];
        legend(legendEntries{1},  'interpreter', 'none');
        
        % Time
        xlabel('Time (s)');
        
        % Axis
        axis auto
        grid on
        
        
    end
    
    fprintf('\nPlease use MATLAB''s Plot Tools to edit and save your plot.\n\n')
    
end

end