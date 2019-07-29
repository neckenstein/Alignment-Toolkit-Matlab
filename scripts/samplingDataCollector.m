% Example of Sampling-oversegmentation in data
% DesignParams.aspectRatio=4;
% DesignParams.rotationCenter=0;
% [aaTest,onaaTest,onaaDigits,ndMetrics]=findWsVFaceDepth(100,DesignParams,0.1);

clear all
close all
resolutions = [100];
depthTolFactors = [0.0001 0.001 0.01 0.1 0.2 0.4 0.5];
heightFactors = [1];
angle =35;
sumAA=zeros(numel(resolutions),numel(heightFactors),numel(depthTolFactors));
for i=1:numel(resolutions)
    for j=1:numel(heightFactors)
        for k=1:numel(depthTolFactors)
        sumAA(i,j,k)=samplingTester(resolutions(i),heightFactors(j),depthTolFactors(k),angle);
        end
    end
end
%Correct sumAA is 5185, 