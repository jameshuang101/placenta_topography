function maps = extract_intensity_maps(img,dSL,dSR,dCA,dCP,voxel)
%EXTRACT_INTENSITY_MAPS Basic topography and intensity maps
maps.sag_left = dSL'*voxel; maps.sag_right = dSR'*voxel;
maps.cor_ant = dCA'*voxel; maps.cor_post = dCP'*voxel;
maps.thickness_sag = (dSR-dSL)'*voxel;
maps.thickness_cor = (dCP-dCA)'*voxel;
end
