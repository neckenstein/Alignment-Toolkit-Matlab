function depthTolerance = findDepthTolerance(depthTolFactor,heightMap)
depthTolerance = depthTolFactor*(max(heightMap(:))-min(heightMap(:)));
end