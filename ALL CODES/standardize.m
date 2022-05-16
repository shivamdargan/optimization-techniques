format short
a=[2 3 4; 1 5 2; 2 4 3]
b=[1; 8; 4]
c=[1; 3; 7]
s=eye(size(a,1))
i=[0; 0; 1]
index= find(i==1)
s(index,index)=-s(index,index)
mat=[a s b]
obj=array2table(mat);
obj.Properties.VariableNames(1:size(mat,2))={'x1','x2','x3','s1','s2','s3','b'}
