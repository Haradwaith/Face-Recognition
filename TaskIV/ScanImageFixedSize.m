function dets = ScanImageFixedSize(Cparams, im)

if size(im, 3) == 3
    %im = rgb2gray(im);
    im = (im(:,:,1) + im(:,:,2) + im(:,:,3));
end

Y = size(im,1);
X = size(im,2);
L = 19;
squared_im = im .* im;
ii_im = cumsum(cumsum(im,2));
squared_ii_im = cumsum(cumsum(squared_im,2));
dets = [];

for x = 1:X+1-L
    for y = 1:Y+1-L
        mu = ComputeBoxSum(ii_im, x, y, L, L)/(L^2);
        sigma = sqrt((1/(L^2 - 1))*(ComputeBoxSum(squared_ii_im, x, y, L, L) -L^2 *mu^2));

        sc = ApplyDetectorAdapted(Cparams, ii_im(y:y+L-1,x:x+L-1), sigma, mu, L);

        % keep detected faces
        if sc > Cparams.thresh
            dets = [dets; [y,x,L,L]];
        end
    end
end

end

