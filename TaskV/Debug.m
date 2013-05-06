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
CparamsV = BoostingAlg(Fdata, NFdata, FTdata, T);

%%

ParamsV = load('TaskV');
CparamsV.thresh = ComputeROC(ParamsV.Cparams, Fdata, NFdata);
%save('TaskV', 'CparamsV')

%% Test on Chris

path = 'TestImages/one_chris.png';
ParamsV = load('TaskV');
ParamsV.Cparams.thresh = 30;
min_s = 0.9;
max_s = 1.1;
step_s = .1;
 
% Load the image
[im, ii_im] = LoadIm(path);

dets = ScanImageOverScale(ParamsV.Cparams, im, min_s, max_s, step_s);
DisplayDetections(path, dets);

%% Test on TestImages

dirname = 'TestImages/';
test_list = dir(dirname);
aa = 3:length(test_list);
min_s = 0.7;
max_s = 0.7;
step_s = .1;

for i = aa
    im_fname = [dirname, test_list(i).name]
    [test_im, test_ii_im] = LoadIm(im_fname);
    dets = ScanImageOverScale(ParamsV.Cparams, test_im, min_s, max_s, step_s);
    DisplayDetections(im_fname, dets);
end