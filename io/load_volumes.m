function [mrImage, pixDim] = load_volumes(matFile)
%LOAD_VOLUMES Load MR image and pixel dimensions
S = load(matFile);
mrImage = S.mrImage;
pixDim  = S.pixDim;
end
