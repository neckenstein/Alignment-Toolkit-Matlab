function [new_ws] = merge_dams(points,ws_assignment)
% Finishing step for finding AA. Points between watersheds should be
% assigned based on which has the steepest descent.
%
% Inputs:
% points - z values of each point
% ws_assignment - watershed values assignment - 1's represent no
% assignment, 2's represent dams, 3+'s represent unique watersheds
%
% Outputs: new_ws - ws_assignment with all 2's reassigned.
new_ws=ws_assignment;
dam_points=find(ws_assignment==2);
%Sort from low-high
dam_points=[dam_points points(dam_points)];
dam_points=sortrows(dam_points,2);
dam_points=dam_points(:,1);

[x_size,y_size]=size(ws_assignment);
%Loop through each 
for d_p=dam_points'
    %Find neighbors
    
    neighbors=[d_p+1 d_p-1 d_p-x_size d_p-x_size-1 d_p-x_size+1 d_p+x_size d_p+x_size+1 d_p+x_size-1];
    neighbors = neighbors(neighbors>0 & neighbors<=x_size*y_size);
    %Determine which has steepest descent
    steepest=0;
    ws_d_p=2;    
    for n=neighbors

       zDist=points(d_p)-points(n);
%        xDist=x_mat(d_p)-x_mat(n)
%        tDist=t_mat(d_p)-t_mat(n)
%        findDescent(d_p,n,points)
       if abs(d_p-n)==x_size
           xDist=1;
           tDist=0;
       elseif (abs(d_p-n)==x_size-1) ||(abs(d_p-n)==x_size+1)
           xDist=1;
           tDist=1;
       elseif abs(d_p-n)==1
           tDist=1;
           xDist=0;
       end

       descent=zDist/(xDist^2+tDist^2)^0.5;
       if descent>steepest && ws_assignment(n) >2
           steepest=descent;           
           ws_d_p=ws_assignment(n);
       end
    end        
    
    %Reassign that point
    new_ws(d_p)=ws_d_p;
end
