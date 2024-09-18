thermalmodel = createpde('thermal', 'steadystate');

L = 0.01; % Larghezza del chip (m)
W = 0.01; % Lunghezza
H = 0.001; % Altezza

g = multicuboid(L, W, H);
thermalmodel.Geometry = g;

figure
pdegplot(thermalmodel, 'FaceLabels', 'on');
title('Geometria del chip GaN-Silicio');
xlabel('X (m)')
ylabel('Y (m)')
zlabel('Z (m)')
grid on;

k_GaN = 130; % Conducibilità termica del GaN (W/m·K)
thermalProperties(thermalmodel, 'ThermalConductivity', k_GaN);

side_length = 0.0045;
center_position = [0.0015, 0.0015, 0.0005]; 
Q_source = 5e7; % Potenza dissipata (W/m^3)

% Sorgente di calore quadrata
internalHeatSource(thermalmodel, @(region,state) squareHeatSource(region, state, Q_source, side_length, center_position));

% Condizione al contorno: fissare la temperatura sulla faccia inferiore
thermalBC(thermalmodel, 'Face', 1, 'Temperature', 25); % Faccia inferiore

% Mesh 3D più fine
generateMesh(thermalmodel, 'Hmax', 0.0005);

% Risolvere il problema termico in stato stazionario
result = solve(thermalmodel);

figure
pdeplot3D(thermalmodel, 'ColorMapData', result.Temperature);
title('Distribuzione della temperatura nel chip con sorgente quadrata');
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
colorbar;

% Output della T max
T_max = max(result.Temperature);
fprintf('La temperatura massima nel chip è %.2f °C\n', T_max);

% Generare una sorgente di calore quadrata
function Q = squareHeatSource(region, state, Q_source, side_length, center_position)
    % Verifica se il punto è all'interno della sorgente quadrata
    inside = (region.x >= center_position(1) - side_length/2) & ...
             (region.x <= center_position(1) + side_length/2) & ...
             (region.y >= center_position(2) - side_length/2) & ...
             (region.y <= center_position(2) + side_length/2) & ...
             (region.z >= center_position(3) - side_length/2) & ...
             (region.z <= center_position(3) + side_length/2);
    % Applicare la potenza dissipata se all'interno della geometria della sorgente
    Q = double(inside) * Q_source;
end
