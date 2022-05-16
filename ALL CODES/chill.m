c=[2 1];

a=[1 2; 1 1; 1 -2];

b=[10;6;1];

x1 = 0:1:max(b)
% a(1,1)x1 + a(1,2)x12 = b(1,1)
x12 = (b(1) - (a(1,1).*x1))./(a(1,2))
x22 = (b(2) - (a(2,1).*x1))./(a(2,2))
x32 = (b(3) - (a(3,1).*x1))./(a(3,2))

plot( x1,x12,'r',x1,x22,'b',x1,x32,'g')

x12 = max(0,x12);
x22 = max(0 ,x22);
x32 = max(0,x32);

plot( x1,x12,'r',x1,x22,'b',x1,x32,'g')

cx1 = find(x1 == 0)
c1 = find(x12 == 0)
l1 = [x1(:,[c1,cx1]),x12(:,[c1,cx1])]'

c2 = find(x22 == 0)
l2 = [x1(:,[c2,cx1]),x22(:,[c2,cx1])]'

c3 = find(x32 == 0)
l3 = [x1(:,[c3,cx1]),x32(:,[c3,cx1])]'

corpt = unique([l1;l2;l3],'rows');
pt = [0 ; 0 ];

for i =1:(size(a,1)-1)
    a1 = a(i,:);
    b1 = b(i,:);
    for j = i+1:size(a,1)
        a2 = a(j, :);
        b2 = b(j, :);
        a4 =[a1;a2];
        b4 =[b1;b2];
        x = a4\b4;
        pt = [pt x];
    end
end

ptt = pt'
allpt = [ptt ; corpts];
points = unique(allpt, 'rows');
PT = contraint(points);
p = unique(PT, 'rows');

for i =1:size(p,1)
    fn(i,:) = sum(p(i,:).*c);
end

ver_fn = [p fn];
[optVal ,optPosition] = max(fn);
optVal = ver_fn(optPosition, :);
optimal_bfs = array2table(optVal);
optimal_bfs.Properties.VariableNames(1:size(optimal_bfs,2)) = {'x1','x2','z'}


