function fs = ComputeFeature(ii_ims, ftype)
n = length(ii_ims);
fs = zeros(1,n);
type = ftype(1);
x = ftype(2);
y = ftype(3);
w = ftype(4);
h = ftype(5);

for i = 1:n
    % Reshape the ii_ims:i
    ii_im = reshape(ii_ims(i,:,:), size(ii_ims(i,:,:),2),size(ii_ims(i,:,:),3));
    % Compute the feature
    switch type
        case 1     
            fs(i) = FeatureTypeI(ii_im,x,y,w,h);
        case 2
            fs(i) = FeatureTypeII(ii_im,x,y,w,h);
        case 3
            fs(i) = FeatureTypeIII(ii_im,x,y,w,h);
        case 4
            fs(i) = FeatureTypeIV(ii_im,x,y,w,h);
    end
end

end