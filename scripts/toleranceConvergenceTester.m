DesignParams.aspectRatio=4;
DesignParams.rotationCenter=1;
tolerance=zeros(1,10);
aa=zeros(1,10);
for res=1:10
    resolution;
    [aaTest,onaaTest,onaaDigits,ndMetrics]=findWsVFaceDepth(100,DesignParams,tolerance(t));
    aa(t)=aaTest;
end
plot(tolerance,aa,'x')