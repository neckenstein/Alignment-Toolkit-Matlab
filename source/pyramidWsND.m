function [wsArea,onAA,onaaCellsSide,neighborMetrics]=pyramidWsND(DesignParams,CompParams)
% Finds the area of acceptance for a v-face connector in 4 dimensions,
% giving 3d aa
%
% Inputs:
% CompParams.dimensions - array of offset dimensions to check 
% Should be array of any size, where x=1,y=2,roll=3,pitch=4,yaw=5
% ie. [1 2 3] is (x,y,theta).
% DesignParams.aspectRatio - DesignParams.aspectRatio ratio height/width for the V-Face connector
% DesignParams.rotationCenter - distance to center of rotation, given as a # of connector widths
% back from center of connector. 
% CompParams.tolerance - depth tolerance for merging
% CompParams.resolution - resolution (# of points in each dimension. Even values get -1 to
% become odd for ease of use)
%
% Outputs:
% wsArea - relative measure of total area of acceptance. 
% Figure representing aa will be plotted as well. 
%

% CompParams.resolution must be even
if ~even(CompParams.resolution)
   CompParams.resolution=CompParams.resolution-1; 
end

if numel(CompParams.dimensions)>5
   error('CompParams.dimensions should have size <=5'); 
end

cellSize = calculateCellSize(CompParams);

points=generateHeightMapDims(CompParams.dimensions,CompParams.resolution,DesignParams);

wsUnmerged=floodingSolverND(points);

neighborMetrics=populateMergeMetrics(points,wsUnmerged);

centerWS=CompParams.resolution/2+1;
centerInd=num2cell(centerWS*ones(1,numel(CompParams.dimensions)));

wsMerged=mergeWatershedsByDepthND(points,wsUnmerged,CompParams.tolerance); 
wsMerged=mergeDamsND(points,wsMerged); 

wsOfInterest=wsMerged(centerInd{:});

isAA=wsMerged==wsOfInterest;

onaaCellsSide=findONAAND(isAA);
onAA=onaaCellsSide^2*cellSize;

wsArea=sum(isAA(:))*cellSize;

aaPlotND(isAA);

end

