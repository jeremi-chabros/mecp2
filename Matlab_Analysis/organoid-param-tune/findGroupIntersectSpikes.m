function [intersection_matrix, unique_spike_times] = findGroupIntersectSpikes(spike_struct, fs, round_decimal_places)
%FINDGROUPINTERSECTSPIKES Find matching spikes from multiple methods.
% Obtains the unique spike times from a structure containing the detected
% spike using multiple methods, and outputs a matrix where each row 
% corresponds to a single unique spike time, and where each column 
% represents a spike detection method. An entry of 1 in the matrix 
% means that the spike detection method identified a spike at that time 
% and 0 otherwise. 


wavelet_method_used = fieldnames(spike_struct);

all_spike_times = [];

for method_number = 1:numel(wavelet_method_used)

    spike_times = spike_struct.(wavelet_method_used{method_number}) / fs;
    all_spike_times = [all_spike_times, spike_times];
end

% TODO: ideally be able to round to nearest arbitrary value
% eg. currently this is rounding to nearest 0.01 ms, but ideally also 
% allow rounding to the nearest 0.02 ms 
% eg. see: https://uk.mathworks.com/matlabcentral/answers/9641-how-do-i-round-to-the-nearest-arbitrary-enumerated-value-in-matlab
if round_decimal_places > 0
    all_spike_times = round(all_spike_times, round_decimal_places);
end 


unique_spike_times = unique(all_spike_times);
%  unique_spike_times = all_spike_times;



intersection_matrix = zeros(length(unique_spike_times), ...
    length(wavelet_method_used));

for method_number = 1:numel(wavelet_method_used)

    spike_times = spike_struct.(wavelet_method_used{method_number}) / fs;
    
    if round_decimal_places > 0
        spike_times = round(spike_times, round_decimal_places);
    end 
    
    for unq_spk_t_index = 1:length(unique_spike_times)
        
        if ismember(unique_spike_times(unq_spk_t_index), spike_times)
            intersection_matrix(unq_spk_t_index, method_number) = 1;
        end
        
    end 
    
end