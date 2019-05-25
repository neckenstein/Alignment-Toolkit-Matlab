function watersheds = flooding_solver_2d(heights,opts)
% Generates an initial flooding solution, unmerged, with dams.
% Inputs: points - height values, in a matrix
% opts: Single string, use '8adj' for 8-adjacency, all other values give
% 4-adjacency
%
% Outputs: watersheds - matrix same size as points, with watershed values
% instead of heights. 1= background/not a watershed, 2= dams, 3+ = unique
% watersheds
%

if strcmp(opts,'8adj')
    ADJACENCY_FLAG=1;
else
    ADJACENCY_FLAG=0;
end

gridSize=size(heights);

watersheds=ones(gridSize);
checked=zeros(gridSize);
priorityQueue=[];

%Create neighbor lookup table and find minima
neighbors=cell(gridSize);
watershedValue=3;

for i=1:gridSize(1)
    for j=1:gridSize(2)
        
        adjPoints=getAdjacentPoints([i j],heights,ADJACENCY_FLAG);

        minAdjacent=adjPoints(1,3);
        if heights(i,j)<minAdjacent
            %If lower than all neighbors, it's a min
            watersheds(i,j)=watershedValue;
            watershedValue=watershedValue+1;
            checked(i,j)=1;
            priorityQueue=vertcat(priorityQueue,adjPoints);            
        elseif heights(i,j)==minAdjacent
            %If equal to the min, we have a plateau condition
            %If any equivalent neighbor is a ws, take the same one.
            removeNeighbors=[];
            equivalentWatersheds=[];
            for ah=1:size(adjPoints,1)
                if adjPoints(ah,3)==minAdjacent
                    if watersheds(adjPoints(ah,1),adjPoints(ah,2))>1
                        watersheds(i,j)=watersheds(adjPoints(ah,1),adjPoints(ah,2));
                        checked(i,j)=1;
                        removeNeighbors=[removeNeighbors,ah];
                        equivalentWatersheds =[equivalentWatersheds,watersheds(adjPoints(ah,1),adjPoints(ah,2))];
                    end
                end
            end
            if isempty(removeNeighbors)
                %New watershed
                watersheds(i,j)=watershedValue;
                checked(i,j)=1;
                watershedValue=watershedValue+1;
            else
                %Merge equivalent watersheds
                min_eq_ws=min(equivalentWatersheds);
                for eq_ws=1:numel(equivalentWatersheds)
                   current_ws=equivalentWatersheds(eq_ws);
                   watersheds(watersheds==current_ws)=min_eq_ws;
                end
                %Add non-equivalent neighbors to queue
                adjPoints(removeNeighbors,:)=[];
            end
            priorityQueue=vertcat(priorityQueue,adjPoints);
        end
    end
end

%Work through priority queue
i=0;
while size(priorityQueue,1)>0
    i=i+1;
    
    %Find highest priority entry (lowest height)
    %Sort by lowest
    priorityQueue=sortrows(unique(priorityQueue,'rows'),3);
    %Pop lowest entry from queue
    lowestPoint=priorityQueue(1,:);
    priorityQueue(1,:)=[];
    %Find (marked so far) watersheds of neighbors
    lowPointNeighbors=getAdjacentPoints(lowestPoint(1:2),heights,ADJACENCY_FLAG);
    %lowPointNeighbors=neighbors{lowestPoint(1),lowestPoint(2)};
    checked(lowestPoint(1),lowestPoint(2))=1;
    neighborWatersheds=[];
    %For each neighbor,
    for n=1:size(lowPointNeighbors,1)
        nWatershed=watersheds(lowPointNeighbors(n,1), lowPointNeighbors(n,2));
        %If it has a marked watershed, take a note
        if nWatershed>2
            descent=getDescent(lowPointNeighbors(n,:),lowestPoint);            
            neighborWatersheds=[neighborWatersheds;descent nWatershed];
        end
        %if it's not marked and HIGHER than this point it should be added to priority queue
        
        if ~isChecked(checked,lowPointNeighbors(n,:)) && lowPointNeighbors(n,3)>= lowestPoint(3)
            priorityQueue=[priorityQueue;[lowPointNeighbors(n,1) lowPointNeighbors(n,2) lowPointNeighbors(n,3)]];
        end
        
    end
    %If only one marked neighbor, take its mark
    neighborWatersheds=unique(neighborWatersheds,'rows');
    neighborWatersheds=sortrows(neighborWatersheds);
    nonBackground = unique(neighborWatersheds(:,2));
    nonBackground(ismember(nonBackground,1))=[];
    if neighborWatersheds(1,2)==1
        %If steepest descent neighbor is unmarked, take that
        watersheds(lowestPoint(1),lowestPoint(2))=1;
    elseif numel(nonBackground)==1
        watersheds(lowestPoint(1),lowestPoint(2))=nonBackground;
    else
        %Dam construction
        watersheds(lowestPoint(1),lowestPoint(2))=2;
    end
end



end

function [xyHeight]=getAdjacentPoints(pos,heights,adjacent)
adjacentCells=getAdjacentCells(adjacent,pos);
trimmedCells=trimOutOfBounds(adjacentCells,size(heights));
xyHeight = [];
for point=1:size(trimmedCells,1)
    xPoint=trimmedCells(point,1);
    yPoint=trimmedCells(point,2);
    xyHeight = [xyHeight;[xPoint,yPoint,heights(xPoint,yPoint)]];
end
xyHeight=sortrows(xyHeight,3);
end

function [adjacentCells]=getAdjacentCells(adjacency,pos)
i=pos(1);
j=pos(2);
if adjacency
    iMatrix=repmat([i-1 i i+1]',3,1);
    jMatrix=[repmat(j-1,3,1);repmat(j,3,1);repmat(j+1,3,1)];
    adjacentCells=horzcat(iMatrix,jMatrix);
    adjacentCells(5,:)=[];
else
    adjacentCells =[i+1 j;i-1 j;i j+1;i j-1];
end
end

function pointsToTest=trimOutOfBounds(pointsToTest,gridSize)
%Remove indexes outside border
remove_indices=[];
for i=1:size(pointsToTest,1)
    tooSmall=min(pointsToTest(i,:))<1;
    tooLarge=(pointsToTest(i,1)>gridSize(1) || pointsToTest(i,2)>gridSize(2));
    if tooSmall || tooLarge
        remove_indices=[remove_indices;i];
    end
end
pointsToTest(remove_indices,:)=[];
end



function descent=getDescent(lowestPoint,lowPointNeighbors)
pointShift=abs(lowestPoint(1)-lowPointNeighbors(1))+abs(lowestPoint(2)-lowPointNeighbors(2));
if pointShift ==1
    xyPlaneDist=1;
elseif pointShift ==2
    xyPlaneDist=2^0.5;
else
    error('neighbor too far away')
end
descent = (lowPointNeighbors(3)-lowestPoint(3))/xyPlaneDist;
end


function [answer]=isChecked(checked,point)
if checked(point(1),point(2))
    answer=true;
else
    answer=false;
end
end

