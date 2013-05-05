%% Init

addpath('TaskIII');
addpath('TaskII');
addpath('TaskI');
load('Cparams.mat');
% Fdata = load('FaceData.mat');
% NFdata = load('NonFaceData.mat');
% FTdata = load('FeaturesToUse.mat');

%% One file test

im_fname = 'TrainingImages/FACES/face00001.bmp';
[im, ii_im] = LoadIm(im_fname);
% Apply detector
ApplyDetector(Cparams, ii_im);
dets = ScanImageFixedSize(Cparams,im);
DisplayDetections(im_fname, dets);
colormap gray;
 

%% Program 23 Debug

%% Test ScanImageFixedSize
close all
path = 'TestImages/one_chris.png';
 
% Load the image
[im, ii_im] = LoadIm(path);
 
% % Without pruning
dets = ScanImageFixedSize(Cparams, im);
DisplayDetections(path, dets);

%% Display the detected face with pruning
%fdets = PruneDetections(dets);
%DisplayDetections(path, fdets);
%
%% Test ScanImageOverScale
close all
path = 'TestImages/big_one_chris.png';
[big_im, vig_ii_im] = LoadIm(path);
min_s = 0.6;
max_s = 1.3;
step_s = .06;
Cparams_scale = Cparams;
Cparams_scale.thresh = 8;
dets = ScanImageOverScale(Cparams_scale, big_im, min_s, max_s, step_s);
DisplayDetections(path, dets);
