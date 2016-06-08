function [I_0,I_1,I_2] = UVIntegrals(C, n, v, u, alpha)
% A function to calculate the electric field integrals.
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
        SI_0 = 0; SI_1 = 0; SI_2 = 0;
        Ca = cos(alpha); Sa = sin(alpha);
        
        % Establish the sums in the Trap Rule.
        for k = 1:(n-1)
            x = (k*alpha)/n;
            SI_0 = SI_0 + ((cos(x))^0.5)*sin(x)*(1+cos(x))*...
                besselj(0,Jvariable*sin(x))*exp(cos(x)*Evariable);
            SI_1 = SI_1 + ((cos(x))^0.5)*(sin(x)^2)*...
                besselj(1,Jvariable*sin(x))*exp(cos(x)*Evariable);
            SI_2 = SI_2 + ((cos(x))^0.5)*sin(x)*(1-cos(x))*...
                besselj(2,Jvariable*sin(x))*exp(cos(x)*Evariable);
        end
        
        % I_0
        I_0 = (alpha/n)*(SI_0 + 0.5*(Ca^0.5)*Sa*(1+Ca)*...
            besselj(0,v)*exp(Ca*Evariable));
        % I_1
        I_1 = (alpha/n)*(SI_1 + 0.5*(Ca^0.5)*(Sa^2)*...
            besselj(1,v)*exp(Ca*Evariable));
        % I_2
        I_2 = (alpha/n)*(SI_2 + 0.5*(Ca^0.5)*Sa*(1-Ca)*...
            besselj(2,v)*exp(Ca*Evariable));
end