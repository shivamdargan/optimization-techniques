function [BFS,A] = simp(A,BV,cost,variables )
zjcj=cost(BV)*A - cost;
RUN=true;
 while RUN
     zc=zjcj(1:end-1);
     if any(zc<0)
        fprintf("the current Bfs is not optimal")
        [Enter_val,pvt_col]=min(zc);
        if all(A(:,pvt_col))<=0
            error("LPP is unbounded all entrie are less than 0 in pivot column \n")
        else
            sol=A(:,end); %last column
            column=A(:,pvt_col);
            for i=1:size(A,1)
                if column(i)>0
                        ratio(i)=sol(i)/column(i);
                    else
                        ratio(i)=inf;
                end
            end
                [leave_val,pvt_row]=min(ratio);
        end
BV(pvt_row)=pvt_col; 
pvt_key = A(pvt_row,pvt_col);
A(pvt_row,:) = A(pvt_row,:)./pvt_key;
for i=1:size(A,1)
    if i~=pvt_row
        A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
    end
end
zjcj=zjcj-zjcj(pvt_col).*A(pvt_row,:);
zcj=[zjcj;A];
simptable=array2table(zcj);
simptable.Properties.VariableNames(1:size(zcj,2))= variables;
BFS(BV)=A(:,end);
    else
        RUN=false;
        fprintf("\nthe current Bfs is optimal")
        BFS=BV;
    end
 end
