clear all
Params.aspectRatio=1/2;
Params.rotationCenter=0;
Params.resolution=10;
Params.tolerance=0.01;
Params.dimensions=[1 2 3 4 5];

connPair=get3DPyramidConnector(Params);
[aaTest2,onaaTest2,onaaDigits2,ndMetrics2]=aaByFloodND(connPair,Params);