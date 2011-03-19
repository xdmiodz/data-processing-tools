function plot_ne_profile(t, osc, fres, f0, noise_level, search_area, title_string)
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
    pathX = 0;
    pathY = 0;
    [ne_Y] = ne0(fres, f0);
    [ne_norm] = normne(osc, noise_level);
    width = search_area(1);
    height = search_area(2);
    [maxv, rstart] = max(ne_norm(:,1));
    pathX(1) = rstart;
    pathY(1) = 1;
    r = rstart + (height-1)/2 + 1;
    c = 1;
    k = 2;
    while (1)
        [row,col] = max_in_area(ne_norm, r, c, width, height);
         pathX(k) = row;
         pathY(k) = col;
         r = row + (height-1)/2 + 1;
         c = col ;
         k = k + 1;
         
         if (r > size(ne_norm,1) || ( c > size(ne_norm,2)))
             break
         end
    end
    %h=surface(ne_norm'); 
    %set(h,'edgecolor','none');
    plot(pathX, (sort(pathY, 'descend')))
    %colorbar;
    %title(title_string);
    %filename=sprintf("%s.eps",title_string);
    %xlabel('t, s'); ylabel('n_{e}, cm^{-3}');
   % print(filename, '-deps', '-color');
    
end

function [row, col] = max_in_area(data, row0, col0, width, height)
    rstart = ((row0-(height-1)/2) > 0)*(row0-(height-1)/2 - 1) + 1;
    cstart = ((col0-(width-1)/2) > 0)*(col0-(width-1)/2 - 1) + 1;
    rend = ((row0 + (height-1)/2) <= size(data,1))*(row0+(height-1)/2 - size(data,1)) + size(data,1);
    cend = ((col0+(width-1)/2) <= size(data,2))*(col0+(width-1)/2 - size(data,2)) + size(data,2);
    adata = data(rstart:1:rend, cstart:1:cend);
    [vals,rows] = max(adata);
    [lmax, lmaxpos] = max(vals);
    row = rstart + rows(lmaxpos);
    col = cstart + lmaxpos;
    if (isempty(row) || isempty(col))
        row0
        col0
        rstart
        rend
        cstart
        cend
    end
end