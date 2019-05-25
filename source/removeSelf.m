function neighbors=removeSelf(point,neighbors)
removeIndices=[];
for i=1:size(neighbors,1)
    if min(neighbors(i,:)==point)==1
        removeIndices=[removeIndices;i];
    end
end
neighbors(removeIndices,:)=[];
end
