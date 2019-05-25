function [Offsets]=populate2DOffsets(resolution)
%X_SPAN=abs(rotationCenterFactor)+designParams.aspectRatio;
X_SPAN=5;
X_CELL_SIZE=4/resolution;
THETA_CELL_SIZE=pi/resolution;
Offsets.xSet=-X_SPAN:X_CELL_SIZE:X_SPAN;
Offsets.tSet=-pi/2:THETA_CELL_SIZE:pi/2;
Offsets.xMat=repmat(Offsets.xSet,resolution+1,1);
Offsets.tMat=repmat(Offsets.tSet',1,numel(Offsets.xSet));
end