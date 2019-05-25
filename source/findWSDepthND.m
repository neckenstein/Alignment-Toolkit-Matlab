function [neighboring_ws,depth] = findWSDepthND(points,wsAssignment,ws)
EXCLUDE_VALS=[0;1;2;ws];
ptsSize=size(points);
DIMS=numel(ptsSize);
convSize=num2cell(3*ones(1,DIMS));

%Find boundary points
boundaryLogical=findWSBoundaryND(wsAssignment,ws);
%Find lowest point in the aa, and the lowest boundary point
lowestZ=min(points(wsAssignment==ws));
boundaryZ=points.*boundaryLogical;
boundaryZUnique=unique(boundaryZ(:));
boundaryZUnique(boundaryZUnique==0)=[];
lowestBoundaryZ=min(boundaryZUnique);
%Only valid for r2018b and later...
%lowestZ=min(points(wsAssignment==ws),[],'all');
%lowestBoundaryZ=min(points(boundaryLogical),[],'all');
lowestBoundInd=cell(1,DIMS);
[lowestBoundInd{:}]=ind2sub(size(boundaryZ),find(boundaryZ==lowestBoundaryZ));
for i=1:numel(lowestBoundInd)
    lowestBoundInd{i}=lowestBoundInd{i}(1);
end

%Find which watershed neighbors along this boundary
neighborhoodLowest=zeros(size(wsAssignment));
neighborhoodLowest(lowestBoundInd{:})=1;
neighborhoodLowest=convn(neighborhoodLowest,ones(convSize{:}),'same');
allWSInNeighborhood=unique(neighborhoodLowest.*wsAssignment);

allWSInNeighborhood(ismember(allWSInNeighborhood,EXCLUDE_VALS))=[];
if ~isempty(allWSInNeighborhood)
neighboring_ws=allWSInNeighborhood(1);
else
    neighboring_ws=1;
end


depth=lowestBoundaryZ-lowestZ;

end
