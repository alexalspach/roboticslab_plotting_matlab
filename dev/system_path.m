clc;
%RLAB_BIN_PATH = getenv('RLAB_BIN_PATH') %rLab bin path environment path
RLAB_BIN_PATH = 'bin' % temporary for development
RLAB_MATLAB_PATH = sprintf('%s%s', RLAB_BIN_PATH, '/MATLAB scripts/')
rlab_plot_script_name = 'rlab_plot.m'
script_path = sprintf('%s%s', RLAB_MATLAB_PATH, rlab_plot_script_name)
run(script_path)



fprintf('Main program was run.\n')