%%
%find rhe max spec of the spec_low_max_step6,c is index of winning
%classifier
v =1;
q =1;
e =1 ;
SENS_step7=[];
threshold=[];
SPEC_step7=[];
[A ,C] = max(SPEC_LOW_MAX_step6);
winningclassifier=[];
winningclassifier=[winningclassifier;C];
test_data_background_final=[];
trainData =pca_score_feature(:,(1:64),C);%pca_score_feature_spike_one_test(:,(1:43));pca_score_feature_spike_one_test(:,(1:12)); %;pca_score_feature(:,(1:64),C);
features = trainData;
classLabels =label_spike_background;% pca_score_feature_spike_one_test(:,13);%label_spike_background;label_spike_background;
nTrees = 100;
 
% Train the TreeBagger (Decision Forest).
B = TreeBagger(nTrees,features,classLabels, 'Method', 'classification');
%B = TreeBagger(50,features,classLabels,'OOBPrediction','On','Method','classification'); 
%B = fitcsvm(features, classLabels,'Standardize',true,'KernelFunction','RBF',...
  %  'KernelScale','auto');
%B = fitcsvm(features,classLabels,'KernelScale','auto','Standardize',true,...
 %   'OutlierFraction',0.05);
 test_data_spike =pca_score_feature_spike_one_test;%feature_spike_one_test110115;%pca_score_feature_spike_one_test;%pca_score_feature_spike_one_test;%pca_score_feature_spike_one_test contains all
%all the test data

% Use the trained Decision Forest.
[predChar1,SCORES] = B.predict(test_data_spike(:,(1:64)));
predChar1 = str2double(predChar1);
%record all the predicted spikes;index,and import the corresponding test
%data into the test_data_spike from pca_score_feature_spike_one_test

f = SCORES(:,2);
thr = unique(f); 
%thr(thr==0)=[];
for i = 1: length(thr)
a = length(find(f > thr(i)  & test_data_spike(:,65) ==  1));  % true positive
    b = length(find(f <= thr(i) & test_data_spike(:,65) ==  1));  % false negative
    c = length(find(f <= thr(i) & test_data_spike(:,65) == -1));  % true negative
    d = length(find(f > thr(i) & test_data_spike(:,65) == -1));  % false positive
 SENS_step7(i) = a/(a+b); % sensitivity
 SPEC_step7(i) = c/(c+d);% specitivity

end
%find the index of threshold which is mostly closed to 0.997
[M,W] = min(abs(SENS_step7 - 0.997));
threshold(v) = thr(W);
v = v + 1 ;
test_data_spike= [];
 s= 1;
for p = 1 : length(f)
    if f(p) >= threshold(v-1)
        test_data_spike(s,:) =pca_score_feature_spike_one_test(p,:); ;%pca_score_feature_spike_one_test contains all
%all the test data 
        s = s + 1 ;
    end
end
t=1;
test_data_background_final=[];
for z = 1 : length(f)
   if f(z) < threshold(v-1) %if the test data is predicted as spike
        test_data_background_final(t,:) = pca_score_feature_spike_one_test(z,:);%test_data_spike will be next classifier's test data
       t = t + 1 ;
    end
end
