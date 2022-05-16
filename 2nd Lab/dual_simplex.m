clear all
clc 
format short
c = [-2 0 -1 0 0 0]
A = [-1 -1 1 1 0 -5; -1 2 -4 0 1 -8]
bv = [4,5]
cost = zeros(1, size(A,2))
cost(1:6) = c
zjcj = cost(bv)*A - cost
zcj = [zjcj;A]
soln = A(:,end)
run = true
while(run == true)
    if(any(soln<0))
    negIND = find(soln<0)
    [leaving_var, pivot_row] = min(soln(negIND))
    ratio = []
    for i = 1:size(A,2)-1
        if A(pivot_row,i) <0
            ratio(i) = abs(zjcj(i)/A(pivot_row,i))
        else
            ratio(i) = inf;
        end
    end
    [entering_var, pivot_col] = min(ratio)
    pvt_key = A(pivot_row, pivot_col)
    bv(pivot_row) = pivot_col;
    A(pivot_row,:) = A(pivot_row,:)/pvt_key;
    for i = 1 : size(A,1)
        if i ~= pivot_row
              A(i,:) = A(i,:) - (A(i,pivot_col).*A(pivot_row,:));
        end
    end
    zjcj = zjcj - (zjcj(pivot_col).*A(pivot_row,:)) 
    zc = zjcj(1:end-1)
    soln = A(:,end)
    else
        run = false
        fprintf("Current BFS is Optimal")
        zcj = [zjcj;A]
        optimum_simplex_table = array2table(zcj)
        optimum_simplex_table.Properties.VariableNames(1:size(zcj,2)) = {'x1', 'x2', 's1', 's2', 's3', 'soln'}
        optimal_solution = zjcj(end)
        solns = [bv' A(:,end)]
    end
end