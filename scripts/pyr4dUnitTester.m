load '../data/unitTestData/pyr4dUnitTestData.mat'
Params.aspectRatio=1/2;
Params.rotationCenter=0;
Params.resolution=30;
Params.tolerance=0.01;
Params.dimensions=[1 3 4];
connPair=get3DPyramidConnector(Params);

[aaTest2,onaaTest2,onaaDigits2,ndMetrics2]=aaByFloodND(connPair,Params);
testCounter=int8(aaTest==aaTest2)+int8(onaaTest==onaaTest2)+int8(onaaDigits==onaaDigits2)+nnz(abs(ndMetrics-ndMetrics2)<10^-10);
if testCounter==127
    disp('Unit test passed!')
end
