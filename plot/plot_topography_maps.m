function plot_topography_maps(maps,voxel,zlen,fname,saveF,toSave)
%PLOT_TOPOGRAPHY_MAPS Plot and optionally save
fields=fieldnames(maps);
base=fullfile(saveF,fname(1:end-4)); if toSave&&~exist(base,'dir'),mkdir(base);end
for i=1:numel(fields)
  figure('Position',[1,1,1200,800]);imagesc(maps.(fields{i}));colorbar;colormap hot;
  title(fields{i});
  if toSave,saveas(gcf,fullfile(base,[fields{i},'.png']));end
  close;
end
end
