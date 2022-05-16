clc
clear all
format short
c = [2 3 11 7; 1 1 6 1; 5 8 15 9];
b = [7 5 8 2];
a = [6 6 10];
if(sum(a)== sum(b))
    fprintf('The Transportaion Problem Is Balanced');
else
    fprintf('The Transportation Problem Is Unbalanced');
    if(sum(a) < sum(b))
        c(end+1,:) = zeros(size(c,2));
        a(end+1,:)= sum(b)-sum(a);
    else
        c(:, end+1) = zeros(size(c,1));
        b(:,end+1)= sum(b)-sum(a);
    end
end
InitalCost = c;
x = zeros(size(c));
for i = 1:size(c,1)
    for j=1:size(c,2)
        Cpq = min(c(:));
        if(Cpq == inf)
            break
        end
       [p1,q1] = find(Cpq==c)
       xpq = min(a(p1),b(q1))
       [val, ind] = max(xpq);
       x(p1(ind),q1(ind)) = val;
       p = p1(ind)
       q = q1(ind)
       b(q) = b(q) -val;
       a(p) = a(p) - val;
       c(p,q) = inf;
    end
end
IB = array2table(x);
fprintf('Initial BFS Solution is = \n');
disp(IB);
ibfs = sum(sum(InitalCost.*x));
fprintf('Initial BFS Solution Cost Is = %d \n',ibfs);