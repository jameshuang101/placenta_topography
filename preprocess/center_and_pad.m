function [imgOut,lblOut] = center_and_pad(img,lbl,center,target)
%CENTER_AND_PAD Translate center to image center and pad/crop
trans = round((target/2)-center);
imgT = imtranslate(img,[trans(2),trans(1),trans(3)],'FillValues',0);
lblT = imtranslate(lbl,trans([2,1,3]),'FillValues',0);
zsz = size(imgT,3);
if zsz<target
    pad = ceil((target-zsz)/2);
    imgOut = padarray(imgT,[0,0,pad],0,'both');
    lblOut = padarray(lblT,[0,0,pad],0,'both');
else
    cr = ceil((zsz-target)/2);
    imgOut = imgT(:,:,cr+1:cr+target);
    lblOut = lblT(:,:,cr+1:cr+target);
end
end
