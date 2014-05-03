%Andrew Gordon
%Evan Roncevich
%Stopping Conditions for ODE45
function[value,stopInteg,direction] =ControlEvents(~,x)%,xt,yt)
global xt;
global yt;
%xt=xi;
%yt=yi;
value(1) = tan(x(2))*(xt-x(3))+x(4)-yt;
value(2) = xt-x(3);

stopInteg(1)=1;
direction(1)=0;

stopInteg(2)=1;
direction(2)=-1;
end

