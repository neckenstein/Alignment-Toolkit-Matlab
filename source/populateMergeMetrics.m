function mergeMetrics=populateMergeMetrics(heights,ws)
%Determines eligible neighbors for merging as well as depth & surface
%area metrics
wsIDs=unique(ws);
mergeMetrics=double(zeros(numel(wsIDs)-1,4));

for i=2:numel(wsIDs)
    [neighbor, depth]=findWSDepthND(heights,ws,wsIDs(i));
    surface = nnz(ws==wsIDs(i));
    mergeMetrics(i-1,1)=wsIDs(i);
    mergeMetrics(i-1,2)=neighbor;
    mergeMetrics(i-1,3)=depth;
    mergeMetrics(i-1,4)=surface;
end
end