function [imgR,pR,uR] = simple_registration(img,pLbl,uLbl,itr)
%SIMPLE_REGISTRATION Slice-wise respiratory correction
oddImg = img(:,:,1:2:end); evenImg = img(:,:,2:2:end);
oddfU = uLbl(:,:,1:2:end); evnU = uLbl(:,:,2:2:end);
% Determine phase
odC = compute_centers(oddfU); evC = compute_centers(evnU);
if odC(2)<evC(2)
    target = interpolate_slices(oddImg); moving = evenImg; sliceIdx=2:2:size(img,3);
else
    target = interpolate_slices(evenImg); moving = oddImg; sliceIdx=1:2:size(img,3);
end
[D,regMov] = imregdemons(moving,double(target),itr);
mask = moving; % placeholder for masks interpolation
regMask = imwarp(double(mask),D,'OutputView',imref2d(size(mask(:,:,1))));
imgR=img; pR=pLbl; uR=uLbl;
for k=1:numel(sliceIdx),s=sliceIdx(k);imgR(:,:,s)=regMov(:,:,k); end
end

function target = interpolate_slices(vol)
%INTERPOLATE_SLICES Helper to interpolate between slices
[H,W,N]=size(vol); [X,Y,Z]=meshgrid(1:W,1:H,1:0.5:N);
volI=interp3(double(vol),X,Y,Z,'spline'); target=volI(:,:,2:2:end);
end
