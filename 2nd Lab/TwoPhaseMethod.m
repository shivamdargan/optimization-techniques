clc
clear
format short
variables={'x1','x2','s1','s2','A2','sol'};
ovariables={'x1','x2','s1','s2','sol'};
origCost=[5 4 0 0 0 0];
A=[1 1 1 0 0 5; 2 1 0 -1 1 6];
BV=[3 5];

%PHASE 1
fprintf('********* \n Starting Of Phase 1 ********* \n');
cost=[0 0 0 0 -1 0];
[bfs,A]=simp(A,BV,cost,variables)
fprintf('********* \n Phase END ********* \n');

%PHASE 2 
startBV=find(cost<0);
fprintf('********* \n Starting Of Phase 2 ********* \n');
A(:,startBV)=[] 
origCost(:,startBV) = [] 
[optBfs,optA]=simp(A,bfs,origCost,ovariables);
finalBfs=zeros(1,size(A,2))
finalBfs(optBfs) = optA(:,end)
finalBfs(end) = sum(finalBfs.*origCost);
optimalBfs = array2table(finalBfs);
optimalBfs.Properties.VariableNames(1:size(optimalBfs,2))= ovariables;
disp(optimalBfs);
fprintf('********* Phase END ********* \n');