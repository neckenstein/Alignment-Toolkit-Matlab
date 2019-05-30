function []=puNoOverlaps(pu)
%
for i=1:pu.Num-1
    puAdd=PolyUnion();
    removeThese=[];
    for j=i+1:pu.Num
        %Find the intersection
        intersection=pu.Set(i).intersect(pu.Set(j));
        if ~intersection.isEmptySet && intersection.volume>0
            %Remove the overlap from the union
            puAdd.add(pu.Set(j)\intersection);
            removeThese=[removeThese j];
        end
    end
    if ~isempty(removeThese)
        pu.remove(removeThese);
    end
    if puAdd.Num>0
    pu.add(puAdd.Set);
    end
end