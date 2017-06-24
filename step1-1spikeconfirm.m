%extract the patient spike 
h =1;fs = 128;
for i = 1:161
  load([ 's' num2str(i) '.mat'])
     eeg = data;                                     
      eeg = eeg - repmat(mean(eeg,1), size(eeg,1),1);   
    l = round(fs/2);      
   for k = 1 :size(new_loc,2)
    if new_loc(i,k) ~= 0 %new_loc contains all the spikes location,0 means not a spike
    patient_spike(h,:,i) = eeg(loc(new_loc(i,k),1),loc(new_loc(i,k),2):(loc(new_loc(i,k),2)+l-1));
   h = h + 1;
    end  
   end
   h =1;
end