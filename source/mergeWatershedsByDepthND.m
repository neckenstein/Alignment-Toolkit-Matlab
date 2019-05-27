function new_ws = mergeWatershedsByDepthND(points,wsAssignment, tol)
% Uses depth information to merge insufficiently deep watersheds with the
% applicable neighbors.
% Inputs:
% points - z values for all points in the grid
% wsAssignment - watershed values assignment for all points (1 for no
% watershed, 2 for dam)
% tol - depth tolerance to be considered 'too shallow'
%

%Check watershed depths and merge if possible
checkDepths=1;
while checkDepths
    checkDepths=0;
    %Find remaining watershed ids
    assignmentIDs=unique(wsAssignment);
    ws_ids=assignmentIDs(assignmentIDs>2);
    if numel(ws_ids)<2
        new_ws=wsAssignment;
        return
    end
    for w=ws_ids'
        [neighbor, depth]=findWSDepthND(points,wsAssignment,w);
        %         if isempty(neighbor)
        %             %No neighbor, merge with background
        %             disp('empty neighbor')
        %             wsAssignment=mergeWS(wsAssignment,w,1);
        %             checkDepths=1;
        %         else
        if depth<=tol
            wsAssignment=mergeWS(wsAssignment,w,neighbor);
            checkDepths=1;
            break
        end
    end
    
end
new_ws=wsAssignment;
end
