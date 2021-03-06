function []=plotTransparent3DHeightMap(watersheds,heightMap,OffsetMats,PlotLimits)
figure(2)
alphaData=0.5*ones(size(watersheds));
tMatTrimmed=OffsetMats.tMat(PlotLimits.iMin:PlotLimits.iMax,PlotLimits.jMin:PlotLimits.jMax);
xMatTrimmed=OffsetMats.xMat(PlotLimits.iMin:PlotLimits.iMax,PlotLimits.jMin:PlotLimits.jMax);
hMapTrimmed=heightMap(PlotLimits.iMin:PlotLimits.iMax,PlotLimits.jMin:PlotLimits.jMax);
surfaceFixed=surf_fix_2d(watersheds(PlotLimits.iMin:PlotLimits.iMax,PlotLimits.jMin:PlotLimits.jMax));

surf(tMatTrimmed,xMatTrimmed,hMapTrimmed,surfaceFixed,'FaceAlpha','flat','AlphaData',alphaData(PlotLimits.iMin:PlotLimits.iMax,PlotLimits.jMin:PlotLimits.jMax),'EdgeColor','none');
xlabel('theta')
ylabel('x')
zlabel('y')
axis equal
end
