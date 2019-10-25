clear all
DesignParams.aspectRatio=1/4;
DesignParams.rotationCenter=-1/2;
maxSteps=15;
resolutions=zeros(1,maxSteps);
aas=zeros(1,maxSteps);
cpuTimes=zeros(1,maxSteps);
for r=1:20
    resolutions(r)=20+10*r;
    Params.resolution=resolutions(r);
    cpuBefore=cputime;
    [aa,onaaTest,onaaDigits,ndMetrics]=findWsVFaceDepth(resolutions(r),DesignParams,0.1);    
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
