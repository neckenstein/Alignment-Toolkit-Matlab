function [mergeMetrics]=populate2DMergeMetrics(heightMap,watersheds)
watershedIds=unique(watersheds); 
mergeMetrics=zeros(numel(watershedIds)-1,5); %'Merge metrics' and neighbors
for i=2:numel(watershedIds)
    [neighbor, depth]=find_ws_depth(heightMap,watersheds,watershedIds(i));
    [neighbor2, volume]=find_ws_volume(heightMap,watersheds,watershedIds(i));
    surface = nnz(watersheds==watershedIds(i));    
    mergeMetrics(i-1,:)=[double(watershedIds(i)) double(neighbor) depth surface volume];    
end
end