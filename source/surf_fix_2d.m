function ws_fixed=surf_fix_2d(ws_vals)
sz=size(ws_vals);
ws_fixed=ws_vals;
for i=1:sz(1)-1
    for j=1:sz(2)-1
        if ~isequal(ws_vals(i,j),ws_vals(i+1,j),ws_vals(i,j+1),ws_vals(i+1,j+1))
            ws_fixed(i,j)=1;        
        end
    end
end