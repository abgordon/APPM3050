
% Solve the 1-D wave equation subject to
% a*u + b*(du/dx) = c on the right
% moving boundary condition on left
% -------------------------------------------

clear all
close all
clc

nFrames = 1000;                % number of frames in the movie (time!)

c      = 1;                   % set physical parameters
deltaT = 0.02;
deltaX = 0.02;
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



                             % set left spatial boundary value
uCur(1) = leftBoundary(1, deltaT);
for i = 2 : n                 % calculate the first time-step
    if i == n
        if beta == 0
            uCur(n) = gamma/alpha;
        else
            phantom = rightBoundary(n, alpha, beta, gamma, deltaX, uCur);
            uCur(n) = ( lamb*uInit(n-1) + (2-2*lamb)*uInit(n) + lamb*phantom ) / 2;
        end
    else
        uCur(i) = ( lamb*uInit(i-1) + (2-2*lamb)*uInit(i) + lamb*uInit(i+1) ) / 2;
    end
end

plot(x,uCur), xlabel('X axis'), ylabel('Y axis'),
              title('My title'), axis([3 xRight -1 1])
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
                  uFut(n) = ( lamb*uCur(n-1) + (2-2*lamb)*uCur(n) + lamb*phantom - uInit(n));
              end
          else
              uFut(i) = ( lamb*uCur(i-1) + (2-2*lamb)*uCur(i) + lamb*uCur(i+1) - uInit(i));
          end
      end
      % input('delay')
      plot(x,uFut), xlabel('X axis'), ylabel('Y axis'),
                    title('My title'), axis([0 xRight -1 1])
      drawnow
      if uFut(1) ~= 0
          disp(k)
      end
      uInit = uCur;            % update u values
      uCur  = uFut;
end

