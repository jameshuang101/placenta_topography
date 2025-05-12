function maps = planar_topography(lbl,img,voxel,width)
%PLANAR_TOPOGRAPHY Generate planar strips
for dim=1:2
  [dL,dR]=get_dists(lbl,dim);
  maps.(['planar' num2str(dim) '_L'])=dL'*voxel;
  maps.(['planar' num2str(dim) '_R'])=dR'*voxel;
end
end
