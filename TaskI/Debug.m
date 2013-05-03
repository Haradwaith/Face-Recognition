%% LoadIm debug 2.1
dinfo1 = load('DebugInfo/debuginfo1.mat');
[im ii_im] = LoadIm('TrainingImages/FACES/face00001.bmp');
eps = 1e-6;
s1 = sum(abs(dinfo1.im(:) - im(:)) > eps);
s2 = sum(abs(dinfo1.ii_im(:) - ii_im(:)) > eps);
assert(s1 == 0, 'Problem with image normalisation in LoadIm')
assert(s2 == 0, 'Problem with integral image in LoadIm')

% Debug 2.2
x = 1;
y = 1;
h = 5;
w = 7;
eps = 1e-6;
s1 = (sum(sum(im(y:y+h-1, x:x+w-1))) - ComputeBoxSum(ii_im, x, y, w, h)) > eps;
assert(s1 == 0, 'Problem in ComputeBoxSum')

%% Feature computation 2.3
dinfo2 = load('DebugInfo/debuginfo2.mat');
x = dinfo2.x; y = dinfo2.y; w = dinfo2.w; h = dinfo2.h;

s1 = abs(dinfo2.f1 - FeatureTypeI(ii_im, x, y, w, h)) > eps;
assert(s1 == 0, 'Problem in FeatureTypeI')
s1 = abs(dinfo2.f2 - FeatureTypeII(ii_im, x, y, w, h)) > eps;
assert(s1 == 0, 'Problem in FeatureTypeII')
s1 = abs(dinfo2.f3 - FeatureTypeIII(ii_im, x, y, w, h)) > eps;
assert(s1 == 0, 'Problem in FeatureTypeIII')
s1 = abs(dinfo2.f4 - FeatureTypeIV(ii_im, x, y, w, h)) > eps;
assert(s1 == 0, 'Problem in FeatureTypeIV')

%% Debug 2.3

DirName = 'TrainingImages/FACES/';
format = 'bmp';
mystr = [DirName,'/*.',format];
im_files = dir(mystr);
addpath(DirName);
eps = 1e-6;

for i = 1:100
    [im, ii_im] = LoadIm(im_files(i).name);
    if i ==1
        ii_ims = zeros(100,size(ii_im,1), size(ii_im,2));
    end
    % store each ii_im
    ii_ims(i,:,:)= ii_im;
end
dinfo3 = load('DebugInfo/debuginfo3.mat');
ftype = dinfo3.ftype;
s1 = sum(abs(dinfo3.fs - ComputeFeature(ii_ims, ftype)) > eps);
assert(s1 == 0, 'Problem in ComputeFeature')

%% VecBoxSum sanity check

x = 2; y = 2; w = 4; h = 2;
b_vec = VecBoxSum(x, y, w, h, 19, 19);
A1 = ii_im(:)' * b_vec;
A2 = ComputeBoxSum(ii_im, x, y, w, h);
assert(A1 - A2 < eps, 'Problem in VecBoxSum')

%% VecFeature sanity check

[im ii_im] = LoadIm('TrainingImages/FACES/face00001.bmp');
x = 2; y = 5; w = 4; h = 1;
ftype_vec = VecFeature([1, x, y, w, h], 19, 19);
A1 = ii_im(:)'*ftype_vec;
A2 = FeatureTypeIV(ii_im,x,y,w,h);
assert(A1 - A2 < eps, 'Problem in VecFeature')

%% VecComputeFeature sanity check

DirName = 'TrainingImages/FACES/';
format = 'bmp';
mystr = [DirName,'/*.',format];
im_files = dir(mystr);
addpath(DirName);
eps = 1e-6;
W = 0;
H = 0;
for i = 1:100
    [im, ii_im] = LoadIm(im_files(i).name);
    if i ==1
        W = size(ii_im,1);
        H = size(ii_im,2);
        ii_ims = zeros(100,size(ii_im,1), size(ii_im,2));
    end
    ii_ims(i,:,:)= ii_im;
end
all_ftypes = EnumAllFeatures(W,H);
fmat = VecAllFeatures(all_ftypes,W,H);
fs1 = VecComputeFeature(ii_ims, fmat(:,1));
fs2 = ComputeFeature(ii_ims, all_ftypes(1,:));
assert(sum(abs(fs1-fs2')> eps) == 0, 'Problem in VecComputeFeature')

%% LoadSaveImData sanity check

LoadSaveImData('TrainingImages/FACES/', 100, 'FaceData.mat');

%%
% % -------------------------------------------
% % Debug 2.5 - Prgm 14
% % -------------------------------------------
% all_ftypes = [];
% all_ftypes = [all_ftypes;EnumAllFeatures(19,19,1)];
% all_ftypes = [all_ftypes;EnumAllFeatures(19,19,2)];
% all_ftypes = [all_ftypes;EnumAllFeatures(19,19,3)];
% all_ftypes = [all_ftypes;EnumAllFeatures(19,19,4)];
% ComputeSaveFData(all_ftypes,'FeaturesToMat.mat');
% 
% % -------------------------------------------
% % Debug 2.5 - Checking for Pgrm 13 & 14
% % -------------------------------------------
% dinfo4 = load('../DebugInfo/debuginfo4.mat'); 
% ni = dinfo4.ni;
% all_ftypes = dinfo4.all_ftypes;
% im_sfn = 'FaceData.mat';
% f_sfn = 'FeaturesToMat.mat';
% rng(dinfo4.jseed);
% dirname = '../TrainingImages/FACES/';
% LoadSaveImData(dirname, ni, im_sfn); 
% ComputeSaveFData(all_ftypes, f_sfn);
% % compare that the fmat and dinfo4.fmat are the same
% min = load('FeaturesToMat.mat');
% sum(sum(abs(dinfo4.fmat-min.fmat)>eps))
% % Compare that ii_ims and dinfo4.ii_ims are the same
% min2 = load('FaceData.mat');
% sum(sum(abs(dinfo4.ii_ims-min2.ii_ims)>eps))

% -------------------------------------------
% Debug 2.5 - Checking all
% -------------------------------------------
dinfo5 = load('DebugInfo/debuginfo5.mat'); 
np = dinfo5.np;
nn = dinfo5.nn;
all_ftypes = dinfo5.all_ftypes;
rng(dinfo5.jseed);
GetTrainingData(all_ftypes,np,nn);
% Load the files into Matlab
Fdata = load('FaceData.mat');
NFdata = load('NonFaceData.mat');
FTdata = load('FeaturesToUse.mat');
