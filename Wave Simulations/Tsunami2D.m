%2-D Tsunami with variable depth
% Evan Roncevich and Andrew Gordon
% May 2, 2014
% APPM 3050, Project #02


% Solve the 2-D wave equation
% the boundary at Lx is always 0
% the boundaries at y=0 and y=Ly are connected so
% the pool is continuous along the y
% the wave will also flow back into the ocean with little error
% -------------------------------------------

clear all
close all
clc

kk=[.5,.8,.5,.5];
ss=[1000,1000,1000];
load('AKWaterColormap','AKWaterColormap')
set(gcf,'Colormap',AKWaterColormap)

nFrames = 2000;                % number of frames in the movie (time!)

c      = 1;                   % set physical parameters
deltaT = 0.01;
deltaX = 0.02;
deltaY = 0.02;
lambX   = (c*deltaT/deltaX)^2;
lambY   = (c*deltaT/deltaY)^2;
alpha  = 0;
beta   = 1;
gamma  = 0;

xRight = 4;                   % calculate x node locations
x = linspace(0, xRight, (xRight/deltaX +1) );
yBottom = 4;
y = linspace(0, yBottom, (yBottom/deltaY +1) );
nx = length(x);
ny = length(y);

uInit = zeros(ny,nx);            % set values for uInit, uCur and uFut
uCur  = uInit;
uFut  = uCur;

[h,hx,hy] = depth2D(x,y); %creates waves for the first time step
for i = 2 : nx-1
    for j = 1 : ny
        if j==1 %boundary condition
            uCur(j,i) = (lambY*( hy(j,i)*(uInit(j+1,i)-uInit(ny,i))/2*deltaY+(uInit(j+1,i)-2*uInit(j,i)+uInit(ny,i))*h(j,i))...
                  + lambX*(hx(j,i)*(uInit(j,i+1)-uInit(j,i-1))/2*deltaX+(uInit(j,i-1)-2*uInit(j,i) + uInit(j,i+1))*h(j,i)) + 2*uCur(j,i))/2;
        elseif j==ny %boundary condition
            uCur(j,i) = (lambY*( hy(j,i)*(uInit(1,i)-uInit(j-1,i))/2*deltaY+(uInit(1,i)-2*uInit(j,i)+uInit(j-1,i))*h(j,i))...
                  + lambX*(hx(j,i)*(uInit(j,i+1)-uInit(j,i-1))/2*deltaX+(uInit(j,i-1)-2*uInit(j,i) + uInit(j,i+1))*h(j,i)) + 2*uCur(j,i))/2;
        else
            uCur(j,i) = (lambY*( hy(j,i)*(uInit(j+1,i)-uInit(j-1,i))/2*deltaY+(uInit(j+1,i)-2*uInit(j,i)+uInit(j-1,i))*h(j,i))...
                  + lambX*(hx(j,i)*(uInit(j,i+1)-uInit(j,i-1))/2*deltaX+(uInit(j,i-1)-2*uInit(j,i) + uInit(j,i+1))*h(j,i)) + 2*uCur(j,i))/2;
        end
    end
end

surfl(x,y,uCur), xlabel('X axis'), ylabel('Y axis'),
              title('My title'), axis([0 xRight 0 yBottom -1 1]), shading interp             
 drawnow

uFut(:,nx)=0; %make sure the end is always zero
for k = 2 : nFrames
      uFut(:,1) = leftBoundary(k, deltaT);
      if k*deltaT >= .5
          uFut(:,1)=uCur(:,2);
      end
      for i = 2 : nx-1
          for j = 1 : ny
              if j==1 %boundary condition, instead of setting these to fixed points, the top and bottom of the graph are connected to be continuous
                uFut(j,i) = lambY*( hy(j,i)*(uCur(j+1,i)-uCur(ny,i))/2*deltaY+(uCur(j+1,i)-2*uCur(j,i)+uCur(ny,i))*h(j,i))...
                  + lambX*(hx(j,i)*(uCur(j,i+1)-uCur(j,i-1))/2*deltaX+(uCur(j,i-1)-2*uCur(j,i) + uCur(j,i+1))*h(j,i)) + 2*uCur(j,i)-uInit(j,i);
              elseif j==ny%boundary condition, This makes the graph really cool
                  uFut(j,i) = lambY*( hy(j,i)*(uCur(1,i)-uCur(j-1,i))/2*deltaY+(uCur(1,i)-2*uCur(j,i)+uCur(j-1,i))*h(j,i))...
                  + lambX*(hx(j,i)*(uCur(j,i+1)-uCur(j,i-1))/2*deltaX+(uCur(j,i-1)-2*uCur(j,i) + uCur(j,i+1))*h(j,i)) + 2*uCur(j,i)-uInit(j,i);
              else
                uFut(j,i) = lambY*( hy(j,i)*(uCur(j+1,i)-uCur(j-1,i))/2*deltaY+(uCur(j+1,i)-2*uCur(j,i)+uCur(j-1,i))*h(j,i))...
                  + lambX*(hx(j,i)*(uCur(j,i+1)-uCur(j,i-1))/2*deltaX+(uCur(j,i-1)-2*uCur(j,i) + uCur(j,i+1))*h(j,i)) + 2*uCur(j,i)-uInit(j,i);
              end
          end
      end
      %input('delay')
      surfl(x,y,uCur), xlabel('X axis'), ylabel('Y axis'),
          title('My title'), axis([0 xRight 0 yBottom -1 1]), shading interp
      drawnow
      
      uInit = uCur;            % update u values
      uCur  = uFut;
end
disp('Done');
