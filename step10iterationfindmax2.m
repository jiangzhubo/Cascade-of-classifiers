%% do the iterations to find the bestclassifier

for i = 1 :9%10 STAGES
    step8iterationtofind_another_winningclassifer2;
    step9iterationtofind_another_winningclassifer2;
end
%%
[aa,bb,cc]=find(test_data_background_final(:,44) ==-1);
rejected_bgs = size(aa,1)
%%
[a2,bb,cc]=find(test_data_spike(:,44) ==1);
reserved_spikes = size(a2,1)

