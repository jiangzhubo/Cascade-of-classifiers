
for i= 1 :size(filename,2)
m = str2num(cell2mat(regexp(char(filename(i)),'\d', 'match')));
file_name_num(i) = m;
end
background_all=[];
%%
h =0 ;
spike_tree_one=[];
for i =110:115%[1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,21,22,23,24,25,26,27,28,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,47,49,50,51,52,53,54,59,60,61,62,63,64,65,66,67,68,69,70]%[7,20,29,46,48,55,57,110,114,118]%[12,13,14,15,114,115,116,117,118]
    for j =1:size(patient_spike,1)
        if patient_spike(j,1,i) >0.01 && patient_spike(j,17,i)>0.01
        h =h + 1 ;
            spike_tree_one(h,:) = patient_spike(j,:,i);
        end
    end
end
%% extract thepatients' backgrounds
for EEG_index = i; %% chosse the number of the patient
load(['s',num2str(EEG_index),'.mat'])     % "raw" EEG in CII referencial montage
%load(['b20','.mat']) % this is for spike -free data
eeg = data;
eeg = eeg - repmat(mean(eeg,1), size(eeg,1),1);        % convert to CAR montage                          
%in order to extract the BG with 50% overlap
nn = fix((length(data) / 32) - 1);
uu = (1:nn);
[indicators,bb,cc] = find(file_name_num == i);
end
for spike_index_y = 1 : length(indicators)
      xxx = fix((loc(indicators(spike_index_y),2) /32));
% 128 behind and before the spike location's will be removed 
if xxx > 3
uu(xxx + 1 ) = 0;
uu(xxx) = 0;
uu(xxx - 1) = 0;
uu(xxx + 2 ) = 0;
uu(xxx - 2) = 0;
uu(xxx + 3 ) = 0;
uu(xxx - 3) = 0;
uu(xxx + 4 ) = 0;
uu(xxx - 4) = 0;
end   
end
y = 1;
g= 1 ;
data_patient_background=[];
for x = 1 : 19
    y = 1;
      b_index=1;
    while( y <=(h*4))
        i = randperm(length(uu)-1,1);
        if uu(i) > 0    
data_patient_background(b_index,:,g) = data(x, uu(i) * 32 : (uu(i) * 32 + 63));
             if b_index == h
                   b_index=1;
              g =g+1;
             end
             b_index = b_index+1;
             y = y + 1; 
        end
    end   
end
background_all = [background_all;data_patient_background(:,:,(1:50))];