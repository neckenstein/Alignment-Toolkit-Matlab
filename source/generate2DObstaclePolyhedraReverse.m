function [ObstaclePolyhedra]=generate2DObstaclePolyhedraReverse(DesignParams)
%Rotates B instead of R to generate the 
%2d connector polyhedra
B1=Polyhedron([0 0;0 0.5+DesignParams.aspectRatio; 0.5 0.5;0.5 0]);
B2=Polyhedron([0.5 0; 0.5 0.5; 1 0.5+DesignParams.aspectRatio; 1 0]);
R=Polyhedron([0 -(0.5+DesignParams.aspectRatio); -1 -(0.5+DesignParams.aspectRatio); -1 -DesignParams.aspectRatio; -0.5 0; 0 -DesignParams.aspectRatio]);

%Recentering B1 and B2,R
allBVPoints = [B1.V;B2.V];
maxBV=max(allBVPoints);
minBV=min(allBVPoints);
rotationCenterPoint = 0.5*(maxBV+minBV);
rotationCenterPoint(2)=minBV(2)+DesignParams.rotationCenter*(maxBV(2)-minBV(2));
ObstaclePolyhedra.centeredB1=B1-rotationCenterPoint;
ObstaclePolyhedra.centeredB2=B2-rotationCenterPoint;

allRVPoints = R.V;
maxRV=max(allRVPoints);
minRV=min(allRVPoints);
rCenterPoint = 0.5*(maxRV+minRV);
ObstaclePolyhedra.centeredR=R-rCenterPoint;

end