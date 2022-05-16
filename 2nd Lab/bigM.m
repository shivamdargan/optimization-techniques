clc
clear all
format short

a =[2 1 1 0 0;3 4 0 -1 1];
b = [2;12];
m = 1000
c = [3 2 -m];
A = [a b]
Noofvariables = 2
Noofav = 1
av = 5
bv = [3 5]
cost = zeros(1,size(A,2))
cost(1:Noofvariables) = c(1:Noofvariables) 
cost(av) = c(Noofvariables+1:end)
zjcj = cost(bv)*A - cost
zcj = [zjcj;A]
simptable = array2table(zcj)
simptable.Properties.VariableNames(1:size(A,2)) = {'x1','x2','s1','s2','a1','Solution'}
run = true;
while(run)
    zc = zjcj(1:end-1);
    if any(zc<0)
        fprintf("Current BFS is not optimal.\n")
        [enter_var,pvt_col] = min(zc)
        if all(A(:,pvt_col)<=0)
            error("Solution for the given BFS is unbounded.\n")
        else
            sol=A(:,end)
            column = A(:,pvt_col)
            for i=1:size(A,1)
                if(column(i)>0)
                    ratio(i) = sol(i)/column(i);
                else
                    ratio(i) = inf;
                end
            end
            [leave_var,pvt_row] = min(ratio)
            pvt_key = A(pvt_row,pvt_col)
            bv(pvt_row) = pvt_col;

            A(pvt_row,:) = A(pvt_row,:)./pvt_key;

            for i = 1:size(A,1)
                if(i~=pvt_row)
                    A(i,:) = A(i,:) - A(i,pvt_col).*A(pvt_row,:);
                end
            end    
            zjcj = zjcj - zjcj(pvt_col).*A(pvt_row,:);         
        end
    else
        solution = zjcj(end);
        solutioncol = A(:,end);
        final = [zjcj;A];
        finaltable = array2table(final);
        finaltable.Properties.VariableNames(1:size(A,2)) = {'x1', 'x2', 's1', 's2', 'a1', 'Solution'}
        fprintf("Current BFS is now optimal.\n")
        run = false;
    end
end
if any(solutioncol<0)
    fprintf("The Given LPP has infeasible solution.\n")
else
    fprintf("Solution of the LPP is: ")
    solution
end