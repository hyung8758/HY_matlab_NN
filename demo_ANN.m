% demo_DNN
% DNN trial script. 
%                                                             Hyungwon Yang
%                                                             2016. 02. 26
%                                                             EMCS labs
%
% DEMONSTRATION: classification problem with MNIST data.

% Clear command window and workspace.
clear;clc;close all
% Set path.
po()

%% Import data and set parameters.
%%% STEP 1 %%%

% Download data.
download_mnist()

%% Import data.
load mnist_input
load mnist_target

% Transform input data format.
inputData = mnist_input(1:60000,:);
new_target = spreadTarget(mnist_target)';
targetData = new_target(1:60000,:);

training = 'on';
testing = 'off';

% PARAMETER SETTINGS
trainRatio = 85; % Percentage of train data, rest of them for validation.
epochTrain = 'off'; 
fineTrainEpoch = 100;
fineLearningRate = 0.1;
momentum = 0.9;
batchSize = 100;
normalize = 'off';
hiddenLayers = [100];
errorMethod = 'CE'; % MSE / CE
hiddenActivation = 'sigmoid'; % sigmoid / tanh
outputActivation = 'softmax'; % linear / sigmoid / softmax
plotOption = 'on'; % on / off

% pre-training

preTrainEpoch = 0;
preLearningRate = 0.01;


%% Build a network with data and parameters.
%%% STEP 2 %%%

N = Netbuild(inputData, targetData, training, testing,trainRatio,epochTrain,...
                      fineTrainEpoch, fineLearningRate, momentum, batchSize,...
                      normalize, hiddenLayers, errorMethod, hiddenActivation,...
                      outputActivation, plotOption, preTrainEpoch, preLearningRate);
                  
%% Train the network.
%%% STEP 3 %%%

N_updated = DNN(N);

%% Test the trained model.
%%% STEP 4 %%%
inputData = mnist_input(60001:end,:);
targetData = new_target(60001:end,:);
N_updated.inputData = inputData;
N_updated.targetData = targetData;
N_updated.training = 'off';
N_updated.testing = 'on';

DNN(N_updated);

