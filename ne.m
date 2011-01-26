function [ne] = ne(fres, f0)
    m = 9.109382e-28;
    e = -4.803204e-10;
    fpe2 = (fres.^2 - f0^2);
    ne = fpe2/((5.64e4/(2*pi))^2);
