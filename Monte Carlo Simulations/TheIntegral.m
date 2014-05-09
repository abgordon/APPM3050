% Iterative Integration part 2: a function integrated over area
% Andrew Gordon
% 04/18/14
% APPM 3050


%a similar formula; however, in this case, if the "dart" lands inside we
%calculate the value of the function at that point instead of incrementing
%inside.  However, we also need to increment inside so that we can divide
%by Ni for each simulation.  We will also calculate area in the same way as
%question three.  This simulation yields a value of ~9; correct value is
%8.966 (for the first quadrant)


inside = 0;
N = 10000;
sum = 0;
for i=1:N
    
    x = 3*rand;
    y = rand;
    
    if (TheBoundary(x,y) <= 0)
        inside = inside + 1;
        sum = sum + TheFunc(x,y);
    end
    
end


area = (inside/N)*3;
integral = (area/inside)*sum;
fprintf('integral of [2x+3y] in the ellipse (x/3)^2 + y^2 = %d\n', integral)

%It takes a significant amount of iterations to get the integral correct
%out to 3 decimal places; it is not correct even at 100,000


