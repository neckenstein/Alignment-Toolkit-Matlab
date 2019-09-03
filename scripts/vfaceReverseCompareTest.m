clear all
close all
DesignParams.aspectRatio=1;
DesignParams.rotationCenter=0;
resolution=100;
depthToleranceFactor=0.36;
Offsets=populate2DOffsets(resolution);
%Forward representation height map
ObstaclePolyhedra=generate2DObstaclePolyhedra(DesignParams);
heightMap1=generateHeightMap(Offsets,ObstaclePolyhedra);
figure(1)
surf(heightMap1)
%Reverse height map
figure(2)
ObstaclePolyhedra=generate2DObstaclePolyhedraReverse(DesignParams);
heightMap2=generateHeightMapReverse(Offsets,ObstaclePolyhedra);
surf(heightMap2)