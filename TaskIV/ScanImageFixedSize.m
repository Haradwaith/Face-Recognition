function dets = ScanImageFixedSize(Cparams, im)

if size(im, 3) == 3
    im = im(:,:,1) + im(:,:,2) + im(:,:, 3);
end

X = size(im,1);
Y = size(im,2);
L = 19;
squared_im = im .* im;
ii_im = cumsum(cumsum(im,2));
dets = [];

for x = 1:X+1-L
    for y = 1:Y+1-L

        % size(squared_im);
        mu = (1/L^2)*sum(sum(im(x:x+L-1,y:y+L-1)));
        sigma = sqrt((1/(L^2 - 1))*(sum(sum(squared_im(x:x+L-1,y:y+L-1))) -L^2 *mu^2));

        sc = ApplyDetectorAdapted(Cparams, ii_im(x:x+L-1,y:y+L-1), sigma, mu, L);

        % keep detected faces
        if sc > Cparams.thresh
            dets = [dets; [x,y,L,L]];
        end
    end
end

end

