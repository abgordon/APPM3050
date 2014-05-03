% Solve the 1-D wave equation subject to
% a*u + b*(du/dx) = c on the right
% moving boundary condition on left
% -------------------------------------------

clear all
close all
clc

nFrames = 600;                % number of frames in the movie

c = 1;                        % set physical parameters
deltaT = 0.01;
deltaX = 0.02;
lamb = (c*deltaT/deltaX)^2;
alpha = 0;                    % set boundary condition parameters
beta  = 1;
gamma = 0;

xLeft  = 0;
xRight = 4;
uMin   = -1;
uMax   =  1;
x = linspace(xLeft , xRight , 201);     % calculate x node locations
n = length(x);

uInit = 0*x;                   % set temporal initial values


plot(x,uInit), xlabel('X axis'), ylabel('Y axis'),
               title('My title'), axis([xLeft xRight uMin uMax])
drawnow


                                       % calculate the first time-step
uCur = zeros(1,n);                     % preallocate uCur and initialize it
uCur(1) = leftBoundary(1, deltaT);     % set left boundary value

for j = 2 : n
    if j == n
        if beta == 0
            uCur(n) = ...
        else
            phantom = rightBoundary(n, alpha, beta, gamma, deltaX, uInit);
            uCur(n) = ...
        end
    else
        uCur(j) = ...
    end
end

plot(x,uCur), xlabel('X axis'), ylabel('Y axis'),
              title('My title'), axis([xLeft xRight uMin uMax])
drawnow



                               % and the rest of the time steps...
uFut(1) = 0;                   % pre-allocate uFut and initialize end
uFut(n) = 0;

for i = 2 : nFrames

    uFut(1) = leftBoundary(i, deltaT);
      for j = 2 : n
          if j == n
              if beta == 0
                  uFut(n) = ...
              else
                  phantom = rightBoundary(n, alpha, beta, gamma, deltaX, uCur);
                  uFut(n) = ...
              end
          else
              uFut(j) = ...
          end
      end
      plot(x,uFut), xlabel('X axis'), ylabel('Y axis'),
                     title('My title'), axis([xLeft xRight uMin uMax])
      drawnow

      uInit = uCur;            % update u values
      uCur = uFut;

end

