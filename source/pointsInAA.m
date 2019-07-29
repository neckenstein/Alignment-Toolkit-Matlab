function [aaMatching]=pointsInAA(watersheds)
aaWatershed=findWatershedOfInterest(watersheds);
aaMatching=watersheds==aaWatershed;
end
function [watershed]=findWatershedOfInterest(watersheds)
wsSize=size(watersheds);
tCenter=floor((wsSize(1)+1)/2);
xCenter=floor((wsSize(2)+1)/2);
watershed=watersheds(tCenter,xCenter);
end