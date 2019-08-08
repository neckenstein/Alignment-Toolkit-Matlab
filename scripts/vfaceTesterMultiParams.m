close all

RESOLUTION=100;
DEPTH_TOL_FACTOR=0.36;
aspectRatios = [1/4 1/2  1 2 4];
rotationCenters = [-1 -1/2 0 1/2 1];
aaResult=zeros(numel(aspectRatios),numel(rotationCenters));
onaaResult=zeros(numel(aspectRatios),numel(rotationCenters));
onaaDigits=zeros(numel(aspectRatios),numel(rotationCenters));
ndMetrics=cell(numel(aspectRatios),numel(rotationCenters));
for i=1:numel(aspectRatios)
    for j=1:numel(rotationCenters)
        DesignParams.aspectRatio=aspectRatios(i);
        DesignParams.rotationCenter=rotationCenters(j);
        [aaResult(i,j),onaaTest(i,j),onaaDigits(i,j),ndMetrics{i,j}]=findWsVFaceDepth(100,DesignParams,0.36);
    end
end