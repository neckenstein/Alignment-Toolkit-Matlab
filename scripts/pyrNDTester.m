clear all
%Parameters can vary across multiple simulations
Params.aspectRatio=1/2;
Params.rotationCenter=-1.31;
Params.resolution=60;
Params.tolerance=0.01;
Params.dimensions=[1 4 5];
%Specify connector geometries (use get3DPyramidConnector as a guide)


connPair=get3DPyramidConnector(Params);
%Run flooding algorithm to get the AA
[aa,onaa,onaaCell,ndMetrics]=aaByFloodND(connPair,Params);