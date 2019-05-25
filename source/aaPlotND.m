function [] = aaPlotND( boolAA )
dims=numel(size(boolAA));
if dims==3
    %Plot all accepted values:
    [xAccepted,yAccepted,zAccepted]=ind2sub(size(boolAA),find(boolAA));
    figure()
    plot3(xAccepted,yAccepted,zAccepted,'.')
    title('Accepted points')
    xlabel('x')
    ylabel('y')
    zlabel('yaw')
end


end

