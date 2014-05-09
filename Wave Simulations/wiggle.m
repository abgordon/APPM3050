% Solve the 1-D wave equation subject to
% u = 0     on right
% u = f(t)  on left and
% u = 0     at t=0
% vel = 0   at t=0
% -------------------------------------------

clear all
close all
clc

nFrames = 700;               % number of frames in the movie

c = 1;                       % set physical parameters
deltaT = 0.01;
deltaX = 0.02;
lamb = (c*deltaT/deltaX)^2;

xLeft  = 0;
xRight = 10;
uMin   = -2;
uMax   = 2;
x = linspace(xLeft , xRight , 201);     % calculate x node locations
n = length(x);


uInit = 0*x;                           % set initial values and plot
plot(x,uInit), xlabel('X axis'), ylabel('Y axis'),
               title('My title'), axis([xLeft xRight uMin uMax])
drawnow



uCur(1) = ...                         % <-----   set boundary values
uCur(n) = 0;

for j = 2 : (n-1)                     % calculate the first time-step
    uCur(j) = ...                     % <-----
end
plot(x,uCur), xlabel('X axis'), ylabel('Y axis'),
              title('My title'), axis([xLeft xRight uMin uMax])
drawnow



                                       % and the rest of the time steps...
uFut(1) = 0;                           % set boundary values
uFut(n) = 0;

for i = 2 : nFrames
      uFut(1) = ...                    % <----- set boundary values
      for j = 2 : (n-1)
          uFut(j) = ...                % <-------
      end
      plot(x,uFut), xlabel('X axis'), ylabel('Y axis'),
                    title('My title'), axis([xLeft xRight uMin uMax])
      drawnow

      ...                              % <------   update u values
      
end

