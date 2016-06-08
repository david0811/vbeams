function [EFieldZRHO, EFieldZZ, Z] = ...
    RadialElectricFieldPlot( )
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

% Calculate stuff.
height = 10.1; width = 10.1; z = 0;
[Energy, EFieldZRHO,EFieldZZ] = ...
    UVRadialElectricFieldPropagation(1, 100, pi/2, 1, height, width, 1, z);

% Make a mesh to plot stuff onto.
x = -width:0.2:width; y = -height:0.2:height;
w = length(x); h = length(y);
Z = meshgrid(x,y); [X,Y] = meshgrid(x,y);

U = zeros(h,w); V = zeros(h,w);
% Separating rho into U,V components.
for i = 1:h
    for j = 1:w
        U(i,j) = real(EFieldZRHO(i,j) * cos(atan2(y(i),x(j))));
        V(i,j) = real(EFieldZRHO(i,j) * sin(atan2(y(i),x(j))));
    end
end

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
% Radial
subplot(3,3,[3,6,9])
quiver(X,Y,U,V);
axis square
axis tight
title('E-field Radial Vector')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % y-axis label

% Z-direction
subplot(3,3,2)
quiver3(z*ones(h,w),zeros(h,w),zeros(h,w),abs(EFieldZZ));
axis tight
title('E-field Z Vector')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % y-axis label
zlabel('Z-Direction') % z-axis label


% ELECTRIC FIELD PHASE PLOT
subplot(3,3,4)
surf(x,y,atan(imag(EFieldZRHO)./real(EFieldZRHO)),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Radial Direction Electric Field Vector Phase')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

subplot(3,3,5)
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
surf(x,y,abs(EFieldZRHO),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Radial Direction Electric Field Vector Amplitude')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

subplot(3,3,8)
surf(x,y,abs(EFieldZZ),'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title('Z Direction Electric Field Vector Amplitude')
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label
