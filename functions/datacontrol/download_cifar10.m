% download_cifar10
%                                                             Hyungwon Yang
%                                                             2016. 06. 14
%                                                             EMCS labs
%
% download_cifar10 saves CIFAR10 data to the datasets folder and adjusts it
% to a trainable format.

function download_cifar10()

% Find the folder.
fprintf('CIFAR10 will be saved in the datasets folder.\n')
try
    MAIN_PATH = evalin('base','MAIN_PATH');
    cd(MAIN_PATH)
catch
    error('Run po first.')
end
cd datasets

%% CIFAR-10
% Download and save the datasets. 
fprintf('Downloading CIFAR10 datasets... (184MB)\n')
cifar10_data_address = 'https://www.cs.toronto.edu/~kriz/cifar-10-matlab.tar.gz';
save_cifar10 = websave('cifar-10-data',cifar10_data_address);
untar(save_cifar10);

% Adjust the datasets.
fprintf('Formattig and saving the CIFAR10 datasets.\n')
cd cifar-10-batches-mat

cifar10_input =[];
cifar10_target =[];
for batch = 1:5
    load(['data_batch_' num2str(batch) '.mat'])
    cifar10_input = [cifar10_input;data];
    cifar10_target = [cifar10_target;labels];
end
load test_batch.mat
cifar10_input = [cifar10_input;data];
cifar10_target = [cifar10_target;labels];

cifar10_input = double(cifar10_input); 
cifar10_target = double(cifar10_target);

% save the datasets.
cd ../
save('cifar10_input','cifar10_input')
save('cifar10_target','cifar10_target')

% Remove files excepts datasets.
warning off
delete('cifar-10*')
rmdir('cifar-10*','s')
cd(MAIN_PATH)
fprintf('CIFAR10 data is downloaded successfully.\n')