%extract the patients' spikes 
h =1 ;
spike_tree_one=[];
for i =110:115%[1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,21,22,23,24,25,26,27,28,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,47,49,50,51,52,53,54,59,60,61,62,63,64,65,66,67,68,69,70]%[13,20,29,46,48,55,57,110,114,116]
    for j =1:size(patient_spike,1)
        if patient_spike(j,1,i) >0.01 && patient_spike(j,17,i)>0.01 %in case there is all-zero 
    spike_tree_one(h,:) = patient_spike(j,:,i);
    h =h + 1 ;
        end
    end
end