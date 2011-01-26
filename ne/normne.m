function [nenorm] = normne(ne, points)
%----------------------------------------------
%   [nenorm] = normne(ne)
%   Normailize raw data gotten from plasma density 
%   measurements. Reduce the maximum of each meauserements
%   to 1, reduce signal level to mean noise level.
%----------------------------------------------
    for i=1:1:size(ne,2)
        nenorm(:,i) = ne(:,i)/max(ne(:,i)); %reduce the maximum in each row to 1
        a = sum(nenorm(points,i)); %calculate mean noise level related parameter
        nenorm(:,i) = nenorm(:,i)/a; %reduce useful signal level to a mean noise level
    end
