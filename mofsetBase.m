Vth = 1.0;    % Tensione di soglia (V)
k = 0.5;      % Costante del Mosfet (A/V^2)

% Intervalli di tensioni
VGS = linspace(0, 5, 100);  % V gate-source (V)
VDS = linspace(0, 5, 100);  % V drain-source (V)

% Inizializzo matrice corrente ID
ID = zeros(length(VGS), length(VDS));

% Calcolo corrente ID per ogni coppia di VGS e VDS
for i = 1:length(VGS)
    for j = 1:length(VDS)
        if VGS(i) < Vth  % Regione di Cut-off
            ID(i,j) = 0;
        elseif VDS(j) < (VGS(i) - Vth)  % Regione Lineare
            ID(i,j) = k * ((VGS(i) - Vth) * VDS(j) - VDS(j)^2 / 2);
        else  % Regione di Saturazione
            ID(i,j) = k / 2 * (VGS(i) - Vth)^2;
        end
    end
end

% ID as funct of VDS for != VGS
figure;
hold on;
for i = 1:10:length(VGS)  
    plot(VDS, ID(i,:), 'DisplayName', sprintf('V_G_S = %.1f V', VGS(i)));
end

xlabel('V_D_S (V)');
ylabel('I_D (A)');
title('I_D - V_D_S curve for different V_G_S of MOSFET');
legend;
grid on;

text(2, 0.2, 'Linear Region', 'FontSize', 12, 'Color', 'blue');
text(3.5, 0.7, 'Saturation Region', 'FontSize', 12, 'Color', 'red');

hold off;
