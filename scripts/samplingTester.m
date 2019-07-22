% Example of Sampling-oversegmentation
% DesignParams.aspectRatio=4;
% DesignParams.rotationCenter=0;
% [aaTest,onaaTest,onaaDigits,ndMetrics]=findWsVFaceDepth(100,DesignParams,0.1);

clear all
close all
resolution=100;
range=10;
angle=35;
%Due to peculiarities of plotting, consider x=tMat,y=xMat
Offsets.xSet=-range:2*range/resolution:range;
Offsets.tSet=-range:2*range/resolution:range;
[Offsets.tMat,Offsets.xMat]=meshgrid(-range:2*range/resolution:range,-range:2*range/resolution:range);
DesignParams.aspectRatio='Test';
DesignParams.rotationCenter='Test';
Z=abs(range.^2-(abs(Offsets.tMat+Offsets.xMat)-range).^2).^0.5;
ZR=Z+imrotate(Z,90);
Z=imrotate(ZR,angle);
newSize=size(Z,1);
newSizeHalved=floor(newSize/2);
Offsets.xSet=1:newSize;
Offsets.tSet=1:newSize;
[Offsets.tMat,Offsets.xMat]=meshgrid(1:newSize,1:newSize);
depthTolerance=0.1*(max(Z(:))-min(Z(:)));
%Z=500*Z;
figure()
surf(Offsets.tMat,Offsets.xMat,Z)
xlabel('x')
ylabel('y')
watershedInitial=watershed(Z);
watershedInitial=watershedInitial+2;
PlotLimits=find2DPlotLimits(watershedInitial,1,Offsets);
plotOpaque3DHeightMap(watershedInitial,Z,Offsets,PlotLimits,DesignParams,resolution)
mergeMetrics=populate2DMergeMetrics(Z,watershedInitial);

watersheds=merge_watersheds_by_depth(Z,watershedInitial,depthTolerance);
watersheds=merge_dams(Z,watersheds);
plotOpaque3DHeightMap(watersheds,Z,Offsets,PlotLimits,DesignParams,resolution)

function [PlotLimits]=find2DPlotLimits(watersheds,borderSize,Offsets)
[iWatersheds,jWatersheds]=find(watersheds~=1);
PlotLimits.iMin=max(min(iWatersheds)-borderSize,1);
PlotLimits.iMax=min(max(iWatersheds)+borderSize,size(Offsets.xMat,1));
PlotLimits.jMin=max(min(jWatersheds)-borderSize,1);
PlotLimits.jMax=min(max(jWatersheds)+borderSize,size(Offsets.xMat,2));
end