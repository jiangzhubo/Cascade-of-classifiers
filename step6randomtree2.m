SENS_step6 = [];
SPEC_step6 = [];
SPEC_LOW_MAX_step6 =[];
v =1;
for j =1 : 50    
trainData =pca_score_feature(:,:,j);%pca_score_feature_spike_one_test(:,(1:64)); %
features = trainData;
classLabels =label_spike_background;%pca_score_feature_spike_one_test(:,65); %label_spike_background;
%% How many trees do you want in the forest? 
nTrees = 10;
 %%
B = TreeBagger(nTrees,features,classLabels, 'Method', 'classification');
% Train the TreeBagger (Decision Forest).
%B = TreeBagger(50,features,classLabels,'OOBPrediction','On','Method','classification');
%B = fitcsvm(features, classLabels,'Standardize',true,'KernelFunction','RBF',...
 %   'KernelScale','auto');
% B = fitcsvm(features,classLabels,'KernelScale','auto','Standardize',true,...
 %   'OutlierFraction',0.05);
%%
newData1 =pca_score_feature_spike_one_test(:,(1:64));
% Use the trained Decision Forest.
[predChar1,SCORES] = B.predict(newData1);

%[predChar1,SCORES] = predict(B,newData1);%for SVM

f = SCORES(:,2);
thr = unique(f); 
predictedClass = str2double(predChar1);
for i = 1: length(thr)
 a = length(find(f > thr(i)  & pca_score_feature_spike_one_test(:,65) ==  1));  % true positive
    b = length(find(f <= thr(i) & pca_score_feature_spike_one_test(:,65) ==  1));  % false negative
    c = length(find(f <= thr(i) & pca_score_feature_spike_one_test(:,65) == -1));  % true negative
    d = length(find(f > thr(i) & pca_score_feature_spike_one_test(:,65 ) == -1));  % false positive
 SENS_step6(i,j) = a/(a+b); % sensitivity
 SPEC_step6(i,j) = c/(c+d);% specitivity
end
%% if the sensitivity is aound the 0.998,the corresponding specitivity is instored to spec_test_step6

l = 1 ;
for i  =1 : size(SENS_step6,1)
if SENS_step6(i,j) >= 0.997 && SENS_step6(i,j) <= 0.999
   spec_test_step6(l,j) = SPEC_step6(i,j);
    l = l+ 1 ;
end

end
for t =1 : size(spec_test_step6,1)
    if spec_test_step6(t,j) ==0
        spec_test_step6(t,j) =1;
    end
end

minspec= 0;
    minspec = min(spec_test_step6(:,j));
    SPEC_LOW_MAX_step6 = [SPEC_LOW_MAX_step6;minspec];
%%find the min spec in spec_test_step6 of every classifier
%SPEC_LOW_MAX_step6(j) = min(spec_test_step6);
end
