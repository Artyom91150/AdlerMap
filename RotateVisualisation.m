function  RotateVisualisation(RMap)

MapParam = RMap.MapParam;

%Параметры карты
FirstParamStep = MapParam(1);
SecondParamStep = MapParam(2);
FirstParamBorder = [MapParam(3), MapParam(4)];
SecondParamBorder = [MapParam(5), MapParam(6)];
Width = MapParam(7);
Height = MapParam(8);

%Цветовая палитра


figure
hold all

%Настройки графика

ColorMap = colorcube;
KValueArray = transpose(RMap.KValueArray)*3 + 50;

[Xparam1, Yparam1] = meshgrid(FirstParamBorder(1) : FirstParamStep : FirstParamBorder(2));
[Xparam2, Yparam2] = meshgrid(SecondParamBorder(1) : SecondParamStep : SecondParamBorder(2));

s = surf(Xparam1, Yparam2, RMap.RValueArray', KValueArray);

ColorMin = 1;
ColorMax = 256;
%pcolor([-10, -9, -8;-10, -9, -8], [-10, -10, -10;-9, -9, -9], [1, 1, 1; 256, 256, 256]);

pcolor([-10, -9;-10, -9], [-10, -10;-9, -9], [ColorMin, ColorMin; ColorMin, ColorMin]);
pcolor([-11, -10;-11, -10], [-10, -10;-9, -9], [ColorMax, ColorMax; ColorMax, ColorMax]);



colormap(ColorMap);


FontSize = 34; AxisFontSize = 34;
xlim([FirstParamBorder(1), FirstParamBorder(2)]);
ylim([SecondParamBorder(1), SecondParamBorder(2)]);


set(gcf, 'Position', [625 426 839 746]);
%set(gcf, 'Position', [360 79 738 568]);
axis square;
ax = gca;

s.EdgeColor = 'none';


ax.XTick = [0, pi / 4, pi / 2, 3*pi/4, pi];
ax.XTickLabel = {'0', '$\frac{\pi}{4}$', '$\frac{\pi}{2}$', '$\frac{3\pi}{4}$', '$\pi$'};



ax.TickLabelInterpreter = 'latex';

set(gca, 'FontSize', AxisFontSize);

xlabel('$\sigma$', 'Interpreter', 'latex', 'FontSize', FontSize );
%xlabel('$\triangle$', 'Interpreter', 'latex', 'FontSize', FontSize );

ylabel('$d$', 'Interpreter', 'latex', 'FontSize', FontSize );




end