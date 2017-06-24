%locating all the spikes 
spike_toConfirmed = 0;
for i = 1 : size(SpikeIndicator,2)
    % if the waveform was confirmed as spike by a doc ,plus 1,confirmed as
    % BG,reduce 1.
    for j = 1 : 3 
        if SpikeIndicator(j,i) == 1 
            spike_toConfirmed = spike_toConfirmed + 1 ;
        end
         if SpikeIndicator(j,i) == -1 
            spike_toConfirmed = spike_toConfirmed - 1 ;
         end
       
        
    end
    if spike_toConfirmed >= 1
        spike_detection_test_allspike(i) = 1;
    end
    if spike_toConfirmed < 1
        spike_detection_test_allspike(i) = 0;
    end
    spike_toConfirmed = 0;
end
