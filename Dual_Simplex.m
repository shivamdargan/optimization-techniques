clc
clear all
format short
%To input parameters
C=[-1 -1 -1 0 0 5 ]
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