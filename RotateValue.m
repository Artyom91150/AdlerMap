function [K, R, X_0] = RotateValue(SystemParam, IntParam)

Tstart = 500;

SyncN = 10;
R = 0;

%Матрица соотношений
Matr = zeros(SyncN^2, 1);

k = 1;
for i = 1 : SyncN
    for j = 1: SyncN
       Matr(k) = i / j;
       k = k + 1;
    end
end

X_0 = IntParam.InitCondition;
%X_0 = [pi/2 + SystemParam.Sigma, pi/2 + SystemParam.Sigma - 0.00001];
%X_0 = [pi/2 - SystemParam.Sigma, pi/2 + SystemParam.Sigma/2];
%X_0 = [pi/2 - SystemParam.Sigma, pi/2 + SystemParam.Sigma + 0.5];


%Переходный процесс
[T, X] = ode23(@(T, X) AdlerSystem(X, SystemParam), [0 Tstart], X_0, IntParam.Options);
X_0 = mod(X(end, :), 2 * pi);


[T, X] = ode23(@(T, X) AdlerSystem(X, SystemParam), [Tstart Tstart + IntParam.Tspan(2)], X_0, IntParam.Options);
X_0 = mod(X(end, :), 2 * pi);

Start = 1;
while (Start < length(X) - 1)&&(mod(abs(X(Start, 1) - X(Start, 2)), 2*pi) > 1e-2)
   Start = Start + 1; 
end

End = length(X) - 1;
while (End > Start)&&(mod(abs(X(End, 1) - X(End, 2)), 2 * pi) > 1e-2)
   End = End - 1; 
end

if abs(End - Start) < 200
    Start = 1;
    End = length(X) - 1;
end

AvgDifference = 0;
FirstAvg = 0;
SecondAvg = 0;
for i = Start : End
   AvgDifference = AvgDifference + abs(X(i, 1) - X(i, 2));
   FirstAvg = FirstAvg + abs(X(i, 1) - X(i + 1, 1));
   SecondAvg = SecondAvg + abs(X(i, 2) - X(i + 1, 2));
end
%AvgDifference = AvgDifference / (End - Start);

Spike1 = (X(End, 1) - X(Start, 1));
Spike2 = (X(End, 2) - X(Start, 2));


%Определение числа вращения
%R = NearestSyncR(abs(Spike1 / Spike2), Matr, 0.001);

if (Spike1 < 1) && (Spike2 < 1) && (FirstAvg < 1e-5) && (SecondAvg < 1e-5)
    K = 1;
else if (Spike1 < 1) && (Spike2 < 1) && (FirstAvg >= 1e-5) && (SecondAvg >= 1e-5)
        K = 2;
        %Первый давит второго
    else if (Spike1 > 1) && (Spike2 < 1)
            K = 3;
            %Второй давит первого
        else if (Spike1 < 1) && (Spike2 > 1)
                K = 4;
            else
                [K1, R] = NearestSync(abs(Spike1 / Spike2), Matr, 0.05);
                K = 10 + K1;
            end
        end
    end
end


% figure
% hold all
% plot(T, mod(X, 2*pi))
% plot([T(Start) T(Start)], [0 6])
% plot([T(End) T(End)], [0 6])


end

function [K, R] = NearestSync(Value, Matr, eps)

Dif = inf;
R = length(Matr);
K = length(Matr);

if (~isnan(Value)) && (~isinf(Value)) && (Value > 0) && (Value <= 5)

for i = 1 : length(Matr)
    CurDif = abs(Value - Matr(i));
    if (CurDif < eps) && (CurDif < Dif)
        Dif = CurDif;
        R = Matr(i);
        K = i;
    end
end

if(R == length(Matr))
    R = Value;
end

else
   R = 0; 
end

end