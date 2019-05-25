function [ height ] = getHeightAtPoint(obstaclePolyUnion, xyVals)

pointSlice=obstaclePolyUnion.slice([1 2],xyVals);

if isa(pointSlice,'PolyUnion') && pointSlice.Num>0
    
    sliceVertices=vertcat(pointSlice.Set.V);
    
    if numel(sliceVertices)>0
        height=max(sliceVertices);
    end
    
end

if ~exist('height','var')
    height=-10;
end


end

