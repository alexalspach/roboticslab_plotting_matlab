roboticslab_plotting_matlab
===========================

Development of MATLAB plotting interfaces for RoboticsLab

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