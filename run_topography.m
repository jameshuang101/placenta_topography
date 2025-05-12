function run_topography(dataFolder, saveFolder, toSave, doReg)
%RUN_TOPOGRAPHY Main pipeline for placenta topography extraction
if nargin<3, toSave = true; end
if nargin<4, doReg = false; end
if ~exist(saveFolder,'dir'), mkdir(saveFolder); end

imFiles = dir(fullfile(dataFolder,'Images','*.mat'));
for i=1:numel(imFiles)
    fname = imFiles(i).name; ptNum = fname(8:10);
    fprintf('Processing %d/%d: Patient %s
', i, numel(imFiles), ptNum);

    [mrImage, pixDim] = load_volumes(fullfile(dataFolder,'Images',fname));
    [pLabel, uLabel] = load_labels(dataFolder, ptNum);

    if doReg
        [mrImage, pLabel, uLabel] = simple_registration(mrImage, pLabel, uLabel, 100);
    end

    pLabel = fill_slice_endpoints(pLabel);
    uLabel = fill_slice_endpoints(uLabel);
    [mrIso, pIso, uIso, pixDimIso] = upsample_and_iso(mrImage, pLabel, uLabel, pixDim);

    pCenter = compute_centers(pIso);
    uCenter = compute_centers(uIso);

    [mrC, pC] = center_and_pad(mrIso, pIso, pCenter, 256);

    [d_sag_L,d_sag_R] = get_dists(pC,1);
    [d_cor_A,d_cor_P] = get_dists(pC,2);
    maps_basic = extract_intensity_maps(mrC, d_sag_L,d_sag_R, d_cor_A,d_cor_P, pixDimIso);

    [topoF,topoM,intF,intM,thick] = polar_topography(pC, mrC, pixDimIso);
    maps_polar = struct('topo_fetal',topoF,'topo_maternal',topoM, ...
                        'intensity_fetal',intF,'intensity_maternal',intM, ...
                        'thickness',thick);

    maps = catstruct(maps_basic, maps_polar);
    plot_topography_maps(maps, pixDimIso, size(mrIso,3), fname, saveFolder, toSave);
end
end
