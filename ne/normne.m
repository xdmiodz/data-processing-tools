function [nenorm] = normne(ne, noise_level)
%----------------------------------------------
%   [nenorm] = normne(ne)
%   Normailize raw data gotten from plasma density 
%   measurements. Reduce the maximum of each meauserements
%   to 1, reduce signal level to mean noise level.
%----------------------------------------------
maxne = max(max(ne));
    for i=1:1:size(ne,2)
    	
    	all_rows = 1:1:size(ne,1);
    	all_cols = 1:1:size(ne,2);
        nenorm(:,i) = ne(:,i)/max(max(ne)); %reduce the maximum in each row to 1
        %[noise_rows, noise_cols] = find(nenorm < noise_level);
        %useful_rows = setdiff(all_rows, noise_rows);
        %useful_cols = setdiff(all_cols, noise_cols);
        %noise_rows;
        %noise_cols;
        %useful_cols;
        %nenorm(useful_rows, useful_cols) = 1;
        %nenorm(noise_rows, noise_cols) = 0;
        %mean_noise = mean(nenorm(noise_rows, i));
        %nenorm(:,i) = nenorm(:,i) / mean_noise;
    end
