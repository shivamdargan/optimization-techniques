clc
clear
format short
a=[3 -1 2; -2 4 0; -4 3 8 ];
b=[7; 12; 10];
c=[-1 3 -2];
v=size(a,2);
s=eye(size(a,1));
A=[a s b];
cost=zeros(1,size(A,2));
cost(1:v)=c;
bv=v+1:1:size(A,2)-1;
zjcj=cost(bv)*A-cost;
zcj=[zjcj;A];
simptable=array2table(zcj);
simptable.Properties.VariableNames(1:size(zcj,2))={'x1','x2','x3','s1','s2','s3','b'};
 RUN=true;
 while RUN
     zc=zjcj(1:end-1)
     if any(zc<0)
        fprintf("the current Bfs is not optimal")
        [Enter_val,pvt_col]=min(zc)
        if all(A(:,pvt_col))<=0
            error("LPP is unbounded all entrie are less than 0 in pivot column \n")
        else
            sol=A(:,end)
            column=A(:,pvt_col)
            for i=1:size(A,1)
                if column(i)>0
                        ratio(i)=sol(i)/column(i)
                    else
                        ratio(i)=inf 
                end
            end
                [leave_var,pvt_row]=min(ratio)
        end
bv(pvt_row)=pvt_col
pvt_key = A(pvt_row,pvt_col);
A(pvt_row,:) = A(pvt_row,:)/pvt_key
for i=1:size(A,1)
    if i~=pvt_row
        A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:)
    end
end
zjcj=zjcj-zjcj(pvt_col).*A(pvt_row,:)
zcj=[zjcj;A]
simptable=array2table(zcj);
simptable.Properties.VariableNames(1:size(zcj,2))={'x1','x2','x3','s1','s2','s3','b'}
    else
        RUN=false;
        fprintf("the current Bfs is optimal")
    end
end