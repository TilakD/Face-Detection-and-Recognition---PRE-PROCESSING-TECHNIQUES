function f= gaussian_filter(n,s,a)

x = -1/2:1/(n-1):1/2;
[Y,X] = meshgrid(x,x);
f = -a*exp( -(X.^2+Y.^2)/(2*s^2) );

surf(Y,X,f);


end