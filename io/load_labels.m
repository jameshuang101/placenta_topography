function [pLabel, uLabel] = load_labels(dataFolder, ptNum)
%LOAD_LABELS Load placenta and uterus masks
pl = load(fullfile(dataFolder,'Labels',sprintf('Label_0%s_placenta.mat',ptNum)));
if isfield(pl,'mrLabel'), pLabel = logical(pl.mrLabel);
else,                    pLabel = logical(pl.plLabel); end
ul = load(fullfile(dataFolder,'Labels',sprintf('Label_0%s_uterus.mat',ptNum)));
uLabel = logical(ul.utLabel);
end
