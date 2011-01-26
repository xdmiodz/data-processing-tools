function [nenorm] = normne(ne)
    for i=1:1:size(ne,2)
        nenorm(:,i) = ne(:,i)/max(ne(:,i));
    end
