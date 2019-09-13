function new_ws = merge_watersheds_by_depth(points,wsAssignment, tol)
% Uses depth information to merge insufficiently deep watersheds with the
% applicable neighbors. 
% Inputs:
% points - z values for all points in the grid
% wsAssignment - watershed values assignment for all points (1 for no
% watershed, 2 for dam)
% tol - depth tolerance to be considered 'too shallow'
%
mergeMetrics = populate2DMergeMetrics(points,wsAssignment);
%Check watershed depths and merge if possible
checkDepths=1;
while checkDepths
    checkDepths=0;
    %Find remaining watershed ids
    assignmentIds=unique(wsAssignment);
    wsIds=assignmentIds(assignmentIds>2);
    if numel(wsIds)<2
        new_ws=wsAssignment;
        return
    end
    for i=1:size(mergeMetrics,1)
        w=mergeMetrics(i,1);
        neighbor=mergeMetrics(i,2);
        depth=mergeMetrics(i,3);
        if neighbor==1
            %No neighbor, merge with background
            disp('empty neighbor')
            wsAssignment=mergeWatersheds(wsAssignment,[w 1]);
            mergeMetrics(i,:)=[];
            %Check for upstreams and correct neighbor assignments
            if sum(mergeMetrics(:,2)==w)>0
                upstreams=find(mergeMetrics(:,2)==w);
                for u=1:numel(upstreams)
                    mergeMetrics(upstreams(u),2)=1;
                end
            end 
            checkDepths=1;
            break
        elseif w==neighbor && size(mergeMetrics,1)==1
            checkDepths=0;
        elseif depth<=tol && w~=neighbor
            wsAssignment=mergeWatersheds(wsAssignment,[w neighbor]);
            mergeMetrics(i,:)=[];
            %Check for upstreams and correct neighbor assignments
            if sum(mergeMetrics(:,2)==w)>0
                upstreams=find(mergeMetrics(:,2)==w);
                for u=1:numel(upstreams)
                    mergeMetrics(upstreams(u),2)=neighbor;
                end
            end            
            checkDepths=1;
            break
        end
    end
    
end
new_ws=wsAssignment;
end
