function [KValueArray, RValueArray] = Rotatemap(MapParam, SystemParam, IntParam)

%Параметры карты и обход параметров

FirstParamStep = MapParam(1);
SecondParamStep = MapParam(2);
FirstParamBorder = [MapParam(3), MapParam(4)];
SecondParamBorder = [MapParam(5), MapParam(6)];
Width = MapParam(7);
Height = MapParam(8);

FirstParam = FirstParamBorder(1) : FirstParamStep : FirstParamBorder(2);
SecondParam = SecondParamBorder(1) : SecondParamStep : SecondParamBorder(2);

RValueArray = zeros(Width, Height);  
KValueArray = zeros(Width, Height);  
                
CurrentIntParam = IntParam;

[FirstParamMesh, SecondParamMesh] = meshgrid(FirstParam, SecondParam);


Time = datetime;
Gamma = SystemParam.Gamma;
parfor ii = 1 : Width * Height
    [K, R, X_0] = RotateValue(struct('Sigma', FirstParamMesh(ii), 'd', SecondParamMesh(ii), 'Gamma', Gamma), CurrentIntParam);
    RValueArray(ii) = R;
    KValueArray(ii) = K;
    disp(['Cell with FirstParam = :   ', num2str(FirstParamMesh(ii)), 'SecondParam = :   ', num2str(SecondParamMesh(ii)), '  Completed']);
end
disp(datetime - Time);
RValueArray = RValueArray';
KValueArray = KValueArray';

                

end