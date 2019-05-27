function [newWS] = mergeDamsND(points,wsAssignment)
% Finishing step for finding AA. Points between watersheds should be
% assigned based on which has the steepest descent.
%
% Inputs:
% points - z values of each point
% wsAssignment - watershed values assignment - 1's represent no
% assignment, 2's represent dams, 3+'s represent unique watersheds
%
% Outputs: newWS - wsAssignment with all 2's reassigned.
DIMS=numel(size(wsAssignment));
newWS=wsAssignment;
indices=cell(1,DIMS);
[indices{:}]=ind2sub(size(wsAssignment),find(wsAssignment==2));

damPoints=getSortedDamPoints(indices,points,DIMS);

%Loop through each
for ptIndex=1:size(damPoints,1)
    %Find neighbors    
    neighbors = findNeighborsND(damPoints(ptIndex,1:DIMS),size(points));
    damPointInd=num2cell(damPoints(ptIndex,1:DIMS));
    %neighbors = neighbors(neighbors>0 & neighbors<=x_size*y_size);
    %Determine which has steepest descent
    steepest=0;
    wsDP=2;
    neighborWS=zeros(size(neighbors,1),1);

    for n=1:size(neighbors,1)
        neighborInd=num2cell(neighbors(n,:));
        neighborWS(n)=wsAssignment(neighborInd{:});
        
        riseDist=points(damPointInd{:})-points(neighborInd{:});
        runDist = sum((damPoints(ptIndex,1:DIMS)-neighbors(n,1:DIMS)).^2)^0.5;        
        descent=riseDist/runDist;
        
        if descent>steepest && wsAssignment(neighborInd{:})~=2
            steepest=descent;
            wsDP=wsAssignment(neighborInd{:});
        end
    end
    if steepest==0 && numel(neighborWS>2)>0
        wsDP=neighborWS(1);
    end
    
    %Reassign that point
    newWS(damPointInd{:})=wsDP;
end

function damPoints = getSortedDamPoints(indices,points,DIMS)
damPoints=zeros(size(indices{1},1),DIMS+1);
for ind=1:numel(indices{1})
    damPointInd=zeros(1,DIMS);
    for d=1:numel(indices)
        damPointInd(d)=indices{d}(ind);
    end
    damPointCell=num2cell(damPointInd);
    damPoints(ind,:)=[damPointInd points(damPointCell{:})];
end

damPoints=sortrows(damPoints,DIMS+1);
