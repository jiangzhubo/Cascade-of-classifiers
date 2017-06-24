%% 
feature_background_one =pca_score_feature_background_one;
feature_spike_one =pca_score_feature_spike_one;
pca_score_feature=[];
%% 50 classifiers ,each classifier has N spikes and N BGs
for i = 1 : 50
pca_score_feature((1 : length(feature_spike_one)),:,i) = feature_spike_one;%((1:length(feature_spike_one)),:);  
pca_score_feature(((length(feature_spike_one)+1):(length(feature_spike_one)+size(feature_background_one))),:,i) = feature_background_one(:,:,i);%(((length(feature_spike_one) *(i-1)+1):(length(feature_spike_one)*i)),:);   
end