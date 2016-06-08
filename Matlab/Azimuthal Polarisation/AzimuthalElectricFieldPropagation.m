function [Energy, EFieldZPHI] = ...
    AzimuthalElectricFieldPropagation(C, n, alpha, A, IMH,IMW, k, z, meshs)
% A function to calculate the electric field vectors for an azimuthal input 
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
% meshs = mesh step size. Length of interval between step points.
% ///OUTPUTS///
% Energy    = magnitude of the output phi direction e-field in XY plane.
% EFieldPHI = electric field magnitude in phi direction.

%% INITIALISING STUFF
% Create u constant for the integrals.
u = k*z*(sin(alpha)^2);
% Creating a matrix of the v component of the rays.
y = -IMH:meshs:IMH; 
x = -IMW:meshs:IMW; 

% Create empty matrix for the electric field at z for x, y and z direction.
EFieldZPHI = zeros(length(y),length(x));
Energy = zeros(length(y),length(x));

%% ELECTRIC FIELD CALCULATIONS
% Go through the rows.
for i = 1:(length(y))
    % Go through the columns.
    for j = 1:(length(x))        
        % Find them integrals.
        [EFieldZPHI(i,j)] = ...
            AzimuthalElectricField(C, n, k*sin(alpha)*(sqrt(y(i)^2 + x(j)^2)), u, alpha, A);
        Energy(i,j) = abs(EFieldZPHI(i,j));
    end
end