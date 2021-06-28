%% --------------------------Параметры---------------------------------- %%

%X_0 = [0, 0; 0, pi/2; 0, pi; 0, 3*pi/2];
%X_0 = [1.6957, 1.6957];
%X_0 = [3*pi/2, pi/2];
X_0 = [0, 0];
Tspan = [0 2000];
%opts = odeset('RelTol',1e-5,'AbsTol',1e-7, 'MaxStep', 1e-1);
opts = odeset('RelTol',1e-6,'AbsTol',1e-7, 'MaxStep', 1e-1);
%opts = odeset('MaxStep', 1);
%opts = odeset();


IntegrationParam = struct('InitCondition', X_0, 'Tspan', Tspan, 'Options', opts);

%Параметры карты
Width = 1;
Height = 100;

% FirstParamBorder = [0, 1.2];
% SecondParamBorder = [2, 3];

FirstParamBorder = [pi/2, pi/2];
SecondParamBorder = [0, 0.5];

FirstParamStep = (FirstParamBorder(2) - FirstParamBorder(1)) / (Width - 1);
FirstParamStep= 1;
SecondParamStep = (SecondParamBorder(2) - SecondParamBorder(1)) / (Height - 1);

MapParam = [FirstParamStep, SecondParamStep, FirstParamBorder, SecondParamBorder, Width, Height];

d = 1.060209;
d = SecondParamBorder(1) + SecondParamStep * 24;
delta = 0.01;
Gamma = [1.01, 1.01 + delta];
Sigma = pi/2;
Sigma = FirstParamBorder(1) + FirstParamStep * 9;

SystemParam = struct('Gamma', Gamma, 'd', d, 'Sigma', Sigma);

Mode = 3;

%%

%Graphics(Sigma, d, SystemParam, IntegrationParam);
    %figure;
    %TimeSeries(Sigma, d, SystemParam, X_0);
%[K, P] = GetValue_1(SystemParam, IntegrationParam);
R = RotateValue(SystemParam, IntegrationParam);


%F2 = F2func(0:0.1:2*pi, 40, pi/2 - Sigma, 2 * Sigma)

%% Карта режимов
Time = datetime;

[ValueArray, PhaseModeArray] = GetValueArray(MapParam, SystemParam, IntegrationParam);
%[ValueArray, PhaseModeArray] = GetValueArray(MapParam, SystemParam, IntegrationParam);

disp(datetime - Time);

Map = struct('LambdaArray', ValueArray, 'MapParam', MapParam, 'PhaseModeArray', PhaseModeArray);
save('LastMap', 'Map');

%%

Visualization(Map);
%Sigma_d_Equations(Gamma);


%% Число вращений
Time = datetime;

[KValueArray, RValueArray] = Rotatemap(MapParam, SystemParam, IntegrationParam);
%[ValueArray, PhaseModeArray] = GetValueArray(MapParam, SystemParam, IntegrationParam);

disp(datetime - Time);

RMap = struct('KValueArray', KValueArray, 'RValueArray', RValueArray, 'MapParam', MapParam);
save('LastRotateMap', 'RMap');

%%

RotateVisualisation(RMap);

%%
% FontSize = 30;
% Phi = linspace(0, 2*pi, 1000);
% D = [pi/2 - Sigma, pi/2 + Sigma];
% 
% F2 = F2func(Phi, -500, 2*Sigma, D(1));
% 
% figure;
% 
% 
% plot(Phi, F2, 'LineWidth', 3);
% ax = gca;
% ax.XTick = [0, D(1), pi / 2, D(2), 2 * pi];
% ax.XTickLabel = {'0', '$\frac{\pi}{2} - \sigma$', '$\frac{\pi}{2}$', '$\frac{\pi}{2} + \sigma$', '$2\pi$'};
% ax.TickLabelInterpreter = 'latex';
% ax.Box = 'on';
% ax.FontSize = FontSize;
% xlim([0, 2 * pi]);
% ax.XLabel.String = '\phi';
% ax.XLabel.FontSize = 40;
% ax.YLabel.String = 'I(\phi)';
% ax.YLabel.FontSize = 40;
% 
% 
% axis square;
% 
% fig = gcf;
% fig.Position = [44 89 829 772];

%%
% figure;
% hold all;
% 
% fill([D(1), D(2), D(2), D(1)], [0, 0, 2 * pi, 2 * pi], [159/255, 1, 160/255], 'EdgeColor', 'none');
% fill([0, 0, 2 * pi, 2 * pi], [D(1), D(2), D(2), D(1)], [58/255, 183/255, 255/255], 'EdgeColor', 'none');
% fill([D(1), D(2), D(2), D(1)], [D(1), D(1), D(2), D(2)], [100/255, 219/255, 207/255], 'EdgeColor', 'none');
% 
% ax = gca;
% ax.XTick = [0, D(1), pi / 2, D(2), 2 * pi];
% ax.XTickLabel = {'0', '$\frac{\pi}{2} - \sigma$', '$\frac{\pi}{2}$', '$\frac{\pi}{2} + \sigma$', '$2\pi$'};
% ax.YTick = [0, D(1), pi / 2, D(2), 2 * pi];
% ax.YTickLabel = {'0', '$\frac{\pi}{2} - \sigma$', '$\frac{\pi}{2}$', '$\frac{\pi}{2} + \sigma$', '$2\pi$'};
% ax.TickLabelInterpreter = 'latex';
% ax.Box = 'on';
% ax.FontSize = FontSize;
% xlim([0, 2 * pi]);
% ylim([0, 2 * pi]);
% ax.XLabel.String = '\phi_1';
% ax.XLabel.FontSize = 40;
% ax.YLabel.String = '\phi_2';
% ax.YLabel.FontSize = 40;
% axis square;
% 
% fig = gcf;
% fig.Position = [44 89 829 772];

% figure;
% plot(0:0.1:2*pi, F2, 'LineWidth', 3);
% ax = gca;
% ax.XTick = [0, D(1), pi / 2, D(2), 2 * pi];
% ax.XTickLabel = {'0', '$\alpha$', '$\frac{\pi}{2}$', '$\alpha + \delta$', '$2\pi$'};
% ax.TickLabelInterpreter = 'latex';
% ax.Box = 'on';
% ax.FontSize = FontSize;
% xlim([0, 2 * pi]);
% ax.XLabel.String = '\phi';
% ax.YLabel.String = 'I(\phi)';

% %Матрица соотношений
% Matr = zeros(25, 1);
% k = 1;
% for i = 1 : 5
%     for j = 1: 5
%        Matr(k) = i / j;
%        k = k + 1;
%     end
% end
% text(0.1, 0.1,'$S_1$', 'FontSize',40, 'interpreter', 'latex');
%%




%%

   [Xparam, Yparam] = ginput;
   %Graphics(Xparam, Yparam, SystemParam, IntegrationParam);
   

   
   %области с различными режимами
   figure;

   PhaseSpace0_3(Xparam, Yparam, SystemParam)
   
    %figure;
%    %Фазовый портрет с временными диаграммами
    %PhaseSpace0_2(Xparam, Yparam, SystemParam)
%    %Временные диаграммы
    %
    TimeSeries(Xparam, Yparam, SystemParam, X_0);


