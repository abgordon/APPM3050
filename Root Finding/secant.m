%secant method for root finding
%Andrew GOrdon
%01/31/14
%APPM 3050
%Homework #02


clear;                     % clear workspace

TOL     = 1.0e-6;         % set convergence tol.
maxIter = 1000;             % set maximum iterations

counter = 0;               % initialize iteration counter

% get initial root guess from user, x0
x0 = input('guess a root: ');
x1 = input('guess another root: ');

fprintf( '%5.0f  %14.10f \n',  counter, x0 );   % more details later

while (counter < maxIter)
    
    % calculate new root estimate, x1, from secant lines of x0,x1
    x2 = (x0*theFunction(x1)-x1*theFunction(x0))/(theFunction(x1)-theFunction(x0));
    
    % increment the counter
    counter = counter+1;

    % print current values
    
  
    % have we converged yet?
    %   if yes, then we are done
    %   if no, then go around again
       if(abs(((x2-x1)/x1)))<TOL;
           break
       end
       if(x2==-inf);  %NANs and -inf tend to pop up so this helps to catch running iterations of NAN
           break
       end

       
    % else reset Xn value to Xn+1
    x0 = x1;
    x1=x2;
    
end


fprintf('root estimate = %f\n', x1)