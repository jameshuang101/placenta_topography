function [imgIso,pIso,uIso,pixIso] = upsample_and_iso(img,pLbl,uLbl,pixDim)
%UPSAMPLE_AND_ISO Resample to isotropic voxels
voxel = pixDim(1);
sz = size(img);
[X,Y,Z] = meshgrid(1:sz(2),1:sz(1),1:(pixDim(1)/pixDim(3)):sz(3));
imgIso = interp3(double(img),X,Y,Z,'cubic');
pIso   = interp3(double(pLbl),X,Y,Z,'nearest');
uIso   = interp3(double(uLbl),X,Y,Z,'nearest');
pixIso = voxel;
end
