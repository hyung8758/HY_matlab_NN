% download_cifar10
%                                                             Hyungwon Yang
%                                                             2016. 06. 14
%                                                             EMCS labs
%
% download_mnist saves MNIST data to the datasets folder and adjusts it
% to a trainable format.

function download_mnist()

% Find the folder.
fprintf('MNIST will be saved in the datasets folder.\n')
try
    MAIN_PATH = evalin('base','MAIN_PATH');
    cd(MAIN_PATH)
catch
    error('Run po first.')
end
cd datasets

%% MNIST
% Download and save the datasets.
fprintf('Downloading MNIST datasets... (12MB)\n')
mnist_data_address = {'http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz',
    'http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz',
    'http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz',
    'http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz'};

save_mnist{1} = websave('train-images-idx3-ubyte',mnist_data_address{1});
save_mnist{2} = websave('train-labels-idx1-ubyte',mnist_data_address{2});
save_mnist{3} = websave('t10k-images-idx3-ubyte',mnist_data_address{3});
save_mnist{4} = websave('t10k-labels-idx1-ubyte',mnist_data_address{4});

% Check the train dataset was downloaded completely.
try 
    gunzip('*.gz')
catch
    error('Data download failed. Please check your internet connection and try again.')
end

% Adjust the datasets.
% Train dataset.
fprintf('Formattig and saving the MNIST datasets.\n')
train_file = {'train-images-idx3-ubyte','t10k-images-idx3-ubyte'};
mnist_input = [];

for file = 1:2
    fp = fopen(train_file{file}, 'rb');
    
    magic = fread(fp, 1, 'int32', 0, 'ieee-be');
    
    numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
    numRows   = fread(fp, 1, 'int32', 0, 'ieee-be');
    numCols   = fread(fp, 1, 'int32', 0, 'ieee-be');
    
    images    = fread(fp, inf, 'unsigned char');
    images    = reshape(images, numCols * numRows, numImages);
    
    images    = double(images)' / 255;
    fclose(fp);
    mnist_input = [mnist_input;images];
end


% Test dataset.
test_file = {'train-labels-idx1-ubyte','t10k-labels-idx1-ubyte'};
mnist_target = [];

for file = 1:2
    fp = fopen(test_file{file}, 'rb');
    
    magic = fread(fp, 1, 'int32', 0, 'ieee-be');
    
    numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');
    
    labels = fread(fp, inf, 'unsigned char');
    
    assert(size(labels,1) == numLabels, 'Mismatch in label count');
    
    fclose(fp);
    mnist_target = [mnist_target;labels];
end

% Save the datasets.
save('mnist_input','mnist_input')
save('mnist_target','mnist_target')
delete('*ubyte*')
cd(MAIN_PATH)
fprintf('MNIST data is downloaded successfully.\n')

