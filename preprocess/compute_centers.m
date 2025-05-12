function center = compute_centers(lbl)
%COMPUTE_CENTERS Compute centroid of mask
[x,y,z] = ind2sub(size(lbl),find(lbl));
center = round([mean(x),mean(y),mean(z)]);
end
