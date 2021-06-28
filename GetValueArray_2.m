function [ValueArray, PhaseModeArray] = GetValueArray_2(MapParam, SystemParam, IntParam)

%��������� ����� � ����� ����������

FirstParamStep = MapParam(1);
SecondParamStep = MapParam(2);
FirstParamBorder = [MapParam(3), MapParam(4)];
SecondParamBorder = [MapParam(5), MapParam(6)];
Width = MapParam(7);
Height = MapParam(8);

FirstParam = FirstParamBorder(1) : FirstParamStep : FirstParamBorder(2);
SecondParam = SecondParamBorder(1) : SecondParamStep : SecondParamBorder(2);

ValueArray = zeros(Width, Height);
PhaseModeArray = zeros(Width, Height);   
                
for j = 1 : Height
    
    CurrentIntParam = IntParam;
    %CurrentIntParam.InitCondition = [pi/2 + SystemParam.Sigma, pi/2 + SystemParam.Sigma - 0.00001];
    %CurrentIntParam.InitCondition = [pi/2 - SystemParam.Sigma - 0.8, pi/2 - SystemParam.Sigma - 0.3];
        
    Time = datetime;
    
    for i = 1 : Width
        
        %���������� ���������� �������
        SystemParam.Sigma = FirstParam(i);
        SystemParam.d = SecondParam(j);
       
        [K, P, X_0] = GetValue_1(SystemParam, CurrentIntParam);
        CurrentIntParam.InitCondition = X_0;
            
        ValueArray(i, j) = K;
        PhaseModeArray(i, j) = P;
        
    end
    disp(['Progress:   ', num2str(100 * j / Width), '%']);
    disp(datetime - Time);
end

end