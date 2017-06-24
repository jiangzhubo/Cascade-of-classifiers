%make the input data for test
pca_score_feature_spike_one_test = pca_score_feature_spike_one;
for i = 1 :50
pca_score_feature_spike_one_test((length(feature_spike_one)*i+1):(length(feature_spike_one)*(i+1)),:) = pca_score_feature_background_one(:,:,i);%pca_score_feature_background_one(:,:,i);
end
pca_score_feature_spike_one_test((1:length(feature_spike_one)),44) =1;
pca_score_feature_spike_one_test((length(pca_score_feature_spike_one)+1):end,44) =-1;
%disorder the input data 's sequence
%k = randperm(length( pca_score_feature_spike_one_test),length( pca_score_feature_spike_one_test));
%for i = 1 : length( pca_score_feature_spike_one_test)
%pca_score_feature_spike_one_test(i,:) = pca_score_feature_spike_one_test(k(i),:);
%end
