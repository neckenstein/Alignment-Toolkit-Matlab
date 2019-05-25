clear all
DesignParams.aspectRatio=1/2;
DesignParams.rotationCenter=0;
CompParams.resolution=10;
CompParams.tolerance=0.01;
CompParams.dimensions=[1 2 3 4];
[aaTest2,onaaTest2,onaaDigits2,ndMetrics2]=pyramidWsND(DesignParams,CompParams);