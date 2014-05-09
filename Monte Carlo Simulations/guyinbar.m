% Simulation: Man in a bar scenario
% Andrew Gordon
% 04/18/14
% APPM 3050

% 
% function f = guyinbar(x)
% barlength = x;




%receive input from user
barlength = input('Enter a distance for the bar in multiples of D: ');




%initialize
N = 10000;
rebuffed = 0;
success = 0;

for its = 1:N
    
    %he walks directly into the bar initially, so his initial distance is
    %1*D, and he is rebuffed
    depth_in_bar = 1;
    rebuffed = rebuffed + 1;
    
    while rebuffed < 10
         
         %check stop conditions
         if depth_in_bar >= barlength;
             %sprintf('He left through the back with %d rebuffs', rebuffed)
             success = success + 1;
             rebuffed = 10;
         end
        
        %create our random degree, increment rebuffed
        randomdirection = rand*360;
        depth_in_bar = depth_in_bar + sind(randomdirection);
        rebuffed = rebuffed + 1;

        
    end
    %reset rebuffed
    rebuffed = 0;
end 


probability_of_success = success/N;
sprintf('the probability of success with a bar of length %d is %d\n', barlength, probability_of_success)



f = probability_of_success;
