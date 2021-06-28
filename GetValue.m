function [K, P, X_0] = GetValue(SystemParam, IntParam)

Tstart = 200;

%Номер режима
K = 0;

%1 - проитивофаза, 2 - синфаза
P = 0;

%Максимальное и минимальное значение фазы (по модулю)
FirstMax = 0;
FirstMin = 2 * pi;
SecondMax = 0;
SecondMin = 2 * pi;
FirstAvg1 = 0;
SecondAvg1 = 0;

%Матрица соотношений
Matr = zeros(25, 1);
k = 1;
for i = 1 : 5
    for j = 1: 5
       Matr(k) = i / j;
       k = k + 1;
    end
end

X_0 = IntParam.InitCondition;

%Переходный процесс
[T, X] = ode15s(@(T, X) AdlerSystem(X, SystemParam), [0 Tstart], X_0, IntParam.Options);
X_0 = mod(X(end, :), 2 * pi);


[T, X] = ode15s(@(T, X) AdlerSystem(X, SystemParam), [Tstart Tstart + IntParam.Tspan(2)], X_0, IntParam.Options);
X_0 = mod(X(end, :), 2 * pi);

%Поиск среднего значения фазы и max/min
for i = 1 : length(X)
   FirstAvg1 = FirstAvg1 + X(i, 1);
   SecondAvg1 = SecondAvg1 + X(i, 2);
   
   if FirstMax < X(i, 1)
       FirstMax = X(i, 1);
   end
   if FirstMin > X(i, 1)
       FirstMin = X(i, 1);
   end
   if SecondMax < X(i, 2)
       SecondMax = X(i, 2);
   end
   if SecondMin > X(i, 2)
       SecondMin = X(i, 2);
   end
end
FirstAvg1 = FirstAvg1 / length(X);
SecondAvg1 = SecondAvg1 / length(X);

% FirstAvg1 = FirstAvg1 / (Tstart + IntParam.Tspan(2));
% SecondAvg1 = SecondAvg1 / (Tstart + IntParam.Tspan(2));



%Определение режима системы
%СР
if (FirstAvg1 < pi) && (SecondAvg1 < pi)
    K = 1;
    %Первый давит второго
else if (abs(FirstMax - FirstMin) > 2 * pi) && (abs(SecondMax - SecondMin) < 2 * pi)
        K = 2;
        %Второй давит первого
    else if (abs(FirstMax - FirstMin) < 2 * pi) && (abs(SecondMax - SecondMin) > 2 * pi)
            K = 3;
        else
            Value = FirstAvg1 / SecondAvg1;
            i = 1;
            while  (i ~= 25) && ((Value < Matr(i) - 0.1) || (Value > Matr(i) + 0.1))
                i = i + 1;
            end
            K = 3 + i;
        end
    end
end

%Определение противофазного или синфазного режима

if (mod(abs(FirstAvg1 - SecondAvg1), 2 * pi) > pi - 0.25) && (mod(abs(FirstAvg1 - SecondAvg1), 2 * pi) < pi + 0.25) && (K == 4)
    P = 1;
else if (mod(abs(FirstAvg1 - SecondAvg1), 2 * pi) < 0.25) && (K == 4)
        P = 2;
    end
end


end

