function [ObstaclePolyhedra]=generate2DObstaclePolyhedra(DesignParams)
%2d connector polyhedra
B1=Polyhedron([0 0;0 0.5+DesignParams.aspectRatio; 0.5 0.5;0.5 0]);
B2=Polyhedron([0.5 0; 0.5 0.5; 1 0.5+DesignParams.aspectRatio; 1 0]);
R=Polyhedron([0 -(0.5+DesignParams.aspectRatio); -1 -(0.5+DesignParams.aspectRatio); -1 -DesignParams.aspectRatio; -0.5 0; 0 -DesignParams.aspectRatio]);

%Recentering B1 and B2
centerOfB=0.5*(max([B1.V;B2.V])+min([B1.V;B2.V]));
ObstaclePolyhedra.B1=B1-centerOfB;
ObstaclePolyhedra.B2=B2-centerOfB;
allVPoints=R.V;
maxV=max(allVPoints);
minV=min(allVPoints);
rotationCenterPoint = 0.5*(maxV+minV);
rotationCenterPoint(2)=minV(2)+DesignParams.rotationCenter*(maxV(2)-minV(2));
ObstaclePolyhedra.centeredR=R-rotationCenterPoint;
end