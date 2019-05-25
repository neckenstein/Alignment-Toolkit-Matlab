function [heightMap]=generateHeightMap(Offsets,polys)
heightMap=-10*ones(numel(Offsets.tSet),numel(Offsets.xSet));
for iTheta=1:numel(Offsets.tSet)
    rotatedR=rotatePolygon(Offsets.tSet(iTheta),polys.centeredR);
    %Simple 3d minkowski sum with rotated Rs
    sliceUnion=PolyUnion([rotatedR+polys.B1 rotatedR+polys.B2]);
    
    %Sample polyhedra to get points grid
    for x=1:numel(Offsets.xSet)
        topSurfacePoint=NaN;
        lineFromSlice=sliceUnion.slice([1],[Offsets.xSet(x)]);
        if isa(lineFromSlice,'PolyUnion') && lineFromSlice.Num>0
            slice_Vs=vertcat(lineFromSlice.Set.V);
            if numel(slice_Vs)>0
                topSurfacePoint=max(slice_Vs);
            end
        end
        if ~isnan(topSurfacePoint)
            heightMap(iTheta,x)=topSurfacePoint;
        end
    end
end
heightMap=round(heightMap,12);
end

function [rotatedPolygon]=rotatePolygon(theta,polygon)
rotationMatrix=[cos(theta) -sin(theta);sin(theta) cos(theta)];
rotatedPolygon=polygon*rotationMatrix;
end