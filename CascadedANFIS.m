clc;
clear;
close all;
warning('off','all');

DataFile = 'D:\ML\Cascaded_ANFIS_matlab\train.csv';
DataFileTemp = 'D:\ML\Cascaded_ANFIS_matlab\temp.csv';

%% Global variables
mfNum = 3;
mfType = "gaussmf";
maxLevels = 10;
epoch = 2;
PairingMethod = 1;

for i=1:maxLevels
    if i == 1
        %% Load Initial Data
        data=LoadData(DataFile);
    else
        %% Load Temp Data
        data=LoadDataTemp(DataFileTemp);
    end
    %% Casaceded ANFIS STEP 1 : Pairing
    if PairingMethod == 1  % Random Pairing
        x = data.nInputs;
        for input = 1:x
            y = setdiff(1:x, input);
            r = y(randi(numel(y)));   
            pair =  [input r];
            fis=CreateANFIS(data.TrainInputs(:,pair),data.TrainTargets,mfType,mfNum,epoch);
            output = evalfis (fis,data.TrainInputs(:,pair));
            
            if input == 1
                out = output;
            else
                out = horzcat(out,output);
            end

            % file name generation
            chr1 = int2str(i);
            chr2 = int2str(input);
            
            FISfn = append('FIS\FIS_',chr1,'_',chr2);
            Pairfn = append('PAIRS\PAIRS_',chr1,'_',chr2);
            
            % save variables for testing            
            save(Pairfn,"pair")
            writeFIS(fis,FISfn); 
        end
        out = horzcat(out,data.TrainTargets);
        writematrix(out,'temp.csv','Delimiter',','); % write temp csv (previouse outputs of each ANFIS)
        %disp(out);
    end
end
