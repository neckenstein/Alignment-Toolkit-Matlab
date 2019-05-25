function [heightMap]= generateHeightMapDims(dims,N,DesignParams)
%Generates points on the C-space
%Create N, N-dimensional matrices so we can reference ie. x,y,theta value 
%at each (i,j,k) index
%
%Includes possible mixed dimensionalities. ie. (x,roll,pitch) or 
% even (roll,pitch,yaw)


connPair=get3DPyramidConnector(DesignParams);

offsets.translations=getHMapTranslations(dims,N);
offsets.rotations=getHMapRotations(dims,N);

heightMap=getHeightMap(dims,N,connPair,offsets);

end


