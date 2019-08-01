% Example of Sampling-oversegmentation in data
% DesignParams.aspectRatio=4;
% DesignParams.rotationCenter=0;
% [aaTest,onaaTest,onaaDigits,ndMetrics]=findWsVFaceDepth(100,DesignParams,0.1);

clear all
close all
resolutions = [20:2:200];
depthTolFactors = [0.1:0.01:0.5];
angle =35;
sumAA=zeros(numel(resolutions),numel(depthTolFactors));
for i=1:numel(resolutions)
    for k=1:numel(depthTolFactors)
        sumAA(i,k)=samplingTester(resolutions(i),1,depthTolFactors(k),angle);
        loss = (0.25777280103 - sumAA).^2;
        rmsLoss=mean(loss);
    end
end
%Correct sumAA is 0.25777280103