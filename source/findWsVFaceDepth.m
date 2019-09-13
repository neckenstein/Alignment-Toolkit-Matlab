function [sumAA,onAA,onAACells,mergeMetrics]=findWsVFaceDepth(resolution,DesignParams, depthTolerance)
FALLOFF_MINIMUM=0;
BORDER_SIZE=100;
FILE_CHARS=24;
if mod(resolution,2)>0
    resolution=resolution-1;
end

filename=makeFilename(DesignParams);

Offsets=populate2DOffsets(resolution);

ObstaclePolyhedra=generate2DObstaclePolyhedra(DesignParams);

heightMap=generateHeightMap(Offsets,ObstaclePolyhedra);

%depthTolerance=findDepthTolerance(depthToleranceFactor,heightMap);

watersheds=watershed(heightMap)+2;

mergeMetrics=populate2DMergeMetrics(heightMap,watersheds);

watersheds=merge_watersheds_by_depth(heightMap,watersheds,depthTolerance);

watersheds=merge_dams(heightMap,watersheds);

%Change super-low points so plot is more readable
heightMap(heightMap<FALLOFF_MINIMUM)=FALLOFF_MINIMUM;
currentFilepath=mfilename('fullpath');
rootPath=currentFilepath(1:end-FILE_CHARS);
dataFilepath=strcat(rootPath,'\data\discrete2dvfacefigs\',filename);
PlotLimits=find2DPlotLimits(watersheds,BORDER_SIZE,Offsets);
plotOpaque3DHeightMap(watersheds,heightMap,Offsets,PlotLimits,DesignParams,resolution)
saveas(figure(1),strcat(dataFilepath,'.jpg'))
plotTransparent3DHeightMap(watersheds,heightMap,Offsets,PlotLimits,DesignParams,resolution)
saveas(figure(2),strcat(dataFilepath,'_alpha.jpg'))

%Flat image
plot2DAA(watersheds)
saveas(figure(3),strcat(dataFilepath,'_imagesc.jpg'))

cellSize=(4*pi)/(resolution)^2;
sumAA=findSumAA(watersheds,cellSize);
[onAA,onAACells]=findONAA(watersheds,resolution);

end

function [filename]=makeFilename(designParams)
filename = strcat('vface_flooding_ar',...
    num2str(designParams.aspectRatio*100),...
    '_cor',num2str(designParams.rotationCenter*100));
end

function plot2DAA(watersheds)
figure(3)
imagesc(watersheds)
xlabel('x')
ylabel('theta')
set(gca,'Ydir','normal')
end

function [PlotLimits]=find2DPlotLimits(watersheds,borderSize,Offsets)
[iWatersheds,jWatersheds]=find(watersheds~=1);
PlotLimits.iMin=max(min(iWatersheds)-borderSize,1);
PlotLimits.iMax=min(max(iWatersheds)+borderSize,size(Offsets.xMat,1));
PlotLimits.jMin=max(min(jWatersheds)-borderSize,1);
PlotLimits.jMax=min(max(jWatersheds)+borderSize,size(Offsets.xMat,2));
end
function [sumAA]=findSumAA(watersheds,cellSize)
aaMatching=pointsInAA(watersheds);
wsAreaPoints=nnz(aaMatching);
sumAA=wsAreaPoints*cellSize;
end






