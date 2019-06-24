clear all
%Parameters can vary across multiple simulations
Params.aspectRatio=1/2;
Params.rotationCenter=0;
Params.resolution=20;
Params.tolerance=0.01;
Params.dimensions=[1 2 3];
%Specify connector geometries (use get3DPyramidConnector as a guide)


connPair=get3DPyramidConnector(Params);
%Run flooding algorithm to get the AA
[aa,onaa,onaaCell,ndMetrics]=aaByFloodND(connPair,Params);