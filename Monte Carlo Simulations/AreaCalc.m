% Iterative Integration part I
% Andrew Gordon
% 04/18/14
% APPM 3050


%1) throw 10,000 darts in a 3x1 square containing ellipse
%2) count darts in ellipse
%3) (1/4)*AreaEllipse = (#darts in Ellipse/N)*Areasq

inside = 0;

N = 10000;
sum = 0;
for i=1:N
    
    x = 3*rand;
    y = rand;
    
    if (TheBoundary(x,y) <= 0)
        inside = inside+1;
    end
    
end


integral = (inside/N)*3;
fprintf('integral of [(x/3)^2 +y^2 =1] in the first quadrant = %d\n', integral)

%multiply by 4 to get total area
area = 4*integral;
fprintf('Total area = %d\n', area)

%estimate ? pi*3*1
