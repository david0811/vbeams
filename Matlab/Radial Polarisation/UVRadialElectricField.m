function [RHOI_0,ZI_1] = UVRadialElectricField(C, n, v, u, alpha, A)
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
        RHOI_0 = 0; ZI_1 = 0;
        Ca = cos(alpha); Sa2 = sin(2*alpha); SaS = sin(alpha)^2;
        
        % Establish the sums in the Trap Rule.
        for k = 1:(n-1)
            x = (k*alpha)/n;
            RHOI_0 = RHOI_0 + ((cos(x))^0.5)*sin(2*x)*LFunction(1,x)*...
                besselj(1,Jvariable*sin(x))*exp(cos(x)*Evariable);
            ZI_1 = ZI_1 + ((cos(x))^0.5)*(sin(x)^2)* LFunction(1,x)*...
                besselj(0,Jvariable*sin(x))*exp(cos(x)*Evariable);
        end
        
        % I_0
        RHOI_0 = (A*alpha/n)*(RHOI_0 + 0.5*(Ca^0.5)*Sa2*LFunction(1,alpha)*...
            besselj(1,v)*exp(Ca*Evariable));
        % I_1
        ZI_1 = (A*2*1i*alpha/n)*(ZI_1 + 0.5*(Ca^0.5)*(SaS)*LFunction(1,alpha)*...
            besselj(0,v)*exp(Ca*Evariable));
end