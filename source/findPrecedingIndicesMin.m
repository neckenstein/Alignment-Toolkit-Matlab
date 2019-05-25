function [indMin] = findPrecedingIndicesMin(index,valueMatrix)
gridSize=size(valueMatrix);
dims=size(gridSize);

for i=1:numel(index)
    if index(i)==1
        indexNeighborArray{i}=[index(i)];
    else
        indexNeighborArray{i}=[index(i)-1,index(i)];
    end
end
neighbors=indicesAllCombinations(indexNeighborArray);
neighbors=removeSelf(index,neighbors);
neighborValues=inf(size(neighbors,1),1);
for i=1:size(neighbors,1)
    neighborInd=num2cell(neighbors(i,:));
    neighborValues(i)=valueMatrix(neighborInd{:});
end
indMin=min(neighborValues);
end

