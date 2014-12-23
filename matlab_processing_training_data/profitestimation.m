for i = 1:145
    if movement(i)==s(i)
        gain(i)=1;
    else
        gain(i)=-1;
    end
end

accu_movement(1)=-1;
for i = 2:145
    accu_movement(i)=gain(i)+accu_movement(i-1);
end
plot(accu_movement);