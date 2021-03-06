%% Init debug file
addpath('TaskI/');

% Load the files of Taks I into Matlab
Fdata = load('FaceData.mat');
NFdata = load('NonFaceData.mat');
FTdata = load('FeaturesToUse.mat');

%% ----------------------------------
%% Program 16 Debug
%% ----------------------------------

% Get the feature type
f = FTdata.fmat(:,12028);

% Get the VectorFeatures from the Face data.
fsp = VecComputeFeature( Fdata.ii_ims, f);

% Get the VectorFeatures from the None Face data.
fsn = VecComputeFeature( NFdata.ii_ims, f);

% ....................
% Inputs
% ....................
% Define parameters
m = length(fsn);
n = length(fsp);

% Define fs
fs = [fsp;fsn];

% Correct + incorrect.
ys = [ones(n,1);zeros(m,1)];

% Create the weights (according to alg 2)
ws = ones(n+m,1)/(n+m);

% Call LearnWeakClassifier
[theta,p,err]=LearnWeakClassifier(ws,fs,ys);
assert(theta - (-3.6453) < 10e-4 && p == 1, 'Error in  LearnWeakClassifier');

% ....................
% Get the histograms
% ....................
% hist face 
[h1,x1] = hist(fsp,10);
h1 = h1/sum(h1);
plot(x1,h1,'-r');
hold on;
plot(x1,h1,'.r');

% hist non face
[h2,x2] = hist(fsn,10);
h2 = h2/sum(h2);
plot(x2,h2,'-b');
plot(x2,h2,'.b');
line([theta theta], [0 0.40],'Color','black')
% labels
legend('Face','','NonFace','','Theta');

%% ----------------------------------
%% Program 17 Debug
%% ----------------------------------
close all;
figure()
for i = 1:4
    subplot(2,2,i);
    fpic = MakeFeaturePic([i, 5, 5, 5, 5], 19, 19);
    imagesc(fpic); axis equal; axis off; colormap gray;
end


%% ----------------------------------
%% Program 18 Debug
%% ----------------------------------
close all
figure()
cpic = MakeClassifierPic(FTdata.all_ftypes, [5192, 12765], [1.8725,1.467], [1,-1], 19, 19);
imagesc(cpic); axis equal; axis off; colormap gray;


%% ----------------------------------
%% Program 19 Debug 1
%% ----------------------------------

% Create a subset of only 1,000 (1k) features.
FTdata_1k = FTdata;
FTdata_1k.all_ftypes = FTdata_1k.all_ftypes(1:1000,:);
FTdata_1k.fmat = FTdata_1k.fmat(:,1:1000);
eps = 1e-6;

dinfo6 = load('DebugInfo/debuginfo6.mat');
T = dinfo6.T;
Cparams = BoostingAlg(Fdata, NFdata, FTdata_1k, T);
s1 = sum(abs(dinfo6.alphas - Cparams.alphas')>eps)
s2 = sum(abs(dinfo6.Thetas(:)  - Cparams.Thetas(:))>eps)
assert(s1 == 0 && s2 == 0, 'Problem in BostingAlg');

% Graph the features 
f1 = FTdata.all_ftypes(Cparams.Thetas(1,1),:);
f2 = FTdata.all_ftypes(Cparams.Thetas(2,1),:);
f3 = FTdata.all_ftypes(Cparams.Thetas(3,1),:);

% Compute the feature pics.
fpic1 = MakeFeaturePic(f1,FTdata.W,FTdata.H);
fpic2 = MakeFeaturePic(f2,FTdata.W,FTdata.H);
fpic3 = MakeFeaturePic(f3,FTdata.W,FTdata.H);

% Compute the final classifier pic.
fpic = MakeClassifierPic(FTdata.all_ftypes,Cparams.Thetas(:,1),Cparams.alphas,Cparams.Thetas(:,3)',FTdata.W,FTdata.H);

% Diplay the images
montage({fpic1,fpic2,fpic3,fpic},'Size',[1 4])

%% ----------------------------------
%% Program 19 Debug 2
%% ----------------------------------
dinfo7 = load('DebugInfo/debuginfo7.mat');
eps = 1e-6;
T = dinfo7.T;
Cparams = BoostingAlg(Fdata, NFdata, FTdata, T);
s1 = sum(abs(dinfo7.alphas - Cparams.alphas')>eps);
s2 = sum(abs(dinfo7.Thetas(:)  - Cparams.Thetas(:))>eps);
assert(s1 == 0 && s2 == 0, 'Problem in BostingAlg');

fs = struct('pics',zeros(T+1,FTdata.W,FTdata.H));
for t= 1:T
    % Compute the feature pics.
    fs.pics(t,:,:) = MakeFeaturePic(FTdata.all_ftypes(Cparams.Thetas(t,1),:),FTdata.W,FTdata.H);
end

% Compute the final classifier pic.
fs.pics(T+1,:,:) = MakeClassifierPic(FTdata.all_ftypes,Cparams.Thetas(:,1),Cparams.alphas,Cparams.Thetas(:,3)',FTdata.W,FTdata.H);


% Diplay the images
a = [];
for i= 1:(T+1)
    a = [a,reshape(fs.pics(i,:,:),FTdata.W,FTdata.H)];
    % Individual images
    %figure();imagesc( reshape(fs.pics(i,:,:),FTdata.W,FTdata.H)); colormap gray;
end
montage(a)

% Save the data
name = 'Cparams.mat';
save(name, 'Cparams');


