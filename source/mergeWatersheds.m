function mergedWatersheds = mergeWatersheds(wsAssignment,watersheds)
newWs = min(watersheds);
%Find each boundary
boundShared = findSharedWSBoundary(wsAssignment, watersheds);
newIndex = (wsAssignment==watersheds(1) | wsAssignment==watersheds(2)) | boundShared;
mergedWatersheds = wsAssignment;
mergedWatersheds(newIndex) = newWs;
end
function [shared] = findSharedWSBoundary(wsAssignment, watersheds)
bound1 = findWSBoundary(wsAssignment, watersheds(1));
bound2=findWSBoundary(wsAssignment, watersheds(2));
shared = and(bound1, bound2);
end