function [ heightMap ] = getHeightMap(dims, N, connPair, offsets )

heightsArray=[];
pointsArray=[];
for t=1:size(offsets.rotations,1)
    
    rotationMatrix=rotMatFromRPY(offsets.rotations(t, 1), offsets.rotations(t, 2), offsets.rotations(t, 3));
    conn1Rotated=rotateConnector(connPair.connector1, rotationMatrix);    
    U=minkowskiSumPolyUnion(conn1Rotated,connPair.connector2);    
    %Get the points required by N
    for x=1:size(offsets.translations,1)
        height=getHeightAtPoint(U, offsets.translations(x,:));
        heightsArray=[heightsArray; height];
        pointsArray=[pointsArray; [offsets.translations(x,:) offsets.rotations(t,:)]];        
    end
end

dims=sort(dims);   
heightMapDims=(N+1)*ones(1,numel(dims));
heightMap=-10*ones(heightMapDims);

heightMap(:)=round(heightsArray,8);

end

