function sum = minkowskiSumPolyUnion(union1,union2)
sum=PolyUnion();
for i=1:union1.Num
    for j=1:union2.Num
    sum.add(union1.Set(i)+union2.Set(j));
    end
end