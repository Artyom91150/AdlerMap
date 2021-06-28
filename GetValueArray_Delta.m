function [ValueArray, PhaseModeArray] = GetValueArray_Delta(MapParam, SystemParam, IntParam)

%Параметры карты и обход параметров

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
    
                
CurrentIntParam = IntParam;

[FirstParamMesh, SecondParamMesh] = meshgrid(FirstParam, SecondParam);

Sigma = SystemParam.Sigma;
Time = datetime;
Gamma = SystemParam.Gamma;
parfor ii = 1 : Width * Height
    [K, P, X_0] = GetValue_1(struct('Sigma', Sigma, 'd', SecondParamMesh(ii), 'Gamma', [Gamma(1), Gamma(2) + FirstParamMesh(ii)]), CurrentIntParam);
    ValueArray(ii) = K;
    PhaseModeArray(ii) = P;
    disp(['Cell with FirstParam = :   ', num2str(FirstParamMesh(ii)), 'SecondParam = :   ', num2str(SecondParamMesh(ii)), '  Completed']);
end
disp(datetime - Time);
ValueArray = ValueArray';

                

end

