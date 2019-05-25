function [onAACells]=findONAAND(boolAA)
%% Find Oriented N-Cube Area of Acceptance
%Start with truth matrix
onMax = double(boolAA);
ptsSize=size(onMax);
dims=numel(ptsSize);
%Find onAA
for i=1:numel(boolAA)
    thisPointInd=cell(1,dims);
    [thisPointInd{:}]=ind2sub(ptsSize,i);
    if onMax(i)==1
        onMax(i)=findPrecedingIndicesMin([thisPointInd{:}],onMax)+1;
        %onMax(i,j,k)=min([onMax(i-1,j-1,k-1),onMax(i-1,j-1,k),...
            %onMax(i-1,j,k-1),onMax(i,j-1,k-1),...
            %onMax(i,j,k-1),onMax(i,j-1,k),onMax(i-1,j,k)])+1;
    else
        onMax(i)=0;
    end
end
onAACells=max(onMax(:));
end