% False position method
% Andrew Gordon
% 01/31/14
% APPM 3050
% Homework #02

clear;                     % clear workspace

maxIter = 1000;
TOL     = 1.0e-6;                                 
counter = 0;               % initialize iteration counter

%ask user for a and b
a = input('Please enter a value for a: ');
b = input('Please enter a value for b: ');

while theFunction(a)*theFunction(b) > 0
    %tell user to ask for another a,b
    disp('Bad guess')
    a = input('Please enter a new value for a: ');
    b = input('Please enter a new value for b: ');
    
end
c0 =1;

while (counter < maxIter)
    

    
    %calculate our new C from false position method
    c = b-((theFunction(b)*(b-a))/(theFunction(b)-theFunction(a)))
    
    if abs(((c-c0)/c))<TOL
        break
    end
    
    % increment the counter
    counter = counter+1;
    
    %this method uses the same conditions as bisection
    if theFunction(c)*theFunction(b) < 0
        a = c;
    end
    
    if theFunction(a)*theFunction(c) < 0
        b = c;
    end
    
    if theFunction(c) == 0
        break
    end
 
    c0=c;
end


fprintf('root estimate = %f\n', c)