% Depth2D to create interesting depth function for Tsunami2D
% Evan Roncevich and Andrew Gordon
% May 2, 2014
% APPM 3050, Project #02

function [h, hx, hy] = depth2D(x,y)
%note: put in the array of sizes for x and y only
nx = length(x);
ny=length(y);
h = zeros(ny,nx);
hx =zeros(ny,nx);
hy= zeros(ny,nx);
for j = 1:ny
    for i= 1:nx
        %add 2 diagonal shallow shelfs of width .5 to force the water to
        %move left, these shelfs are flat
        if ((abs(x(i)-y(j))<.5)|| (abs(x(i)-2-y(j))<.5) || (abs(x(i)+2-y(j))<.5))&& (x(i)>1) 
            h(j,i) =  .2;%1-x(i)*0.2;
            hx(j,i) = 0 ;
            hy(j,i) = 0;
        else
            %otherwise steadily decrease the depth by 2/15
            h(j,i)=1-x(i)*2/15;
            hx(j,i)= -2/15;
            hy(j,i)=0;
        end
    end
end
%---------------------------------

