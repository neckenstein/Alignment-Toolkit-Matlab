function connPair=get3DPyramidConnector(DesignParams)
R=Polyhedron([0 0 -DesignParams.aspectRatio; -1 0 -DesignParams.aspectRatio;0 -1 -DesignParams.aspectRatio; -1 -1 -DesignParams.aspectRatio;-0.5 -0.5 0]);
B1=Polyhedron([0 0 0.5+DesignParams.aspectRatio; 1 0 0.5+DesignParams.aspectRatio; 0.5 0.5 0.5;0.5 0.5 0;0 0 0;1 0 0]);
B2=Polyhedron([0 0 0.5+DesignParams.aspectRatio; 0 1 0.5+DesignParams.aspectRatio; 0.5 0.5 0.5;0.5 0.5 0;0 0 0;0 1 0]);
B3=Polyhedron([1 1 0.5+DesignParams.aspectRatio; 1 0 0.5+DesignParams.aspectRatio; 0.5 0.5 0.5;0.5 0.5 0;1 1 0;1 0 0]);
B4=Polyhedron([1 1 0.5+DesignParams.aspectRatio; 0 1 0.5+DesignParams.aspectRatio; 0.5 0.5 0.5;0.5 0.5 0;1 1 0;0 1 0]);
%Recentering B1 and B2
center_B=0.5*(max([B1.V;B2.V;B3.V;B4.V])+min([B1.V;B2.V;B3.V;B4.V]));
B1=B1-center_B;
B2=B2-center_B;
B3=B3-center_B;
B4=B4-center_B;
%Recentering R
V_all=R.V;
max_v=max(V_all);
min_v=min(V_all);
center_of_rotation = 0.5*(max_v+min_v);
center_of_rotation(3)=min_v(3)+DesignParams.rotationCenter*(max_v(2)-min_v(2));
R_init=R-center_of_rotation;
connPair.connector1=PolyUnion(R_init);
connPair.connector2=PolyUnion([B1 B2 B3 B4]);
end