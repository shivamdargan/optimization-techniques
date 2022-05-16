function output = contraint(x) 
format rat
x1=x(:,1);
x2=x(:,2);
cons1=round(x1+(2.*x2)-10);
s1=find(cons1>0); %FOR POINTS IN THE FIRST QUADRANT HENCE THIS LINE
x(s1,:)=[];

x1=x(:,1);
x2=x(:,2);
cons2=round(x1+x2-6);
s1=find(cons2>0);
x(s1,:)=[];

x1=x(:,1);
x2=x(:,2); 
cons3=round(x1-(2.*x2)-1);
s1=find(cons3>0);
x(s1,:)=[];
output=x;
end

