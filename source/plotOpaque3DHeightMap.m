function []=plotOpaque3DHeightMap(watersheds,heightMap,Offsets,PlotLimits,Params,resolution)
figure()
surfacePlot=surf(Offsets.tMat(PlotLimits.iMin:PlotLimits.iMax,PlotLimits.jMin:PlotLimits.jMax),Offsets.xMat(PlotLimits.iMin:PlotLimits.iMax,PlotLimits.jMin:PlotLimits.jMax),heightMap(PlotLimits.iMin:PlotLimits.iMax,PlotLimits.jMin:PlotLimits.jMax)+0.75,watersheds(PlotLimits.iMin:PlotLimits.iMax,PlotLimits.jMin:PlotLimits.jMax));
surfacePlot.EdgeAlpha=0.3;
xlabel('theta')
ylabel('x')
zlabel('y')
%axis equal
%axis([-1.7279    1.7279 -2.7500    2.7500  -0.1250    4.6250])
titleString=strcat('Discrete Method AA:V-Face AR:',Params.aspectRatio,' COR:',Params.rotationCenter,' Res:',resolution,' - 3D');
title(titleString)
end