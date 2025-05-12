function lbl = fill_slice_endpoints(lbl)
%FILL_SLICE_ENDPOINTS Add mask voxels in first/last slices if missing
slices = find(squeeze(any(any(lbl,1),2)));
for e = [slices(1),slices(end)]
    if e>1 && e==slices(1)
        ctr = compute_centers(lbl(:,:,e)); lbl(ctr(1),ctr(2),e-1)=1;
    elseif e<size(lbl,3) && e==slices(end)
        ctr = compute_centers(lbl(:,:,e)); lbl(ctr(1),ctr(2),e+1)=1;
    end
end
end
