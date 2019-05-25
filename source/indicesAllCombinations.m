function [pointsVector] = indicesAllCombinations(indCells)
%Given a cell array of i cells, scan each cell and give i-dimensional
%points that are made from the values contained in those cells. Assume we
%have between 2 and 6 dimensions.
if numel(indCells) == 2
    [grid1, grid2] = ndgrid(indCells{1},indCells{2});
    pointsVector = [grid1(:) grid2(:)];
elseif numel(indCells) == 3
    [grid1, grid2, grid3] = ndgrid(indCells{1}, indCells{2}, indCells{3});
    pointsVector = [grid1(:) grid2(:) grid3(:)];
elseif numel(indCells) == 4
    [grid1, grid2, grid3, grid4] = ndgrid(indCells{1}, indCells{2},...
                                          indCells{3}, indCells{4});
    pointsVector = [grid1(:) grid2(:) grid3(:) grid4(:)];
elseif numel(indCells)==5    
    [grid1, grid2, grid3, grid4, grid5] = ...
    ndgrid(indCells{1}, indCells{2},indCells{3}, indCells{4}, indCells{5});
    pointsVector = [grid1(:) grid2(:) grid3(:) grid4(:) grid5(:)];
elseif numel(indCells)==6
    [grid1, grid2, grid3, grid4, grid5, grid6] = ...
    ndgrid(indCells{1}, indCells{2},indCells{3},...
           indCells{4}, indCells{5},indCells{6});
    pointsVector = [grid1(:) grid2(:) grid3(:) grid4(:) grid5(:) grid6(:)];
end

