function dets = ScanImageOverScale(Cparams, im, min_s, max_s, step_s)

if size(im,3) == 3
    im = im(:,:,1) + im(:,:,2) + im(:,:, 3);
end

dets = [];

for s = min_s:step_s:max_s

    scaled_im = imresize(im, s);
    s_dets = ScanImageFixedSize(Cparams, scaled_im);
    %s_fdets = PruneDetections(s_dets);

    s_dets(:,:) = round(s_dets(:,:) / sqrt(s));

    dets = [dets; s_dets];

end

end
