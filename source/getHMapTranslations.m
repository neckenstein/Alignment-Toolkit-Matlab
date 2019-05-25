function [ translations ] = getHMapTranslations(dims,N)
translationRange=-2:4/N:2;
if sum(dims<3)==0
    %Single point offset at 0
    translations=[0 0];
elseif sum(dims<3)==1
    %One-D array of points in the specified dimension
    translationDim=dims(dims<3);
    translations=zeros(N+1,2);
    translations(:,translationDim)=translationRange';
elseif sum(dims<3)==2
    %Two-D array of offsets
    [x,y]=ndgrid(translationRange,translationRange);
    translations=[x(:) y(:)];
else
    error('Inappropriate dims found')
end

