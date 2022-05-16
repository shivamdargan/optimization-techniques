a = [6 4;1 2;-1 1;0 1];
b = [24;6;1;6];
c = [5 4];
Noofvariables = 2;
s = eye(size(a,1));

A = [a s b]

% Number of basic variables:
bv = Noofvariables+1:size(A,2)-1

cost = zeros(1,size(A,2))
cost(1:Noofvariables) = c
zjcj = cost(bv)*A - cost
zcj = [zjcj;A]
simptable = array2table(zcj)
simptable.Properties.VariableNames(1:size(A,2)) = {'x1', 'x2', 's1', 's2', 's3', 's4', 'Solution'}
run = true;
while(run)
    zc = zjcj(1:end-1)
    if any(zc<0)
        fprintf("Current BFS is not optimal")
        [enter_var,pvt_col] = min(zc)
        
        if all(A(:,pvt_col)<=0)
            error("Solution for the given BFS is unbounded")
        else
            sol=A(:,end)
            column = A(:,pvt_col)
            for i=1:size(A,1)
                if(column(i)>0)
                    ratio(i) = sol(i)/column(i)
                else
                    ratio(i) = inf 
                end
            end
            [leave_var,pvt_row] = min(ratio)
            break
        end
    else
        run = false
        fprintf("Current BFS Is Optimal")
        pvt_key = A(pvt_row,pvt_col);
        Bv(pvt_row) = pvt_col;
        A(pvt_row, :) = (A(pvt_row, :)/pvt_key);
        for i=1:size(A,1)
            if( i == pvt_row)
                A(i,:) = A(i,:) - A(i,pvt_col).*A(pvt_row, : );
            end
        end
        zjcj = zjcj - zjcj(pvt_col).*A(pvt_row, : )
    end
end


