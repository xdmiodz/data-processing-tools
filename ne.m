function [ne] = ne(fres, f0)
    m = 9.109382e-28;
    e = -4.803204e-10;
    ne = (pi*m/(e^2))*(fres - f0).^2;
