% Solve the 1-D wave equation subject to
% u = 0     on right
% u = 0     on left and
% u = f(x)  at t=0
% -------------------------------------------

clear all                     % housekeeping
close all
clc

nFrames = 200;                % number of frames in the movie

c = 1;                        % set physical parameters
deltaT = 0.01;
deltaX = 0.02;
lamb = (c*deltaT/deltaX)^2;

xLeft  = 0;
xRight = 1;
uMin   = -1;
uMax   =  1;
x = linspace(xLeft , xRight , 51);     % calculate x node locations
n = length(x);

% uInit = sin(x*2*pi);        % set initial values
% uInit = 8*x.*(1-x).^3;
uInit = 2*x.*(1-x.^3);

                              % plot the initial shape...
plot(x,uInit), xlabel('X axis'), ylabel('Y axis'),
               title('My title'), axis([xLeft xRight uMin uMax])
drawnow


                              % the first time step calculations...
uCur(1) = 0;                  % set spatial boundary values
uCur(n) = 0;
for j = 2 : (n-1)                   % calculate the first time-step
    uCur(j) = ( lamb*uInit(j-1) + (2-2*lamb)*uInit(j) + lamb*uInit(j+1) ) / 2;            % <-----
end
plot(x,uCur), xlabel('X axis'), ylabel('Y axis'),
              title('My title'), axis([xLeft xRight uMin uMax])
drawnow



                               % and the rest of the time steps...
uFut(1) = 0;
uFut(n) = 0;
for i = 2 : nFrames            % make lots of plots
    
      for j = 2 : (n-1)
          uFut(j) = ( lamb*uCur(j-1) + (2-2*lamb)*uCur(j) + lamb*uCur(j+1) - uInit(j));        % <------
      end
      plot(x,uFut), xlabel('X axis'), ylabel('Y axis'),
                    title('My title'), axis([xLeft xRight uMin uMax])
      drawnow


      uInit = uCur;            % update u values
      uCur = uFut;

end

