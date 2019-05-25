function mergedWSAssignment = mergeWS(wsAssignment,ws1,ws2)
%Use lower value of the two
newWS=min(ws1,ws2);
%Find boundary of ws1 and ws2
bound1=findWSBoundaryND(wsAssignment,ws1);
bound2=findWSBoundaryND(wsAssignment,ws2);
boundShared = and(bound1,bound2);
pointsInNewWS=(wsAssignment==ws1 | wsAssignment==ws2) | boundShared;
mergedWSAssignment=wsAssignment;
mergedWSAssignment(pointsInNewWS)=newWS;
end

