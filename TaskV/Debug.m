%% Debug file
addpath('TaskI/');
addpath('TaskII/');
addpath('TaskIII/');
addpath('TaskIV/');

% Load the files of Taks I into Matlab
Fdata = load('FaceData.mat');
NFdata = load('NonFaceData.mat');
FTdata = load('FeaturesToUse.mat');

%%

T = 100;
Cparams = BoostingAlg(Fdata, NFdata, FTdata, T);

%%

thresh = ComputeROC(Cparams, Fdata, NFdata);

%%

big_path = 'TestImages/big_one_chris.png';
[big_im, vig_ii_im] = LoadIm(big_path);
min_s = 0.6;
max_s = 1.3;
step_s = .06;
Cparams_scale = Cparams;
Cparams_scale.thresh = 8;
dets = ScanImageOverScale(Cparams_scale, big_im, min_s, max_s, step_s);
DisplayDetections(big_path, dets);

%%

close all
path = 'TestImages/one_chris.png';
 
% Load the image
[im, ii_im] = LoadIm(path);
 
% % Without pruning
Cparams.thresh = 28.2;
dets = ScanImageFixedSize(Cparams, im);
DisplayDetections(path, dets);