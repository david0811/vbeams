function [l] = LFunction(n, theta)
% Function to give back the relative amplitude of the field at point at an
% incline angle of theta from the z-axis. It is assumed that the amplitude
% varies radially but maintains cylindrical symmetry about the optical
% axis.
% INPUTS
% n = the case chosen, i.e. what predefined function it is.
% theta = angle of incline from z-axis.
% OUTPUT
% l = relative amplitude of field for angle theta.

switch n
    case 1
        l = 1/(sin(theta));
    case 2
        l = 1/((sin(theta))^2);
    case 3 % Bessel-Gauss beam waist at plane 0.
        l = exp(-(sin(theta))^2)*besselj(1,2*sin(theta));
end