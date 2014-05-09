%Andrew Gordon
%Evan Roncevich
%Angle Solver to hit target
function ret=Target(x,y)
    global xt;
    global yt;
    xt=x;
    yt=y;    
    v0=1600;    
    tInit = 0;
    tFin = 100;
    tol=.0005;
    counter =0;
    if(v0^4-9.81*(9.81*xt^2+2*yt*v0^2)<0);%definitely won't hit, would be imaginary
        disp('Failure, out of Range');
        ret=-1;
        return
    end
    
    thpart = sqrt(v0^4-9.81*(9.81*xt^2+2*yt*v0^2));%initial boundaries
    th1= atan((v0^2-thpart)/(9.81*xt));
    th2=atan((v0^2+thpart)/(9.81*xt));
    th2=(th1+th2)/2;
    thm=0;
    
    options = odeset('Events', @ControlEvents, 'RelTol', 0.001, 'AbsTol',0.001 );
    overshot=false;
    %bisection stuff
    while(counter<30);
        thm = (th1+th2)/2;
        if(abs(th2-thm)<tol)%break if tolerance met
            %disp(counter);
            break;
        end
        [t,x] = ode45(@MySystem, [tInit, tFin], [v0 thm 0 0], options);
        if(x(end,3)>=xt)%overshot
            th2=thm;
            overshot=true;%undershot
        else
            th1=thm;
        end
        counter=counter+1;
    end
    if(overshot==false)%should have gotten at least one overshot
        disp('Out of Range');
        ret=-1;
        return
    end
    %disp(thm);
    ret = thm;
end