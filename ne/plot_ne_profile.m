function plot_ne_profile(t, osc, fres, f0, points, title_string)
%----------------------------------------------------------------------------
% Plot plasma density vs. time on 2D colormap, where X-axe is time points,
% Y-axe is plasme density value, and colormap is corresponded to sygnal level.
% True plasma density vs. time profile is the path which connects continuosly 
% signal peaks on the map
% t - set of time points
% osc - set of signal points, gotten from plasma density measurements
% fres - set of frequencies the UHF resonator was fed by
% f0 - nonshifted eigenfrequncy of the UHF resonator
% points - points of osc, where only noise is presented, it is necessary to
% calcluate mean noise level
% title - title of the output 2D map
%----------------------------------------------------------------------------
    [ne_Y] = ne(fres, f0);
    [ne_norm] = normne(osc, points);
    h=pcolor(t(:,1), ne_Y, ne_norm'); 
    set(h,'edgecolor','none');
    colorbar;
    title(title_string);
    filename=sprintf("%s.eps",title_string);
    xlabel('t, s'); ylabel('n_{e}, cm^{-3}');
    print(filename, '-deps', '-color');
    
