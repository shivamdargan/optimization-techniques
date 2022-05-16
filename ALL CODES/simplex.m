%Min z=x1-3x2+2x3
%Subject to 3x1-x2+2x3<=7
%-2x1+4x2<=12
%-4x1+3x2+8x3<=10
%x1,x2,x3>=0
%Max z=-x1+3x2-2x3
clc
clear all
format short
%To input parameters
C=[-1 3 -2]
info=[3 -1 2;-2 4 0;-4 3 8]
b=[7; 12; 10]
NOVariables=size(info,2)
s=eye(size(info,1))
A=[info s b]
Cost=zeros(1,size(A,2))
Cost(1:NOVariables) = C
%To define basic variables
BV=NOVariables+1:size(A,2)-1
%To calculate row
ZRow=Cost(BV)*A-Cost
%To print the table
ZjCj=[ZRow;A]
SimpTable=array2table(ZjCj)
SimpTable.Properties.VariableNames(1:size(ZjCj,2))={'x1','x2','x3','s1','s2','s3','Sol'}
%Simplex Table starts
Run=true;
while(Run)
    ZC=ZRow(1:end-1);
if any(ZRow<0)
    fprintf('The current BFS is not Optimal \n')
    fprintf('\n========The Next Iterations Results========\n')
    disp('Old Basic Variable (BV)=')
    disp(BV)
    %To find entering variable
    ZC=ZRow(1:end-1)
    [EnterCol,Pvt_Col]=min(ZC)
    fprintf('The most negative element in ZRow is %d Corresponding to column %d \n',EnterCol,Pvt_Col)
    fprintf('Entering Variable is %d \n', Pvt_Col)
    %To find Leaving Variable
    sol=A(:,end)
    Column=A(:,Pvt_Col)
    if all(Column<=0)
        error('LPP has unbounded solution')
    else
    for i=1:size(Column,1)
        if Column(i)>0
             ratio(i)=sol(i)./Column(i)
        else
            ratio(i)=inf
        end
    end
    [MinRatio,Pvt_Row]=min(ratio)
    fprintf("Minimum ratio corresponding to Pivot Row is %d \n",Pvt_Row)
    fprintf('Leaving Variable is %d \n',BV(Pvt_Row))
    end
    BV(Pvt_Row)=Pvt_Col;
    disp('New Basic Variable (BV) =')
    disp(BV)
    %Pivot key
    Pvt_Key=A(Pvt_Row,Pvt_Col);
    %Update the table for next iteration
    A(Pvt_Row,:)=A(Pvt_Row,:)./Pvt_Key;
    for i=1:size(A,1)
        if i~=Pvt_Row
            A(i,:)=A(i,:)-A(i,Pvt_Col).*A(Pvt_Row,:);
        end
        ZRow=ZRow-ZRow(Pvt_Col).*A(Pvt_Row,:);
        %To print the table
        ZjCj=[ZRow;A];
        SimpTable=array2table(ZjCj);
        SimpTable.Properties.VariableNames(1:size(ZjCj,2))={'x1','x2','x3','s1','s2','s3','Sol'}
 
        BFS=zeros(1,size(A,2));
        BFS(BV)=A(:,end);
        BFS(end)=sum(BFS.*Cost);
        CurrentBFS=array2table(BFS);
        CurrentBFS.Properties.VariableNames(1:size(CurrentBFS,2))={'x1','x2','x3','s1','s2','s3','Sol'}
    end
else
    Run=false;
    fprintf('======***======\n')
    fprintf('The current BFS is optimal and Optimality is reached\n')
    fprintf('======***======\n')
end
end