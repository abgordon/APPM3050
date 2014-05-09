% 1-D Wave Tsunami with Variable Depth
% Evan Roncevich and Andrew Gordon
% May 2, 2014
% APPM 3050, Project #02

% Solve the 1-D wave equation subject to
% a*u + b*(du/dx) = c on the right
% moving boundary condition on left
% All with a variable depth given by depth1D.m
% -------------------------------------------

clear all
close all
clc

nFrames = 1000;                % number of frames in the movie (time!)

c      = 1;                   % set physical parameters
deltaT = 0.01;
deltaX = 0.01;
lamb   = (c*deltaT/deltaX)^2;
alpha  = 0;
beta   = 1;
gamma  = 0;

xRight = 4;                   % calculate x node locations
x = linspace(0, xRight, (xRight/deltaX +1) );
n = length(x);

uInit = zeros(1,n);            % set values for uInit, uCur and uFut
uCur  = uInit;
uFut  = uCur;

plot(x,uInit), xlabel('X axis'), ylabel('Y axis'),
               title('My title'), axis([0 xRight -1 1])
drawnow

[h,hx] = depth1D(x);    % set left spatial boundary value
uCur(1) = leftBoundary(1, deltaT);
for i = 2 : n                 % calculate the first time-step
    if i == n
        if beta == 0
            uCur(n) = gamma/alpha;
        else
            phantom = rightBoundary(n, alpha, beta, gamma, deltaX, uCur);
            uCur(n) = (lamb*(hx(n)*((phantom-uInit(n-1))/2) + h(n)*(uInit(n-1)-2*uInit(n)+phantom))+2*uInit(n))/2;
        end
    else
        uCur(i) = (lamb*(hx(i)*deltaX*((uInit(i+1)-uInit(i-1))/2) + h(i)*(uInit(i-1)-2*uInit(i)+uInit(i+1)))+2*uInit(i))/2;
    end
end

plot(x,uCur), xlabel('X axis'), ylabel('Y axis'),
              title('My title'), axis([0 xRight -1 1])
drawnow
                               % and the rest of the time steps...
for k = 2 : nFrames
      uFut(1) = leftBoundary(k, deltaT);
      for i = 2 : n
          if i == n
              if beta == 0
                  uFut(n) = gamma/alpha;
              else
                  phantom = rightBoundary(n, alpha, beta, gamma, deltaX, uCur);
                  uFut(n) = lamb*( hx(n)*((phantom-uCur(n-1))/2)+h(n)*(uCur(n-1)-2*uCur(n)+phantom))+2*uCur(n)-uInit(n);
              end
          else
              uFut(i) = lamb*( hx(i)*deltaX *((uCur(i+1)-uCur(i-1))/2)+h(i)*(uCur(i-1)-2*uCur(i)+uCur(i+1)))+2*uCur(i)-uInit(i);
             
          end
      end
      % input('delay')
      plot(x,uFut), xlabel('X axis'), ylabel('Y axis'),
                    title('My title'), axis([0 xRight -1 1])
      drawnow

      uInit = uCur;            % update u values
      uCur  = uFut;
end
