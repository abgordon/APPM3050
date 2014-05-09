function u = leftBoundary(t, deltaT)

% returns single scalar value for left hand displacement

if ( t < 0.5/deltaT)
    u = 0.3*sin(2*pi*t*deltaT);
else
    u = 0;
end