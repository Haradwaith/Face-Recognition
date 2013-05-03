function fs = VecComputeFeature(ii_ims, ftype_vec)
n = size(ii_ims, 1);
fs = zeros(n,1);

for i = 1:n
    ii_im = reshape(ii_ims(i,:,:), size(ii_ims(i,:,:),2),size(ii_ims(i,:,:),3));
    fs(i) = ii_im(:)'*ftype_vec;
end

end