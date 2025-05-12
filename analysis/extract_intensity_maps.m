function maps = extract_intensity_maps(img,dSL,dSR,dCA,dCP,voxel)
%EXTRACT_INTENSITY_MAPS Basic topography and intensity maps
maps.sag_left = dSL'*voxel; maps.sag_right = dSR'*voxel;
maps.cor_ant = dCA'*voxel; maps.cor_post = dCP'*voxel;
maps.thickness_sag = (dSR-dSL)'*voxel;
maps.thickness_cor = (dCP-dCA)'*voxel;
end

%% topography/polar_topography.m
function [mapF,mapM,intF,intM,thick] = polar_topography(lbl,img,voxel)
%POLAR_TOPOGRAPHY Polar feature mapping
Origin=compute_centers(lbl);
border=lbl & ~imerode(lbl,strel('sphere',1));
[x,y,z]=ind2sub(size(border),find(border));
[az,el,r]=cart2sph(x-Origin(1),y-Origin(2),z-Origin(3));
az=mod(az+pi,2*pi)-pi;
res=[181,361]; M=max(r)*1.1;
mapF=ones(res)*M; mapM=zeros(res);
pix=img(border);
for i=1:numel(r)
  e=round(el(i)*180/pi+91); a=round(az(i)*180/pi+181);
  if mapF(e,a)==M||r(i)<mapF(e,a),mapF(e,a)=r(i);intF(e,a)=pix(i);end
  if mapM(e,a)==0||r(i)>mapM(e,a),mapM(e,a)=r(i);intM(e,a)=pix(i);end
end
mapF=mapF*(0.5*voxel); mapM=mapM*(0.5*voxel);
thick=mapM-mapF;
end
