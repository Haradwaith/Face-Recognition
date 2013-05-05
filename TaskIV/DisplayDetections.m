function DisplayDetections(im, dets)
% just a test
I = imread(im);
%I = imresize(I, s);
 
figure(); imagesc(I); axis equal;
detectedFaceNumber = size(dets,1);
 
for i = 1:detectedFaceNumber
 
    y = dets(i, 1)-0.5;
    x = dets(i, 2)-0.5;
    h = dets(i, 3)+0.5;
    w = dets(i, 4);
    rectangle('Position',[x, y, w, h],'EdgeColor', 'r');
end
 
end

