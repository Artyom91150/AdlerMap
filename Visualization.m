function  Visualization(Map)

ValueArray = Map.LambdaArray;
MapParam = Map.MapParam;
PhaseModeArray = Map.PhaseModeArray;

%Параметры карты
FirstParamStep = MapParam(1);
SecondParamStep = MapParam(2);
FirstParamBorder = [MapParam(3), MapParam(4)];
SecondParamBorder = [MapParam(5), MapParam(6)];
Width = MapParam(7);
Height = MapParam(8);

%Цветовая палитра
ColorMap = colorcube;
%ColorMap = lines;
%Map = parula;




% ColorMap = [
%                      
%                      0         0    1.0000;
%                      0    0.0317    0.9841;
%                      0    0.0635    0.9683;
%                      0    0.0952    0.9524;
%                      0    0.1270    0.9365;
%                      0    0.1587    0.9206;
%                      0    0.1905    0.9048;
%                      0    0.2222    0.8889;
%                      0    0.2540    0.8730;
%                      0    0.2857    0.8571;
%                      0    0.3175    0.8413;
%                      0    0.3492    0.8254;
%                      0    0.3810    0.8095;
%                      0    0.4127    0.7937;
%                      0    0.4444    0.7778;
%                      0    0.4762    0.7619;
%                      0    0.5079    0.7460;
%                      0    0.5397    0.7302;
%                      0    0.5714    0.7143;
%                      0    0.6032    0.6984;
%                      0    0.6349    0.6825;
%                      0    0.6667    0.6667;
%                      0    0.6984    0.6508;
%                      0    0.7302    0.6349;
%                      0    0.7619    0.6190;
%                      
%                      1    170/255    100/255;
% 
%                      1    1    110/255;
%                      1    0.3    1;
%                      0.7    1.0000    0.5000];
                 

                 
%ValueArray =length(ColorMap) - transpose(ValueArray) + 1;
ValueArray = transpose(ValueArray)*3 + 50;

%ValueArray =length(ColorMap) - transpose(ValueArray) + 1;


figure
hold all

%Настройки графика

[Xparam1, Yparam1] = meshgrid(FirstParamBorder(1) : FirstParamStep : FirstParamBorder(2));
[Xparam2, Yparam2] = meshgrid(SecondParamBorder(1) : SecondParamStep : SecondParamBorder(2));

pc = pcolor(Xparam1, Yparam2, ValueArray);
pc.EdgeColor = 'none';

ColorMin = 1;
ColorMax = 256;
%pcolor([-10, -9, -8;-10, -9, -8], [-10, -10, -10;-9, -9, -9], [1, 1, 1; 256, 256, 256]);

pcolor([-10, -9;-10, -9], [-10, -10;-9, -9], [ColorMin, ColorMin; ColorMin, ColorMin]);
pcolor([-11, -10;-11, -10], [-10, -10;-9, -9], [ColorMax, ColorMax; ColorMax, ColorMax]);



colormap(ColorMap);
%shading flat;
%shading interp

%Массивы координат
% Xparam = FirstParamBorder(1) : FirstParamStep : FirstParamBorder(2);
% Yparam = SecondParamBorder(1) : SecondParamStep : SecondParamBorder(2);

% for i = 1 : length(ValueArray) - 1
%    for j  = 1 : length(ValueArray) - 1
% 
%        patch([Xparam(i), Xparam(i + 1), Xparam(i + 1), Xparam(i)], ...
%              [Yparam(j), Yparam(j), Yparam(j + 1), Yparam(j + 1)], ...
%              ColorMap(ValueArray(j, i), :), 'EdgeColor', 'none');
% 
%    end
% end




% for i = 1 : length(PhaseModeArray)
%    for j  = 1 : length(PhaseModeArray)
%       if  PhaseModeArray(i, j) == 1
%           plot(FirstParamBorder(1) + (i - 1) * FirstParamStep, ...
%               SecondParamBorder(1) + (j - 1) * SecondParamStep, '+', 'MarkerEdgeColor', 'red');
%       else if PhaseModeArray(i, j) == 2
%           plot(FirstParamBorder(1) + (i - 1) * FirstParamStep, ...
%               SecondParamBorder(1) + (j - 1) * SecondParamStep, '+', 'MarkerEdgeColor', 'yellow');
%           end
%       end
%    end
% end



xlim([FirstParamBorder(1), FirstParamBorder(2)]);
ylim([SecondParamBorder(1), SecondParamBorder(2)]);


FontSize = 34; AxisFontSize = 34;


set(gcf, 'Position', [625 426 839 746]);
%set(gcf, 'Position', [360 79 738 568]);
axis square;
ax = gca;


ax.XTick = [0, pi / 4, pi / 2, 3*pi/4, pi];
ax.XTickLabel = {'0', '$\frac{\pi}{4}$', '$\frac{\pi}{2}$', '$\frac{3\pi}{4}$', '$\pi$'};



ax.TickLabelInterpreter = 'latex';

set(gca, 'FontSize', AxisFontSize);

xlabel('$\sigma$', 'Interpreter', 'latex', 'FontSize', FontSize );
%xlabel('$\triangle$', 'Interpreter', 'latex', 'FontSize', FontSize );

ylabel('$d$', 'Interpreter', 'latex', 'FontSize', FontSize );

%title(['$Map: ', 'Inhibitory',...
%       ', Resolution: ', num2str(Width), '\times', num2str(Height), ...
%       ', K \in(', num2str(FirstParamBorder(1)), '; ', num2str(FirstParamBorder(2)), ')' ...
%       ', r \in(', num2str(SecondParamBorder(1)), '; ', num2str(SecondParamBorder(2)), ')$'], ...
%       'Interpreter', 'latex', 'FontSize', 14 );

%clb = colorbar('Ticks',[1, 64] , ...
%               'TickLabels', {num2str(MinPositive), num2str(MaxPositive)});


           
%colormap(clb, Map);

Color = 'w';

%text(0.4966, 2.7276,'$S_1$', 'FontSize',40, 'interpreter', 'latex', 'Color', 'black');
%text(0.9848, 2.7276,'$S_2$', 'FontSize',40, 'interpreter', 'latex', 'Color', Color);
%text(0.6861, 2.2890,'$S_3$', 'FontSize',40, 'interpreter', 'latex', 'Color', Color);
%text(0.9861, 2.3241,'$S_4$', 'FontSize',40, 'interpreter', 'latex', 'Color', Color);
%text(0.9861, 2.1255,'$S_5$', 'FontSize',40, 'interpreter', 'latex', 'Color', 'black');
%text(2.5891, 2.5552,'$S_6$', 'FontSize',40, 'interpreter', 'latex');
%text(0.6392, 1.6138,'$S_7$', 'FontSize',40, 'interpreter', 'latex');
%text(2.0908, 1.8414,'$S_8$', 'FontSize',40, 'interpreter', 'latex');
%text(2.6216, 1.5103,'$S_9$', 'FontSize',40, 'interpreter', 'latex');

%text(0.4658, 0.6724,'$S_{10}$', 'FontSize',40, 'interpreter', 'latex');
%text(2.2750, 0.6414,'$S_{11}$', 'FontSize',40, 'interpreter', 'latex');

%text(2.8003, 0.1869,'$S_{12}$', 'FontSize',40, 'interpreter', 'latex');
%text(2.5905, 0.3426,'$S_{13}$', 'FontSize',40, 'interpreter', 'latex');
%text(2.7570, 0.3347,'$S_{14}$', 'FontSize',40, 'interpreter', 'latex');
%text(2.6649, 0.3347,'$S_{15}$', 'FontSize',40, 'interpreter', 'latex');
%text(3.0387, 0.1652,'$S_{16}$', 'FontSize',40, 'interpreter', 'latex');

% annotation('arrow',[0.37125748502994 0.364071856287425],...
%    [0.176691729323308 0.135338345864662]);
%annotation('arrow',[0.748502994011976 0.743712574850299],...
%    [0.201754385964912 0.137844611528822]);



end

