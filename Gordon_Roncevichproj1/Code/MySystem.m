%Andrew Gordon
%Evan Roncevich
%Differential equations for ODE45
function sysDot = MySystem(~,x)
    %sysDot= zeros(4,1);
    sint=sin(x(2));
    cost=cos(x(2));
    [a,b]= Wind(x(3),x(4));
    v= x(1);
    vpa=-.0025*sqrt((v*cost-a)^2+(v*sint-b)^2); %includes cd/m
    %sysDot(1) = vpa*(v-a*cost-b*sint)-9.81*sint;%vdot
    %sysDot(2) = (vpa*(a*sint-b*cost)-9.81*cost)/v; %thetadot
    %sysDot(3) = v*cost;
    %sysDot(4) = v*sint;
    sysDot=[vpa*(v-a*cost-b*sint)-9.81*sint; (vpa*(a*sint-b*cost)-9.81*cost)/v; v*cost; v*sint];
end