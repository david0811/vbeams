function [EFieldZX, EFieldZY, EFieldZZ, Z] = ...
    UVPlotLinearElectricField( )
% Just me being lazy and making a function that sticks values into the
% LinearElectricField function and plots it.
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
% ///OUTPUTS///
% EFieldZX = x component of output electric field at distance z from focus.
% EFieldZY = y component of output electric field at distance z from focus.
% EFieldZZ = z component of output electric field at distance z from focus.

% Calculate stuff.
height = 1.1; width = 1.1;
z = 0; alpha = asin(1.32/1.518); k = 2*pi; meshs = 0.02;
[Energy, EFieldZX, EFieldZY, EFieldZZ] = ...
    UVLinearElectricField(1, 100, alpha, 1, 1, height, width, k, z, meshs);

% Make a mesh to plot stuff onto.
x = -width:meshs:width; y = -height:meshs:height;
w = length(x); h = length(y);
Z = meshgrid(x,y);


%% Plot stuff.

% PLOT ENERGY
figure
subplot(3,3,1)
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
% Real
subplot(3,3,2)
quiver3(z*ones(h,w),real(EFieldZX),real(EFieldZY),real(EFieldZZ));
title('E-field real vectors')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % y-axis label
zlabel('Z-Direction') % z-axis label

% Imaginary
subplot(3,3,3)
quiver3(z*ones(h,w),imag(EFieldZX),imag(EFieldZY),imag(EFieldZZ));
title('E-field imaginary vectors')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % y-axis label
zlabel('Z-Direction') % z-axis label


% ELECTRIC FIELD PHASE PLOT
subplot(3,3,4)
surf(x,y,atan(imag(EFieldZX)./real(EFieldZX)),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('X Direction Electric Field Vector Phase')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

subplot(3,3,5)
surf(x,y,atan(imag(EFieldZY)./real(EFieldZY)),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Y Direction Electric Field Vector Phase')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

subplot(3,3,6)
surf(x,y,atan(imag(EFieldZZ)./real(EFieldZZ)),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Z Direction Electric Field Vector Phase')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

% ELECTRIC FIELD AMPLITUDE PLOT
subplot(3,3,7)
surf(x,y,abs(EFieldZX),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('X Direction Electric Field Vector Amplitude')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

subplot(3,3,8)
surf(x,y,abs(EFieldZY),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Y Direction Electric Field Vector Amplitude')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

subplot(3,3,9)
surf(x,y,abs(EFieldZZ),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Z Direction Electric Field Vector Amplitude')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

% PLOT ANGLE BETWEEN POLARIZATION ELLIPSE AND YZ PLANE (PHI = 0)
figure
subplot(2,2,1)
surf(x,y,atand(imag(EFieldZY)./imag(EFieldZX)),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Polarisation Ellipse Angle Made in XY Plane')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

% PLOT POLARISATION ELLIPSE RATIO
subplot(2,2,3)
surf(x,y,atan(abs(real(EFieldZZ))...
    ./sqrt(imag(EFieldZX).^2+imag(EFieldZY).^2)),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Polarisation Ellipse Angle Made in XY Plane')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

subplot(2,2,2)
contour(x,y,atand(imag(EFieldZY)./imag(EFieldZX)),'ShowText','on')
axis square
axis tight
view(0,90)
title('Polarisation Ellipse Angle Made in XY Plane')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

subplot(2,2,4)
contour(x,y,atan(abs(real(EFieldZZ))...
    ./sqrt(imag(EFieldZX).^2+imag(EFieldZY).^2)),'ShowText','on')
axis square
axis tight
view(0,90)
title('Polarisation Ellipse Angle Made in XY Plane')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label
