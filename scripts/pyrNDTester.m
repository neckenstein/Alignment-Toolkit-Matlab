clear all
Params.aspectRatio=1/2;
Params.rotationCenter=0;
Params.resolution=20;
Params.tolerance=0.01;
Params.dimensions=[1 3 4];

connPair=get3DPyramidConnector(Params);
[aaTest2,onaaTest2,onaaDigits2,ndMetrics2]=aaByFloodND(connPair,Params);