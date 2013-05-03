function fs = VecComputeFeature(ii_ims, ftype_vec)

fs = reshape(ii_ims, size(ii_ims,1), size(ii_ims,2)*size(ii_ims,3))*ftype_vec;

end
