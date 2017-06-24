[A ,C] = max(SPEC_LOW_MAX_step8);
winningclassifier=[winningclassifier;C];
trainData = pca_score_feature(:,:,C);
features = trainData;
classLabels = label_spike_background;
nTrees = 100;
 SENS_step9 = [];
 SPEC_step9 =[];
% Train the TreeBagger (Decision Forest).
B = TreeBagger(nTrees,features,classLabels, 'Method', 'classification');
%B = TreeBagger(50,features,classLabels,'OOBPrediction','On','Method','classification'); 
%B = fitcsvm(features, classLabels,'Standardize',true,'KernelFunction','RBF',...
 %   'KernelScale','auto');
% B = fitcsvm(features,classLabels,'KernelScale','auto','Standardize',true,...
  %  'OutlierFraction',0.05);
%newData1 =pca_score_feature_spike_one_test(:,(1:20));
newData1 =test_data_spike(:,(1:64));
newData =test_data_spike;
 
% Use the trained Decision Forest.
predChar1 = B.predict(newData1);
predChar1 = str2double(predChar1);
f = SCORES(:,2);
thr = unique(f); 
%thr = vpa(thr);
%thr = unique(thr);
for i =1 : length(thr)
   a = length(find(f > thr(i)  & test_data_spike(:,65) ==  1));  % true positive
    b = length(find(f <= thr(i) & test_data_spike(:,65) ==  1));  % false negative
    c = length(find(f <= thr(i) &test_data_spike(:,65) == -1));  % true negative
    d = length(find(f > thr(i)  & test_data_spike(:,65) == -1));  % false positive
 SENS_step9(i) = a/(a+b); % sensitivity
 SPEC_step9(i) = c/(c+d);% specitivity

end
[M,W] = min(abs(SENS_step9 - 0.997));

threshold(v) = thr(W);
   v = v + 1 ;
s =1;
test_data_spike = [];
for p = 1 : length(f)
    if f(p) >=threshold(v-1)%if the test data is predicted as Aspike
        test_data_spike(s,:) = newData(p,:);%newData will be next classifier's test data
       s = s + 1 ;
    end
end

for z = 1 : length(f)
   if f(z) < threshold(v-1) %if the test data is predicted as a BG
        test_data_background_final(t,:) = newData(z,:);%newData will be next classifier's test data
       t = t + 1 ;
    end
end