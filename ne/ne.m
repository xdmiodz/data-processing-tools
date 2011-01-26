function [ne] = ne(fres, f0)
%-----------------------------------------------
%   [ne] = ne(fres,f0)
%   calculates plasma density corresponded to response
%   of an UHF-resonator based on double line. The non-shifted
%   eigen-frequency of the resonator is f0.
%   The density values are in cm^-3
%------------------------------------------------
    fpe2 = (fres.^2 - f0^2);
    ne = fpe2/((5.64e4/(2*pi))^2);
