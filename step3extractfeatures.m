
%%extract features
pca_score_feature_spike_one =[];
pca_score_feature_spike_one = old_extract_feature(spike_tree_one);
background_tree_one=[];
background_tree_one=background_all;
pca_score_feature_background_one= []; 
for i=1 : 50
  pca_score_feature_background_all=[];
    pca_score_feature_background_all = old_extract_feature(background_tree_one(:,:,i));
    pca_score_feature_background_one(:,:,i) =pca_score_feature_background_all ;
end
%%
label_spike_background =0;
label_spike_background(1:length(pca_score_feature_spike_one)) = 1;
label_spike_background(length(pca_score_feature_spike_one)+1:(length(pca_score_feature_spike_one)+size(pca_score_feature_background_one,1))) = -1;
label_spike_background = label_spike_background';
%[pc_b,pca_score_feature_background_one,latent_b] = pca(feature_background_one);
%[pc_s,pca_score_feature_spike_one,latent_s] = pca(feature_spike_one);
% for raw data
%pca_score_feature_background_one =background_all;
%pca_score_feature_spike_one= spike_tree_one;
a =  pca_score_feature_background_one;
b = pca_score_feature_spike_one;