clear all
%Parameters can vary across multiple simulations
Params.aspectRatio=1/2;
Params.rotationCenter=0;
Params.resolution=10;
Params.tolerance=0.01;
Params.dimensions=[1 3 4];
%Specify connector geometries (use get3DPyramidConnector as a guide)
connPair=get3DPyramidConnector(Params);
%Run flooding algorithm to get the AA
resolutions=zeros(1,20);
aas=zeros(1,20);
cpuTimes=zeros(1,20);
for r=1:20
    resolutions(r)=18+2*r;
    Params.resolution=resolutions(r);
    cpuBefore=cputime;
    [aa,onaa,onaaCell,ndMetrics]=aaByFloodND(connPair,Params);
    cpuAfter=cputime;
    aas(r)=aa;
    cpuTimes(r)=cpuAfter-cpuBefore;
end
figure()
plot(resolutions,aas,'.')
title('AA convergence vs resolution - x pitch roll')
xlabel('Resolution')
ylabel('AA Sum')
figure()
plot(resolutions,cpuTimes,'.')
title('CPU Time vs resolution - x pitch roll')
xlabel('Resolution')
ylabel('CPU Time (s)')
