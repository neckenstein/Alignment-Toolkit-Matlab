function mergeMetrics=populateMergeMetrics(heights,ws)
%Determines eligible neighbors for merging as well as depth & surface
%area metrics
wsIDs=unique(ws);
mergeMetrics=zeros(numel(wsIDs)-1,4);

for i=2:numel(wsIDs)
    [neighbor, depth]=findWSDepthND(heights,ws,wsIDs(i));
    surface = nnz(ws==wsIDs(i));
    mergeMetrics(i-1,:)=[wsIDs(i) neighbor depth surface];
end
end