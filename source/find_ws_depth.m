function [neighboring_ws,depth] = find_ws_depth(points,ws_assignment,ws)
%Find boundary points
boundary_logical=findWSBoundary(ws_assignment,ws);

%Find lowest boundary point value and index
boundary_z=points.*boundary_logical;
lowest_boundary_z=min(min(points(boundary_logical)));
[row_i,row_j]=find(boundary_z==lowest_boundary_z);
row_i=row_i(1);
row_j=row_j(1);

%Find which watershed neighbors along this boundary
neighborhood_lowest=zeros(size(ws_assignment));
neighborhood_lowest(row_i,row_j)=1;
neighborhood_lowest=conv2(neighborhood_lowest,ones(3,3),'same');
all_ws_in_neighborhood=unique(neighborhood_lowest.*ws_assignment);
exclude_vals=[0;1;2;ws];
all_ws_in_neighborhood(ismember(all_ws_in_neighborhood,exclude_vals))=[];
if ~isempty(all_ws_in_neighborhood)
neighboring_ws=all_ws_in_neighborhood(1);
else
    neighboring_ws=1;
end

%Find lowest point completely
lowest_z=min(min(points(ws_assignment==ws)));

depth=lowest_boundary_z-lowest_z;

end
