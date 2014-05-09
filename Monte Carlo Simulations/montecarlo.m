% Simluation: Probability of A&S students escaping the engineering center
% Andrew Gordon
% 04/18/14
% APPM 3050


% 
% 
% function f = montecarlo(x,y) % Used this when I ran the simulation on a 5x5
% i = x;    
% j = y;



%monte carlo simulation: engineering building

%indexing always starts at 0; if you want to extend simulation, just increase maxrows
%if indexing from 0, a 5x5 grid ends at 4
maxrows = 4;   
maxcols = 4;   
N = 10000;


%get our x,y coordinates; user is alerted if they are out of bounds
startx = input('where do you wish to release your A&S students? Select an x coordinate: ');
while startx > maxcols | startx < 0
    startx = input('please select an x between 0 and 4: ');
end
      
starty = input('where do you wish to release your A&S students? Select an y coordinate: ');
while starty > maxrows | starty < 0
    starty = input('please select an y between 0 and 4: ');
end


%initialize
run = true;
success = 0;
i = startx;
j = starty;



for its = 1:N;
    
    %the outer loop runs the simulation 10,000 times
    %the inner loop is the simulation itself, it runs while the A&S student
    %is in the building 
    
    
    while (run == true)
        
        %check stop conditions....
        if (i == maxcols | i == 0 | j == maxrows | j == 0)
            
            % a win; simulation ends and we increment success
            if (i == 0) & (j > 0 & j < maxrows)
                run = false;
                success = success + 1;                    
            
            
            % a fail; simulation ends with no success
            else
                run = false;  
            end      
        end
        
        
        %create 4 direction conditions out of a random number betweeen 0,1
        if run == true
            myrand = rand;
            if (rand < .25)
                i = i+1;
            elseif (.25 <= rand < .5)
                i = i-1;
            elseif (.5 <= rand <.75)
                j = j + 1;
            elseif (.75 <= rand <= 1)
                j = j-1;
            end
        end
    end
    
    %reset conditions to initial
    run = true;
    i = startx;
    j = starty;

end

%calculate and print p-bility
probability_of_success = success/N;
sprintf('probability of success at coordinates %d,%d is %d\n', startx,starty, probability_of_success)


f = probability_of_success;







