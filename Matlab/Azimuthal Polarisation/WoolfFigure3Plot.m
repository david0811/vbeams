function [] = WoolfFigure3Plot( )
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
figure

% PLOT ENERGY
%% FIRST
alpha = 0.01;
height = 20.1; width = 20.1;
x = -width:0.2:width;
y = -height:0.2:height; 

[~, EFieldZX, EFieldZY, EFieldZZ] = ...
    UVLinearElectricField(1, 100, alpha, 1, 1, height, width, 1, 0);
Energy01 = (abs(EFieldZX).^2 + abs(EFieldZY).^2 + abs(EFieldZZ).^2)/(16*pi);
alpha = radtodeg(alpha);
subplot(2,4,1)
surf(x,y,Energy01,'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title(['Electric Energy: Alpha = ', num2str(alpha)])
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % y-axis label

subplot(2,4,5)
contour(x,y,Energy01,'ShowText','on')
axis square
axis tight
view(0,90)
title(['Electric Energy: Alpha = ', num2str(alpha)])
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

%% SECOND
alpha = pi/6;
height = 10.1; width = 10.1;
x = -width:0.2:width;
y = -height:0.2:height; 
[~, EFieldZX, EFieldZY, EFieldZZ] = ...
    UVLinearElectricField(1, 100, alpha, 1, 1, height, width, 1, 0);
Energy30 = (abs(EFieldZX).^2 + abs(EFieldZY).^2 + abs(EFieldZZ).^2)/(16*pi);
alpha = radtodeg(alpha);
subplot(2,4,2)
surf(x,y,Energy30,'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title(['Electric Energy: Alpha = ', num2str(alpha)])
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % y-axis label

subplot(2,4,6)
contour(x,y,Energy30,'ShowText','on')
axis square
axis tight
view(0,90)
title(['Electric Energy: Alpha = ', num2str(alpha)])
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

%% THIRD
alpha = pi/3;
height = 7.5; width = 7.5;
x = -width:0.2:width;
y = -height:0.2:height; 

[~, EFieldZX, EFieldZY, EFieldZZ] = ...
    UVLinearElectricField(1, 100, alpha, 1, 1, height, width, 1, 0);
Energy60 = log(abs(EFieldZX).^2 + abs(EFieldZY).^2 + abs(EFieldZZ).^2)/(16*pi);
alpha = radtodeg(alpha);
subplot(2,4,3)
surf(x,y,Energy60,'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title(['Electric Energy: Alpha = ', num2str(alpha)])
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % y-axis label

subplot(2,4,7)
contour(x,y,Energy60,'ShowText','on')
axis square
axis tight
view(0,90)
title(['Electric Energy: Alpha = ', num2str(alpha)])
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label

%% FOURTH
height = 10.1; width = 10.1;
x = -width:0.2:width;
y = -height:0.2:height; 
alpha = pi/2;
[~, EFieldZX, EFieldZY, EFieldZZ] = ...
    UVLinearElectricField(1, 100, alpha, 1, 1, height, width, 1, 0);
Energy90 = log(abs(EFieldZX).^2 + abs(EFieldZY).^2 + abs(EFieldZZ).^2)/(16*pi);
alpha = radtodeg(alpha);
subplot(2,4,4)
surf(x,y,Energy90,'EdgeColor','none')
colorbar
axis square
axis tight
view(0,90)
title(['Electric Energy: Alpha = ', num2str(alpha)])
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % y-axis label

subplot(2,4,8)
contour(x,y,Energy90,'ShowText','on')
axis square 
axis tight
view(0,90)
title(['Electric Energy: Alpha = ', num2str(alpha)])
xlabel('X-Direction') % x-axis label
ylabel('Y-Direction') % Y-axis label