%Bisection method
%Andrew Gordon
%01/31/14
%APPM 3050
%Homework #02


clear

counter = 0;
maxiter = 1000;

TOL     = 1.0e-6;         % set convergence tol.
c0 = 1;
%ask user for a and b
a = input('Please enter a value for a: ');
b = input('Please enter a value for b: ');

while theFunction(a)*theFunction(b) > 0
    %tell user to ask for another a,b
    disp('Bad guess')
    a = input('Please enter a new value for a: ');
    b = input('Please enter a new value for b: ');
    
end

while counter < maxiter
    
    
    
    %increment counter
    counter = counter + 1;
    
    %calculate new c
    c = (a+b)/2

    
    if theFunction(c)*theFunction(b) < 0
        a = c;
    end
    
    if theFunction(a)*theFunction(c) < 0
        b = c;
    end
    
    if theFunction(c) == 0
        break
    end
    
    if abs(((c-c0)/c))<TOL
        break
    end
    c0=c;

end


disp('Root estimate = ');
disp(c);