% test the winning classifiers
e =1;
t= 1;
test_data_background_final = [];
spec_test_step=[];
%input the test data

test_data_spike_final =feature_spike_one_test110115;%pca_score_feature_spike_one_testfeature_spike_one_test ;%pca_score_feature_spike_one_test;%the original test data
 size_TEST =find(test_data_spike_final(:,44) ==1);
 size1 = size(size_TEST,1);
%%
for i = 1:size(winningclassifier,1)
trainData = pca_score_feature(:,:,winningclassifier(i));
features = trainData;
classLabels = label_spike_background;
 background_all =0;
% How many trees do you want in the forest? 
nTrees = 70;
%%
% Train random forest or svm.
%B = TreeBagger(nTrees,features,classLabels, 'Method', 'classification');
B = TreeBagger(50,features,classLabels,'OOBPrediction','On','Method','classification'); 
%B = fitcsvm(features, classLabels,'Standardize',true,'KernelFunction','RBF',...
 %   'KernelScale','auto');
%%
newData1 = [];
newData1 = test_data_spike_final(:,(1:43));
background_all = 0;
for q =1 : size(test_data_spike_final)
    if test_data_spike_final(q,44) ==-1
        background_all = background_all +1;
    end
end
spike_all =0;
for q =1 : size(test_data_spike_final)
    if test_data_spike_final(q,44) == 1
        spike_all = spike_all +1;
    end
end
newData = [];
newData = test_data_spike_final;
predChar1 = [];
SCORES = [];
% Use the trained Decision Forest.
[predChar1,SCORES] = B.predict(newData1);
f = SCORES(:,2);
%thr = unique(f); 
%predChar1 = str2double(predChar1);
s =1;
%track the test-data

 test_data_spike_final =[];
for u = 1 : length(f)
    if f(u) >= threshold(i) %if the test data is predicted as spike
        test_data_spike_final(s,:) = newData(u,:);%test_data_spike will be next classifier's test data
       s = s + 1 ;
    end
end
for z = 1 : length(f)
   if f(z) < threshold(v-1) %if the test data is predicted as spike
        test_data_background_final(t,:) = newData(z,:);%test_data_spike will be next classifier's test data
       t = t + 1 ;
    end
end

 
end
%%overall sens and spec

[a2,bb,cc]=find(test_data_spike_final(:,44) ==1);
aa2 = size(a2,1)
overall_sens_final = aa2 / size1;

[a3,bb,cc]=find(test_data_background_final(:,44) ==-1);
aa3 = size(a3,1)
overall_spec_final = aa3 /(size1*50);
