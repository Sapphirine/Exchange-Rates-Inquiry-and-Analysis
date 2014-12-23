clc;clf;clear;
load('B.mat');
x1=zeros(144,1);
x2=zeros(144,1);
for i=1:144
    x1(i)=B(i,3)*B(i,4);
    x2(i)=B(i,5)*B(i,6);
end
Y=zeros(144,1);
Y=B(:,1);
X=[B(:,2) B(:,3) x1 x2 B(:,7) B(:,8) B(:,9)];
stepwise(X,Y,[1:7]);