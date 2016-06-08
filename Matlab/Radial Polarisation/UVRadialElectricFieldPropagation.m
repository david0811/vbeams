function [Energy, EFieldZRHO,EFieldZZ] = ...
    UVRadialElectricFieldPropagation(C, n, alpha, A, IMH,IMW, k, z)
% A function to calculate the electric field vectors for a linear input 
% polarisation direction for matrix of size IMH by IMW at point z from
% focus.
% ///INPUTS///
% C     = type of numerical method used to calculate integrals.
% n     = number of points used in the numerical method (step size).
% alpha = numerical aperture in radians.
% A     = constant k*f*l_0/2
% IMH   = electric field matrix height.
% IMW   = electric field matrix width.
% k     = input wavenumber.
% z     = image plane distance from which you want the output e-field for.
% ///OUTPUTS///
% EFieldZX = x component of output electric field at distance z from focus.
% EFieldZY = y component of output electric field at distance z from focus.
% EFieldZZ = z component of output electric field at distance z from focus.

%% INITIALISING STUFF
% Create u constant for the integrals.
u = k*z*(sin(alpha)^2);

% Creating a matrix of the v component of the rays.
y = -IMH:0.2:IMH; 
x = -IMW:0.2:IMW; 
V = zeros(length(y),length(x));
for i = 1:(length(y))
    for j = 1:(length(x))
        % V is essentially rho at this point
        V(i,j) = sqrt(y(i)^2 + x(j)^2);
    end
end
V = V*k*sin(alpha);


% Create empty matrix for the electric field at z for x, y and z direction.
EFieldZRHO = zeros(length(y),length(x));
EFieldZZ = zeros(length(y),length(x));
Energy = zeros(length(y),length(x));

%% ELECTRIC FIELD CALCULATIONS

% Go through the rows.
for i = 1:(length(y))
    % Go through the columns.
    for j = 1:(length(x))        
        % Find them integrals.
        [EFieldZRHO(i,j),EFieldZZ(i,j)] = ...
            UVRadialElectricField(C, n, V(i,j), u, alpha, A);
        Energy(i,j) = sqrt(abs(EFieldZRHO(i,j))^2 + abs(EFieldZZ(i,j))^2);
    end
end