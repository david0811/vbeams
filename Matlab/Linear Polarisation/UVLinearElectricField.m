function [Energy, EFieldZX, EFieldZY, EFieldZZ] = ...
    UVLinearElectricField(C, n, alpha, f, l_0, IMH,IMW, k, z, meshs)
% A function to calculate the electric field vectors for a linear input 
% polarisation direction for matrix of size IMH by IMW at point z from
% focus.
% ///INPUTS///
% C     = type of numerical method used to calculate integrals.
% n     = number of points used in the numerical method (step size).
% alpha = numerical aperture in radians.
% f     = system focal length.
% l_0   = amplitude factor.
% % phi   = angle electric field makes with horizontal x-axis (in xy plane).
% IMH   = electric field matrix height.
% IMW   = electric field matrix width.
% k     = input wavenumber.
% z     = image plane distance from which you want the output e-field for.
% meshs = mesh spacing.
% ///OUTPUTS///
% EFieldZX = x component of output electric field at distance z from focus.
% EFieldZY = y component of output electric field at distance z from focus.
% EFieldZZ = z component of output electric field at distance z from focus.

%% INITIALISING STUFF
% Create A constant for the integrals.
A = (k*f*l_0)/2;
u = k*z*(sin(alpha)^2);

% Creating a matrix of the v component of the rays.
y = -IMH:meshs:IMH; 
x = -IMW:meshs:IMW; 
V = zeros(length(y),length(x));
for i = 1:(length(y))
    for j = 1:(length(x))
        V(i,j) = sqrt(y(i)^2 + x(j)^2);
    end
end
V = V*k*sin(alpha);


% Create empty matrix for the electric field at z for x, y and z direction.
EFieldZX = zeros(length(y),length(x));
EFieldZY = zeros(length(y),length(x));
EFieldZZ = zeros(length(y),length(x));
Energy = zeros(length(y),length(x));

%% ELECTRIC FIELD CALCULATIONS

% Go through the rows.
for i = 1:(length(y))
    % Go through the columns.
    for j = 1:(length(x))
         psip = atan(y(i)./x(j));
        
        % Find them integrals.
        [I_0,I_1,I_2] = UVIntegrals(C, n, V(i,j), u, alpha);
        
        % Apply them integrals to the electric field equations.
        EFieldZX(i,j) = -1i*A*(I_0 + I_2*(cos(2*psip)));
        EFieldZY(i,j) = -1i*A*I_2*sin(2*psip);
        EFieldZZ(i,j) = -2*A*I_1*cos(psip);
        Energy(i,j) = (A^2)/(8*pi)*(abs(I_0)^2+2*abs(I_1)^2 + abs(I_2)^2);
    end
end

 
 
 