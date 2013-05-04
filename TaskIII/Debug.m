% Debug file

% Program 20
Cparams = load('Cparams.mat');
Cparams = Cparams.Cparams;
Fdata = load('FaceData.mat');
NFdata = load('NonFaceData.mat');
FTdata = load('FeaturesToUse.mat');


% % ----------------------------------
% % Program 20 Debug
% % ----------------------------------
[im, ii_im] = LoadIm('TrainingImages/FACES/face00001.bmp');
sc = ApplyDetector(Cparams, ii_im);
assert(sc - 9.1409 < 1e-4, 'Problem with ApplyDetector');


% ----------------------------------
% Program 21 Debug
% ----------------------------------

thresh = ComputeROC(Cparams,Fdata,NFdata);

Cparams.thresh = thresh;

save(name, 'Cparams');
