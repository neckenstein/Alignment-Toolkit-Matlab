function cellSize = calculateCellSize(Params)
cellSize=1;
for i=1:numel(Params.dimensions)
    if Params.dimensions(i)<3
        cellSize=cellSize*4/Params.resolution;
    elseif Params.dimensions(i)>=3
        cellSize=cellSize*pi/Params.resolution;
    end
end
end
