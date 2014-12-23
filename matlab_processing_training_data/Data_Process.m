Close_diff(1)=0;
%Close_diff(2)=0;
movement(1)=-1;
%movement(2)=-1;
B1=zeros(size(B));
for i = 1:length(Close)-1
    B1(i+1,:)=B(i+1,:)-B(i,:)
    if B1(i+1,1)>0
        movement(i+1)=1;
    else
        movement(i+1)=-1;
    end

end
for i =length(B1(1,:))-1:-1:2
    B1(i+1,1)=B1(i,1);
    movement(i+1)=movement(i);
end
Close_diff=Close_diff.';
movement=movement.';
% for i=1:length(B1(1,:))
%     while(B1(1,i)<1||B1(1,i)>10)
%         if B1(1,i)<1
%             B1(:,i)=B1(:,i)*10;
%         end
%         if B1(1,i)>10
%             B1(:,i)=B1(:,i)/10;
%         end
%     end
% end
