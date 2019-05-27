function [heightMap]= generateHeightMapDims(connPair,Params)
%Generates points on the C-space
%Create N, N-dimensional matrices so we can reference ie. x,y,theta value 
%at each (i,j,k) index
%
%Includes possible mixed dimensionalities. ie. (x,roll,pitch) or 
% even (roll,pitch,yaw)



offsets.translations=getHMapTranslations(Params.dimensions,Params.resolution);
offsets.rotations=getHMapRotations(Params.dimensions,Params.resolution);

heightMap=getHeightMap(Params.dimensions,Params.resolution,connPair,offsets);

end


