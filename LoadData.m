
function data=LoadData(name)

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

  
    % Train Data
    pTrain=0.7;
    nTrain=round(pTrain*nSample);
    TrainInputs=Inputs(1:nTrain,:);
    TrainTargets=Targets(1:nTrain,:);
    
    % Test Data
    TestInputs=Inputs(nTrain+1:end,:);
    TestTargets=Targets(nTrain+1:end,:);
    
%     Export
    data.TrainInputs=TrainInputs;
    data.TrainTargets=TrainTargets;
    data.TestInputs=TestInputs;
    data.TestTargets=TestTargets;
    data.nInputs = nInputs;
    data.nSample = nSample;   
    
end
