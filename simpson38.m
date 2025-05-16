clc; clear all;

% Definición de la función
f = @(x) 1 + 2*x - 3*x.^2 + 4*x.^3 - 5*x.^4 + 6*x.^5;

% Límites de integración
a = 0;
b = 1;

% Número de subintervalos
n = 6; % Debe ser múltiplo de 6 para aplicar ambas reglas

% Paso
h = (b - a) / n;

% Puntos de evaluación
x = linspace(a, b, n + 1);
y = f(x);

% Aplicación de la regla de Simpson 1/3 compuesta
% Se aplica a los primeros 4 subintervalos (5 puntos)
I_s13 = (h/3) * (y(1) + 4*y(2) + 2*y(3) + 4*y(4) + y(5));

% Aplicación de la regla de Simpson 3/8 compuesta
% Se aplica a los últimos 2 subintervalos (4 puntos)
I_s38 = (3*h/8) * (y(5) + 3*y(6) + 3*y(7) + y(7));

% Integral aproximada total
I_total = I_s13 + I_s38;

% Valor exacto de la integral
syms xsym
f_sym = 1 + 2*xsym - 3*xsym^2 + 4*xsym^3 - 5*xsym^4 + 6*xsym^5;
I_exact = double(int(f_sym, a, b));

% Cuarta derivada de la función
f4_sym = diff(f_sym, 4);
f4 = matlabFunction(f4_sym);

% Valor medio de la cuarta derivada
x_vals = linspace(a, b, 1000);
f4_vals = abs(f4(x_vals));
f4_mean = mean(f4_vals);

% Estimación del error de truncamiento
% Error de Simpson 1/3: -(b - a)^5 / (180 * n^4) * f''''(ξ)
% Error de Simpson 3/8: -(b - a)^5 / (80 * n^4) * f''''(ξ)
% Para una estimación conjunta, se puede promediar los errores
error_s13 = ((b - a)^5 / (180 * n^4)) * f4_mean;
error_s38 = ((b - a)^5 / (80 * n^4)) * f4_mean;
error_total = error_s13 + error_s38;

% Error relativo porcentual
error_relativo = abs((I_exact - I_total) / I_exact) * 100;

% Mostrar resultados
fprintf('Integral aproximada (Simpson 1/3): %.10f\n', I_s13);
fprintf('Integral aproximada (Simpson 3/8): %.10f\n', I_s38);
fprintf('Integral aproximada total: %.10f\n', I_total);
fprintf('Valor exacto de la integral: %.10f\n', I_exact);
fprintf('Valor medio de la cuarta derivada: %.10f\n', f4_mean);
fprintf('Error de truncamiento estimado: %.10f\n', error_total);
fprintf('Error relativo porcentual: %.10f%%\n', error_relativo);
