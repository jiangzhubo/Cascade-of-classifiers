

SENS_step8 = [];
SPEC_step8 = [];
SPEC_LOW_MAX_step8=[];
for j =1 : 50
if  ismember(j,winningclassifier) == 0%the index of classifer must not be that of the winning classifier
trainData = pca_score_feature(:,:,j);
features = trainData;
classLabels = label_spike_background;
 
%% How many trees do you want in the forest? 
nTrees = 100;
 %%
% Train the TreeBagger (Decision Forest).
B = TreeBagger(nTrees,features,classLabels, 'Method', 'classification');%
%B = TreeBagger(50,features,classLabels,'OOBPrediction','On','Method','classification'); 
%B = fitcsvm(features, classLabels,'Standardize',true,'KernelFunction','RBF',...
   % 'KernelScale','auto');
  % B = fitcsvm(features,classLabels,'KernelScale','auto','Standardize',true,...
   % 'OutlierFraction',0.05);

newData1 =test_data_spike(:,(1:64));
newData2 =test_data_spike(:,(1:64));
 
% Use the trained Decision Forest.
[predChar1,SCORES] = B.predict(newData1);
f = SCORES(:,2);
thr = unique(f);
% Predictions is a char though. We want it to be a number.
%predictedClass = str2double(predChar1);
for i =1 : length(thr)
 a = length(find(f > thr(i)  & test_data_spike(:,65) ==  1));  % true positive
    b = length(find(f <= thr(i) & test_data_spike(:,65) ==  1));  % false negative
    c = length(find(f <= thr(i) &test_data_spike(:,65) == -1));  % true negative
    d = length(find(f > thr(i)  & test_data_spike(:,65) == -1));  % false positive
 SENS_step8(i,j) = a/(a+b); % sensitivity
 SPEC_step8(i,j) = c/(c+d);% specitivity
end
%% if the sensitivity is bigger than 0.999,the corresponding specitivity is instored to spec_test_step6

l = 1 ;
for i  =1 : size(SENS_step8,1)
if SENS_step8(i,j) >= 0.997 && SENS_step8(i,j) <= 0.999
   spec_test_step8(l,j) = SPEC_step8(i,j);
    l = l+ 1 ;
end
end
for t =1 : size(spec_test_step8,1)
    if spec_test_step8(t,j) ==0
        spec_test_step8(t,j) =1;
    end
end

    SPEC_LOW_MAX_step8(j) = min(spec_test_step8(:,j));
end
%%
if  ismember(j,winningclassifier) > 0
     SPEC_LOW_MAX_step8(j) = 0;   
end   

end
