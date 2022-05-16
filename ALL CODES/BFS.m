clc 
clear all
format short
 A=[2 3 -1 4  ;1 -2 6 -7 ]
 b=[8 ; -3 ]
 c=[2 3 4 7]
 m=size(A,1) %no of constraints
 n=size(A,2) %no of variables
 if(n>=m)   
   comb=nchoosek(n,m); %gives value of nCm or no. of max basic solutions
   pair=nchoosek(1:n,m) %pairs of basic solution
   sol=[];
   for i=1:comb
       y = zeros(n,1);
       X=A(:,pair(i,:))\b;
       if all(X>=0 & X~=inf)
           y(pair(i,:)) = X
           sol = [sol y];
       end
   end
 else
     error('Equation is large than Variables')
 end
 
 z = c*sol
% To FInd the Optimal Value 
[zmax, zindex] = max(z)
bfsSol = sol(:,zindex)
% To Print all the solutions 
optimal_value = [bfsSol', zmax]
optimal_bfs = array2table(optimal_value)
optimal_bfs.Properties.VariableNames(1:size(optimal_bfs,2)) = {'x1', 'x2','x3', 'x4', 'z'}
 