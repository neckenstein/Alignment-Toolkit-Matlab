function []=plotOpaque3DHeightMap(watersheds,heightMap,Offsets,PlotLimits)
figure(1)
surfacePlot=surf(Offsets.tMat(PlotLimits.iMin:PlotLimits.iMax,PlotLimits.jMin:PlotLimits.jMax),Offsets.xMat(PlotLimits.iMin:PlotLimits.iMax,PlotLimits.jMin:PlotLimits.jMax),heightMap(PlotLimits.iMin:PlotLimits.iMax,PlotLimits.jMin:PlotLimits.jMax)+0.75,watersheds(PlotLimits.iMin:PlotLimits.iMax,PlotLimits.jMin:PlotLimits.jMax));
surfacePlot.EdgeAlpha=0.3;
xlabel('theta')
ylabel('x')
zlabel('y')
axis equal
axis([-1.7279    1.7279 -2.7500    2.7500  -0.1250    4.6250])
title('Discrete Method AA:V-Face AR:2 COR:1 Res:100x100 - 3D')
end