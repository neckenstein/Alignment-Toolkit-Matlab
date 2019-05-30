function [wsArea,onAA,onaaCellsSide,neighborMetrics]=aaByFloodND(connPair,Params)
% Finds the area of acceptance for a connector pair in N Dimensions
%
% Inputs:
% Params.dimensions - array of offset dimensions to check 
% Should be array of up to 5 dims, where x=1,y=2,roll=3,pitch=4,yaw=5
% ie. [1 2 3] is (x,y,theta).
% Params.aspectRatio - Params.aspectRatio ratio height/width for the V-Face connector
% Params.rotationCenter - distance to center of rotation, given as a # of connector widths
% back from center of connector. 
% Params.tolerance - depth tolerance for merging
% Params.resolution - resolution (# of points in each dimension. Even values get -1 to
% become odd for ease of use)
%
% Outputs:
% wsArea - relative measure of total area of acceptance. 
% Figure representing aa will be plotted as well. 
%

% Params.resolution must be even
if ~even(Params.resolution)
   Params.resolution=Params.resolution-1; 
end

if numel(Params.dimensions)>5
   error('Params.dimensions should have size <=5'); 
end

cellSize = calculateCellSize(Params);

points=generateHeightMapDims(connPair,Params);

wsUnmerged=floodingSolverND(points);

neighborMetrics=populateMergeMetrics(points,wsUnmerged);

centerWS=Params.resolution/2+1;
centerInd=num2cell(centerWS*ones(1,numel(Params.dimensions)));

wsMerged=mergeWatershedsByDepthND(points,wsUnmerged,Params.tolerance); 
wsMerged=mergeDamsND(points,wsMerged); 

wsOfInterest=wsMerged(centerInd{:});

isAA=wsMerged==wsOfInterest;

onaaCellsSide=findONAAND(isAA);
onAA=onaaCellsSide^2*cellSize;

wsArea=sum(isAA(:))*cellSize;

aaPlotND(isAA);

end

