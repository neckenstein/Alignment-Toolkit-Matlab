function [ neighbors ] = findNeighborsND( point, gridSize )

for i=1:numel(point)
    if point(i)==1
        pointNeighborArray{i}=[point(i),point(i)+1];
    elseif point(i)==gridSize(i)
        pointNeighborArray{i}=[point(i)-1,point(i)];
    else
        pointNeighborArray{i}=[point(i)-1,point(i),point(i)+1];        
    end
end
neighbors=indicesAllCombinations(pointNeighborArray);
neighbors=removeSelf(point,neighbors);

end


