clc;clear;clf;
load('B.mat');
alpha=0.05;
x1=zeros(144,1);
x2=zeros(144,1);
for i=1:144
    x1(i)=B(i,3)*B(i,4);
    x2(i)=B(i,5)*B(i,6);
end

Y=zeros(144,1);
Y=B(:,1);
X=[ones(144,1) B(:,2) B(:,3) x1 x2 B(:,7) B(:,8) B(:,9)];
[b, bint, r, rint, stats]=regress(Y,X,alpha);
rcoplot(r,rint);
