function [PHII_0] = AzimuthalElectricField(C, n, v, u, alpha, A)
% A function to calculate the electric field.
% C = type of numerical method used to calculate integrals.
% n = number of points used in the numerical method (step size).
% v = v value for V(i,j) at point (i,j).
% u = u value for cross-section of interest.
% alpha = numerical aperture.


switch C %C = Choose which integral approximation method you want.
    
    %TRAPEZOIDAL RULE APPROXIMATION
    case 1 % For Trapezoidal Rule approximation of the integrals.
        Jvariable = v/sin(alpha); %Establish Bessel varible factor
        Evariable = 1i*u/(sin(alpha)^2); %Establish exponential variable factor
        PHII_0 = 0; Ca = cos(alpha); Sa = sin(alpha);
        
        % Establish the sums in the Trap Rule.
        for k = 1:(n-1)
            x = (k*alpha)/n;
            PHII_0 = PHII_0 + ((cos(x))^0.5)*sin(x)*LFunction(1,x)*...
                besselj(1,Jvariable*sin(x))*exp(cos(x)*Evariable);
        end
        
        % I_0
        PHII_0 = (A*alpha/n)*(PHII_0 + 0.5*(Ca^0.5)*Sa*LFunction(1,alpha)*...
            besselj(1,v)*exp(Ca*Evariable));
end