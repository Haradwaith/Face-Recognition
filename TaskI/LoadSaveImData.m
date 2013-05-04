function LoadSaveImData(dirname, ni, im_sfn)
face_fnames = dir(dirname);
aa = 3:length(face_fnames);
a = randperm(length(aa));
fnums = aa(a(1:ni));

%Load data
for i = 1:ni
    im_fname = [dirname, face_fnames(fnums(i)).name];
    [~, ii_im] = LoadIm(im_fname);
    if i == 1
        ii_ims = zeros(ni,size(ii_im,1)*size(ii_im,2));
    end
    ii_ims(i,:)= ii_im(:);
end

% Save data
save(im_sfn, 'dirname', 'fnums', 'ii_ims');

end