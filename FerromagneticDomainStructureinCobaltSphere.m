Ms = 1.4e6; % Saturation magnetization A/m
A_ex = 1.3e-11; % Exchange stiffness J/m 
K1 = 5.0e5; % First anisotropy constant J/m^3
alpha = 0.01; % Damping factor
gamma = 2.21e5; % Gyromagnetic ratio m/As

r = 50e-9;
n = 40; 
[x, y, z] = sphere(n);
x = r * x;
y = r * y;
z = r * z;

% random initial magnetization directions
m = randn(n+1, n+1, 3);
m = m ./ vecnorm(m, 2, 3); % normalized vectors

% Define the Landau–Lifshitz–Gilbert equation
% m : magnetization vector (normalized), H_eff : effective field

function dm_dt = LLG(t, m, H_eff, gamma, alpha)
    cross_product = cross(m, H_eff, 3);
    dm_dt = -gamma * cross_product + alpha * cross(m, cross_product, 3);
end

figure;
quiver3(x, y, z, m(:,:,1), m(:,:,2), m(:,:,3)); % 3D vector plot of magnetization
title('Ferromagnetic Domain Structure in Cobalt Sphere');
