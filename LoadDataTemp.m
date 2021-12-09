
function data=LoadDataTemp(name)

    dataraw=load(name);
    %dataraw=load('Input\IRIS\iris.csv');
    Inputs=dataraw(:,1:end-1);
    Targets=dataraw(:,end);

    nSample=size(Inputs,1);
    nInputs=size(Inputs,2);

    % Shuffle Data
    S=randperm(nSample);
    Inputs=Inputs(S,:);
    Targets=Targets(S,:);

%     Export
    data.TrainInputs=Inputs;
    data.TrainTargets=Targets;
    data.nInputs = nInputs;
    data.nSample = nSample;   
    
end
