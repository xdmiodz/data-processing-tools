function [nenorm] = normne(ne)
    for i=1:1:size(ne,2)
        nenorm(:,i) = ne(:,i)/max(ne(:,i));
        a = sum(nenorm(1:1:50,i));
        nenorm(:,i) = nenorm(:,i)/a;
    end
