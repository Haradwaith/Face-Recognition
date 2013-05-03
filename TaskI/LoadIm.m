function [im, ii_im]= LoadIm(im_fname)
%Read the image    
im = double(imread(im_fname));

%Image normalization
mu = mean(im(:));
sigma = std(im(:));
if (sigma~=0)
    im = (im-mu)/sigma;
end

%Compute the integral image
ii_im = cumsum(cumsum(im,2));

end