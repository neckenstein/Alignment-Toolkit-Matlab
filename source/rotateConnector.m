function rotatedConnector = rotateConnector(connector, rotationMatrix)
rotatedConnector=PolyUnion();
for i=1:connector.Num
    rotatedPart=connector.Set(i)*rotationMatrix;
    rotatedConnector.add(rotatedPart);
end
end