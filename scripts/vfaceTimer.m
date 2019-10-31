clear all

DesignParams.aspectRatio=1/4;
DesignParams.rotationCenter=1/2;
resolutions=zeros(1,20);
aas=zeros(1,20);
cpuTimes=zeros(1,20);
for r=1:20
    resolutions(r)=16+4*r;
    Params.resolution=resolutions(r);
    cpuBefore=cputime;
    [aa,onaa,onaaCell,ndMetrics]=findWsVFaceDepth(resolutions(r),DesignParams,0.1);
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
hold on
p = polyfit(resolutions,cpuTimes,2);
x1=linspace(min(resolutions),max(resolutions));
y1 = polyval(p,x1);
plot(x1, y1)
hold off