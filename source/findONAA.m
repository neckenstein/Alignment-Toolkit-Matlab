function [onAA,onAACells]=findONAA(watersheds,resolution)
aaMatching=pointsInAA(watersheds);
[xCells,thetaCells]=size(aaMatching);
nCubeMax = double(aaMatching);
for i=2:xCells
    for j=2:thetaCells
        if nCubeMax(i,j)==1
            nCubeMax(i,j)=min([nCubeMax(i-1,j-1),nCubeMax(i-1,j),nCubeMax(i,j-1)])+1;
        else
            nCubeMax(i,j)=0;
        end
    end
end
onAACells=max(max(nCubeMax));
onAA=onAACells^2*(4*pi)/(resolution)^2;
end