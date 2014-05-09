

%used this to create a grid of probabilities
%(requires that montecarlo be called as a function, you have to modify the
%other file)
results=zeros(5,5);

for i = 0:4
    for j = 0:4
        x = montecarlo(i,j);
        results(i+1,j+1)=x;
    end
end
        
results'