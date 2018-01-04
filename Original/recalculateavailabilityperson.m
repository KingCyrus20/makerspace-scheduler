function y = recalculateavailabilityperson(x)

y=0;
[dimension,~]=size(x);
for i=1:dimension
    y(i)=sum(x(i,:));
end
        
end