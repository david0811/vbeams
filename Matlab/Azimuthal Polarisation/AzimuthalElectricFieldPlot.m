function [EFieldZPHI, Z] = AzimuthalElectricFieldPlot( )
% Just me being lazy and making a function that sticks values into the
% LinearElectricField function and plots it.
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

% Calculate stuff.
height = 1.1; width = 1.1; 
z = 0; alpha = asin(1.32/1.518); k = 2*pi; meshs = 0.02;
[Energy, EFieldZPHI] = ...
    AzimuthalElectricFieldPropagation(1, 100, alpha, 1, height, width, k, z, meshs);

% Make a mesh to plot stuff onto.
x = -width:meshs:width; y = -height:meshs:height;
w = length(x); h = length(y);
Z = meshgrid(x,y); [X,Y] = meshgrid(x,y);

U = zeros(h,w); V = zeros(h,w);
% Separating rho into U,V components.
for i = 1:h
    for j = 1:w
        psis = atan2(y(i),x(j));
        U(i,j) = real(EFieldZPHI(i,j)) * sin(psis);
        V(i,j) = -real(EFieldZPHI(i,j)) * cos(psis);
    end
end

%% Plot stuff.

% PLOT ENERGY
figure
subplot(2,3,1)
surf(x,y,Energy,'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Energy')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % y-axis label
zlabel('Z-Direction') % z-axis label

% PLOT E-FIELD VECTORS
% Radial
subplot(2,3,4)
quiver(X,Y,U,V);
axis square
axis tight
title('E-field Radial Vector')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % y-axis label

% ELECTRIC FIELD PHASE PLOT
subplot(2,3,2)
surf(x,y,atan(imag(EFieldZPHI)./real(EFieldZPHI)),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Azimuthal Direction Electric Field Vector Phase')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

subplot(2,3,3)
surf(x,y,imag(EFieldZPHI),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Imaginary Electric Field Component')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

% ELECTRIC FIELD AMPLITUDE PLOT
subplot(2,3,5)
surf(x,y,abs(EFieldZPHI),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Azimuthal Direction Electric Field Vector Amplitude')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

subplot(2,3,6)
surf(x,y,real(EFieldZPHI),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Real Electric Field Vector Component')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label
