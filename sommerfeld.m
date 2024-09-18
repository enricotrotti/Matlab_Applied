E_f0 = 5; % Fermi lvl at T=0
k_B = 1; % approximate
T1 = 0; 
T2 = 0.5; 
E = linspace(0, 8, 1000);

g_E = E.^(1/2); % DOS

f_T0 = zeros(size(E));
f_T0(E <= E_f0) = 1;

f_T1 = 1 ./ (1 + exp((E - E_f0) / (k_B * T2))); %T>0

figure;
hold on;

plot(E, g_E, 'k', 'LineWidth', 2); 
text(7, 2.5, 'g(\epsilon)', 'FontSize', 12); 

%Il prodotto della densità degli stati g(E) per la funzione FermiDirac f(E) fornisce la densità di stati 
% occupati con energia compresa tra E e E+dE

plot(E, f_T0 .* g_E, 'b', 'LineWidth', 2); 
text(4, 0.5, 'f(\epsilon)g(\epsilon)', 'FontSize', 12);
text(4, 0.3, 'T=0', 'FontSize', 12); 

plot(E, f_T1 .* g_E, 'r', 'LineWidth', 2); 
text(6, 0.6, 'f(\epsilon)g(\epsilon)', 'FontSize', 12);
text(6, 0.4, 'T>0', 'FontSize', 12); 

line([E_f0 E_f0], [0 3], 'Color', 'k', 'LineStyle', '--');
text(E_f0 - 0.45, 2.8, '\epsilon_{F0}', 'FontSize', 12);

E_fT = E_f0 + 0.5; 
line([E_fT E_fT], [0 3], 'Color', 'r', 'LineStyle', '--');
text(E_fT + 0.1, 2.8, '\epsilon_{FT}', 'FontSize', 12);

xlabel('Electron Energy (\epsilon)', 'FontSize', 12);
ylabel('Density of States, or Occupied Density', 'FontSize', 12);
title('Density of states and FD distribution', 'FontSize', 14);

xlim([0 8]);
ylim([0 4]);

grid on;
hold off;
