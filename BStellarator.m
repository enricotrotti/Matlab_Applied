R0 = 1; % Big radius (m)
a = 0.3; % small radius (m)
I_toroidal = 100000; % (A)
I_poloidal = 1000; % (A)
mu_0 = 4 * pi * 1e-7; % vacuum permeability (H/m)
n = 5; % elicoidal loops
m = 2; %poloidali loops

theta = linspace(0, 2*pi, 50); % toroidal angle
phi = linspace(0, 2*pi, 50); % poloidal angle
[THETA, PHI] = meshgrid(theta, phi);

R = R0 + a * cos(PHI); % effective radius as funct of phi
X = R .* cos(THETA);
Y = R .* sin(THETA);
Z = a * sin(PHI);

B_toroidal = (mu_0 * I_toroidal) ./ (2 * pi * R);
B_poloidal = (mu_0 * I_poloidal) / (2 * pi * R0);

B_helical_x = -B_toroidal .* sin(THETA + m * PHI);
B_helical_y = B_toroidal .* cos(THETA + m * PHI);
B_helical_z = B_poloidal .* cos(PHI);

figure;

quiver3(X, Y, Z, B_helical_x, B_helical_y, B_helical_z, 'r');
hold on;

xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
title('B lines in stellarator');
axis equal;
grid on;
view(3);

