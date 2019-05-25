function [ priorityQueue,HeightMap ] = assignMinimaWS( HeightMap )
priorityQueue=[];
ptsSize=size(HeightMap.height);
%Create neighbor lookup table and find minima
HeightMap.neighbors=cell(ptsSize);
wsNum=3;
%Vectorized search for minima
for i=1:numel(HeightMap.height)
    currentSub=cell(1,numel(ptsSize));
    [currentSub{:}]=ind2sub(ptsSize,i);
    
    indAdjacent=findNeighborsND(cell2mat(currentSub),ptsSize);
    HeightMap.neighbors{currentSub{:}}=indAdjacent;
    
    adjPoints=findAdjacentHeights(HeightMap.height,indAdjacent);
    adjPoints=sortrows(adjPoints,1);
    minAdj=adjPoints(1);
    
    if HeightMap.height(currentSub{:})<minAdj
        %If lower than all HeightMap.neighbors, it's a min
        HeightMap.watersheds(currentSub{:})=wsNum;
        HeightMap.checked(currentSub{:})=1;
        priorityQueue=vertcat(priorityQueue,adjPoints);
        wsNum=wsNum+1;
    elseif HeightMap.height(currentSub{:})==minAdj
        %If equal to the min, we have a plateau condition
        %If any equivalent neighbor is a ws, take the same one.
        removeAH=[];
        equivalentWatersheds=[];
        for ah=1:size(adjPoints,1)
            if adjPoints(ah,1)==minAdj
                %Merge HeightMap.watersheds
                
                ws=HeightMap.watersheds(adjPoints(ah,2),adjPoints(ah,3),adjPoints(ah,4));
                
                if ws>1
                    HeightMap.watersheds(currentSub{:})=ws;
                    HeightMap.checked(currentSub{:})=1;
                    removeAH=[removeAH,ah];
                    equivalentWatersheds =[equivalentWatersheds,ws];
                end
            end
        end
        if isempty(removeAH)
            %New watershed
            HeightMap.watersheds(currentSub{:})=wsNum;
            HeightMap.checked(currentSub{:})=1;
            wsNum=wsNum+1;
        else
            %Merge equivalent HeightMap.watersheds
            minEqWS=min(equivalentWatersheds);
            for eqWS=1:numel(equivalentWatersheds)
                current_ws=equivalentWatersheds(eqWS);
                HeightMap.watersheds(HeightMap.watersheds==current_ws)=minEqWS;
            end
            %Add non-equivalent HeightMap.neighbors to queue
            adjPoints(removeAH,:)=[];
        end
        priorityQueue=vertcat(priorityQueue,adjPoints);
        
    end
end

%Clean up priority queue
priorityQueue=unique(priorityQueue,'rows');
indicesChecked=[];
for i=1:size(priorityQueue,1)    
    pqCell=num2cell(priorityQueue(i,2:end));
    if HeightMap.checked(pqCell{:})
        indicesChecked=[indicesChecked;i];
    end
end
priorityQueue(indicesChecked,:)=[];

end
function adjHeights = findAdjacentHeights(heights, adjacents)
adjHeights=[];
for i=1:size(adjacents,1)
    adjCell=num2cell(adjacents(i,:));
    adjHeight=heights(adjCell{:});
    adjHeights=[adjHeights;[adjHeight adjacents(i,:)]];
end
end
