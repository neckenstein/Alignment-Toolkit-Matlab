function [ rotations ] = getHMapRotations( dims, N )
rotationRange=-pi/2:pi/N:pi/2;
if sum(dims>2)==1
    rotations=zeros(N+1,3);
    rotations(:,dims(dims>2)-2)=rotationRange';
elseif sum(dims>2)==2
    rotations=zeros((N+1)*(N+1),3);
    twoDims=dims(dims>2)-2;
    [a,b]=ndgrid(rotationRange,rotationRange);
    rotations(:,twoDims(1))=a(:);
    rotations(:,twoDims(2))=b(:);
elseif sum(dims>2)==3
    [a,b,c]=ndgrid(rotationRange,rotationRange,rotationRange);
    rotations=[a(:) b(:) c(:)];
else
    error('Inappropriate rotational dims found');
end

end

