clf
clear

x= xlsread('OilProductionData.xls', 'Sheet1');
usdata = ones(151,1);
worlddata = ones(151,1);

%our 3 values of Qinf, to be used in calculating the dist:
Qstingy = 2*10^12;
Qmiddle = 3*10^12;
Qgenerous = 4*10^12;

%grab data and plot if desired
for i = 1:151
    usdata(i,1) = x(i,2);
    worlddata(i,1) = x(i,3);
end



%make units consistent with Q
worlddata = worlddata*10^6;


%--------- Calculating Sigma ---------%
%To calculate sigma, we assume the the mean (which determines the center of
%the distribution) is 2007, the last data point, because this is a predicted 
%peak oil point.  This code uses bisection while comparing the value at the
%mean on the normal distribution to the actual data to adjust sigma.  
 
expdistGLOB = ones(400,1); %preallocate
meanworld = 151; %for global data we assume we are right in the middle of peak oil

%set our initial guesses for sigma a and b
sigmaGLOBa = 0;
sigmaGLOBb = 100;

run = 1;
while ( run == 1)
    
    %calculate new c
    sigmaGLOBc = (sigmaGLOBa+sigmaGLOBb)/2;
    
    
    %re-calculate the distribution
    %chance Q here to calculate our optimistic or pessimistic predictions
    for i = 1:400
        expdistGLOB(i,1) = (Qgenerous/(sigmaGLOBc*sqrt(2*pi)))*exp(-.5*((i-meanworld)/sigmaGLOBc)^2);
    end
    
    
    
    if abs(expdistGLOB(meanworld,1) - worlddata(meanworld,1)) > 10  %set a tolerance of convergence
        %bisection!
        if (expdistGLOB(meanworld,1)) > worlddata(meanworld,1)
            %value is greater ->sigma is small, we want it bigger
            sigmaGLOBa = sigmaGLOBc;
        elseif (expdistGLOB(meanworld,1)) < worlddata(meanworld,1)
            %value is less --> sigma is big, we want it smaller
            sigmaGLOBb = sigmaGLOBc;
        end
    else
        %if within tol, break
        run = 0;
        break
    end
    
    
    %make a nice video of converging distributions
    drawnow
    hold on
    plot(worlddata)
    plot(expdistGLOB)
    
end
  

%re-plot our final distribution
hold off
clc
plot(worlddata)
hold on
plot(expdistGLOB)



%check when the value on the distribution falls to below 5% of maximum
%production
check = worlddata(meanworld,1)*.05;
for i = 110:400
    if expdistGLOB(i,1) < check
        sprintf('the world will run out of oil in the year %d (assuming everyone plays nice)', i+1857)
        break
    end
end
 










