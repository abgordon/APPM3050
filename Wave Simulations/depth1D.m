function [h, hx] = depth1D(x)

%---------------------------------
% h is h(x) = depth function measured down from
% the equlibrium surface
%
% hx is dh/dx
%
% Input:  x the vector of x locations
% Output: h the vector of depth values
%         hx the vector of slope values
%---------------------------------

n = length(x);

%---------------------------------
% Uniform depth

% h = 1*ones(1,n);
% hx = zeros(1,n);

%---------------------------------
% Linear depth that gets shallower
% near the shore

h = 1 - (x/6)*0.8;
hx = -0.8/6 * ones(1,n);

%---------------------------------

