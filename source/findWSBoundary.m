function boundary = findWSBoundary(wsAssignment,ws)
dams = getExpandedDamPoints(wsAssignment,ws);
edges = edgesNoDam(wsAssignment,ws,dams);
boundary = edges | dams;
end

function [dams]=getExpandedDamPoints(wsAssignment,ws)
inWatershed = wsAssignment==ws;
%Expand ws outward one space
wsExpanded = wsAssignment.*uint8(conv2(double(inWatershed), ones(3,3), 'same')>0);
dams = wsExpanded==2;
end

function [edges]=edgesNoDam(wsAssignment,ws,dams)
inWatershed = wsAssignment==ws;
%Also any points on edge of ws with no dam neighbor
wsEdge = double(conv2(double(inWatershed), [1 1 1;1 1 1; 1 1 1], 'same'))<9;
edgesInWS = wsEdge & inWatershed;
damsNeighbors = conv2(double(dams), [1 1 1;1 1 1; 1 1 1], 'same')>0;
edges = edgesInWS & ~damsNeighbors;
end

