function boundary = findWSBoundaryND(wsAssignments,ws)

DIMS=numel(size(wsAssignments));

convSize=num2cell(3*ones(1,DIMS));

%Get all points in the watershed
isInWS=wsAssignments==ws;
%Get points on dams between watersheds
%Expand ws outward one space
expandedInWS=convn(double(isInWS),ones(convSize{:}),'same');
expandWSAssign=wsAssignments.*double(expandedInWS>0);
%Want points on the dams, marked as 2
damsPoints=expandWSAssign==2;

%Also any points on edge of ws with no dam neighbor
edges=double(expandedInWS)<3^DIMS;
edgesInWS=edges & isInWS;
damsNeighbors = convn(double(damsPoints),ones(convSize{:}),'same')>0;
edgesNoDamNeighbor= edgesInWS & ~damsNeighbors;

%boundary = edgesNoDamNeighbor | damsPoints;
boundary = damsPoints;
end
