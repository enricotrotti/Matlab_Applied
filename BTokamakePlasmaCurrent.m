R0 = 1; 
a = 0.3; 
I_toroidal = 100000; 
I_poloidal = 1000; 
mu_0 = 4 * pi * 1e-7; % (H/m)

theta = linspace(0, 2*pi, 100); 
phi = linspace(0, 2*pi, 100); 
[THETA, PHI] = meshgrid(theta, phi);

R = R0 + a * cos(PHI); 
X = R .* cos(THETA);
Y = R .* sin(THETA);
Z = a * sin(PHI);


R_eff = sqrt(X.^2 + Y.^2); 
R_eff(R_eff == 0) = 1e-6; 
B_toroidal = (mu_0 * I_toroidal) ./ (2 * pi * R_eff);

B_poloidal = (mu_0 * I_poloidal) / (2 * pi * R0); 

Bx = -B_toroidal .* sin(THETA); 
By = B_toroidal .* cos(THETA);
Bz = B_poloidal .* cos(PHI); 

num_points = 20; 
line_theta = linspace(0, 2*pi, num_points); 
line_X = (R0) * cos(line_theta); 
line_Y = (R0) * sin(line_theta);
line_Z = zeros(size(line_theta)); 

J_theta = 1;
Jx_line = -J_theta * sin(line_theta);
Jy_line = J_theta * cos(line_theta);
Jz_line = zeros(size(line_theta)); 

figure;

quiver3(X, Y, Z, Bx, By, Bz, 'r');
hold on;

quiver3(line_X, line_Y, line_Z, Jx_line, Jy_line, Jz_line, 'b', 'LineWidth', 1.5);

xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
title('Magnetic Field and Plasma Current Vectors in a Tokamak');
legend('Magnetic Field', 'Plasma Current');
axis equal;
grid on;
view(3);
