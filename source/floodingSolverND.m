function watershedSolution = floodingSolverND(points)
% Generates an initial flooding solution, unmerged, with dams.
% Inputs: points - height values, in a matrix
% Adjacency is assumed to be full adjacency (i.e. all mixed diagonals)
%
% Outputs: HeightMap.watersheds - matrix same size as points, with watershed values
% instead of heights. 1= background/not a watershed, 2= dams, 3+ = unique
% watersheds
%
ptsSize=size(points);
HeightMap=buildHMap(points);

[priorityQueue,HeightMap]=assignMinimaWS(HeightMap);
numDims=numel(size(points));
%Work through priority queue
i=0;
while size(priorityQueue,1)>0
    i=i+1;
    %Find highest priority entry (lowest height)
    %Sort by lowest
    priorityQueue=sortrows(unique(priorityQueue,'rows'),1);
    %Pop lowest entry from queue   
    lowInd=num2cell(priorityQueue(1,2:end));
    priorityQueue(1,:)=[];
    %Find (marked so far) HeightMap.watersheds of HeightMap.neighbors
    lpNeighbors=HeightMap.neighbors{lowInd{:}};
    lowestHeight=points(lowInd{:});
    HeightMap.checked(lowInd{:})=1;
    neighborWatersheds=[];
    
    %For each neighbor,
    for n=1:size(lpNeighbors,1)
        lpNeighborInd=num2cell(lpNeighbors(n,:));
        nWatershed=HeightMap.watersheds(lpNeighborInd{:});
        %If it has a marked watershed, take a note
        if nWatershed>1
            indexDistToNeighbor=sum(abs([lowInd{:}]-[lpNeighborInd{:}]));
            if indexDistToNeighbor >numDims
                error('neighbor too far away')
            else
                distToNeighbor=indexDistToNeighbor^0.5;
            end
            descent = (points(lpNeighborInd{:})-lowestHeight)/distToNeighbor;
            neighborWatersheds=[neighborWatersheds;descent nWatershed];
        end
        %if it's not marked and HIGHER than this point it should be added to priority queue
        if HeightMap.checked(lpNeighborInd{:})==0 && points(lpNeighborInd{:})>= lowestHeight
            priorityQueue=[priorityQueue;[points(lpNeighborInd{:}) cell2mat(lpNeighborInd)]];
        end
    end
    %Determine neighboring marks
    neighborWatersheds=unique(neighborWatersheds,'rows');
    neighborWatersheds=sortrows(neighborWatersheds);
    nonBgWatersheds = unique(neighborWatersheds(:,2));
    nonBgWatersheds(ismember(nonBgWatersheds,1))=[];
    %Remove dams from consideration unless no other marks are present
    if numel(nonBgWatersheds)>1 && ismember(2,nonBgWatersheds)
        nonBgWatersheds(ismember(nonBgWatersheds,2))=[];
        neighborWatersheds(ismember(nonBgWatersheds,2),:)=[];
    end
    
    if neighborWatersheds(1,2)==1
        %If steepest descent neighbor is unmarked, take that
        HeightMap.watersheds(lowInd{:})=1;
    elseif numel(nonBgWatersheds)==1
        HeightMap.watersheds(lowInd{:})=nonBgWatersheds;
    else
        %         %Remove non-descending options and check again
        %         neighborWatersheds(neighborWatersheds(:,1)>=-zero_tol,:)=[];
        %         nonBgWatersheds = unique(neighborWatersheds(:,2));
        %         nonBgWatersheds(ismember(nonBgWatersheds,1))=[];
        %         if numel(nonBgWatersheds)==1
        %             HeightMap.watersheds(lowInd(1),lowInd(2),lowInd(3))=nonBgWatersheds;
        %         else
        %Dam construction
        HeightMap.watersheds(lowInd{:})=2;
        %         end
    end
    
end
uniq_ws=unique(HeightMap.watersheds);
if numel(uniq_ws)>100*numDims
    error ('likely too many HeightMap.watersheds');
elseif ismember(uniq_ws,1)
    error ('watershed selection incomplete')
end
watershedSolution = HeightMap.watersheds;
end



function hMap = buildHMap(points)
pSize = size(points);
hMap.height=points;
hMap.watersheds=ones(pSize);
hMap.checked=zeros(pSize);
end