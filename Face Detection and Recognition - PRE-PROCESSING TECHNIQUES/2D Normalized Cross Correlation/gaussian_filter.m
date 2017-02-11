%% gaussian function generation

function f=gaussian_filter(n,s,a)

x = -1/2:1/(n-1):1/2;   % x ranges from -0.5 to +0.5

[Y,X] = meshgrid(x,x);  % y also as above

f = -a*exp( -(X.^2+Y.^2)/(2*s^2) );    % gaussian equation

surf(Y,X,f);
% f = -f / sum(f(:));

end