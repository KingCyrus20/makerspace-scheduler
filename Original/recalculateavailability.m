function y = recalculateavailability(x)

y=0;
for i=1:length(x)
    y(i)=sum(x(:,i));
end
        
end