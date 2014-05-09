sum=0;
for i=1:10
    tic
    Target(1100,200);
    
    x=toc;
    sum=sum+x;
end

y=sum/10;
sprintf('y= %f', y)