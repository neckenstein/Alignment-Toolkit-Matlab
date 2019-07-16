clear all
close all
resolution=30;
range=10;
depthTolerance = 5;
%Due to peculiarities of plotting, consider x=tMat,y=xMat
Offsets.xSet=-range:2*range/resolution:range;
Offsets.tSet=-range:2*range/resolution:range;
[Offsets.tMat,Offsets.xMat]=meshgrid(-range:2*range/resolution:range,-range:2*range/resolution:range);
DesignParams.aspectRatio='Test';
DesignParams.rotationCenter='Test';
Z=abs(-exp(1)*(Offsets.xMat)+4*Offsets.tMat);
%Z=Z+(abs(range.^2-(abs(Offsets.tMat)-range).^2)).^0.5;
Z=50*Z;
figure(1)
surf(Offsets.tMat,Offsets.xMat,Z)
xlabel('x')
ylabel('y')
watershedInitial=flooding_solver_2d(Z,'8adj');
PlotLimits=find2DPlotLimits(watershedInitial,1,Offsets);
plotOpaque3DHeightMap(watershedInitial,Z,Offsets,PlotLimits,DesignParams,resolution)


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