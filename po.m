% po: Path Organizer
%                                                             Hyungwon Yang
%                                                             2016. 03. 23
%                                                             EMCS labs
%
% po(Path Organizer) sets all directory paths so as to activate DNN function
% properly.
% DO NOT MOVE this function to any other folders.

function po()

% Check Directories.
directory = dir(pwd);
allNames = {directory.name};
functionDir = 0;
datasetDir = 0;
for check = 1:length(allNames)
    if strcmp(allNames{check},'functions')
        functionDir = 1;
    elseif strcmp(allNames{check},'datasets')
        datasetDir = 1;
    end
end

if functionDir == 0;
    error(['Fatal! functions directory is missing. Revisit the website: '...
        'https://github.com/hyung8758/HY_matlab_NN.git and redownload the toolbox.'])
end
if datasetDir == 0;
    warning(['Datasets directory is missing. Revisit the website: '...
        'https://github.com/hyung8758/HY_matlab_NN.git and redownload the toolbox.'])
end

% Path setting.
MAIN_PATH = pwd;
addpath(genpath(MAIN_PATH))
assignin('base','MAIN_PATH',MAIN_PATH)

