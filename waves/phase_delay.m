function [amp, pd, td] = phase_delay(rs, bs, t, fm, df, points)
%----------------------------------------------------------------------------
% pd:	calculate phase (pd) and time (td) delay between received signal (rs) and base signal (bs) 
% also calculates the amplitude (amp) of the fm-fourirer component
%
% Input:
% rs - set of received signals
% bs - set of base signals
% t  - set of time points
% fm - the frequency of the fourier-harmonic under interest
% df - maximum possible dispersion of the fm (the disperion can occur due time-
% 	instability of a modulator)
% points - numbers of the time points, where the useful signal is 
%----------------------------------------------------------------------------
        %if (size(rs,1) != size(bs,1) & (size(rs,2) != size(bs,2)))
        %        error("input rs and bs should have the same length");
        pd = zeros(size(rs,2),1);
        td = zeros(size(rs,2),1);
        amp = zeros(size(rs,2),1);
        f_max = zeros(size(rs,2),1);
        
        for i=1:1:size(rs,2)
	        if (size(points,2) > 1)
	        	L = size(points,2);
	        else
	        	L = size(rs,1);
	        end
        	dt = t(2,i)-t(1,i);
                NFFT = 2^nextpow2(L);
                fr=fft(rs(points,i), NFFT);
                fb=fft(bs(points,i), NFFT);
                Fs = 1/dt;
                f = Fs/2*linspace(0,1,NFFT/2+1);
                fr_sel = fr(1:NFFT/2+1)/max(abs(fr(1:NFFT/2+1)));
                fb_sel = fb(1:NFFT/2+1)/max(abs(fb(1:NFFT/2+1)));
                [row,col] = find(abs(fm-f)<df/2);
                [abs_max_fb_val, pos_max] = max(abs(fb_sel(col)));
                max_freq_pos = col(pos_max);
                max_fb_val =  fb_sel(max_freq_pos);
                corresponding_fr_val = fr_sel(max_freq_pos);
                pd(i) = angle(max_fb_val) - angle(corresponding_fr_val);
                amp(i) = abs(fr_sel(max_freq_pos));
                f_max(i) = f(max_freq_pos);
        end
        pd = unwrap(pd);
        for i=1:1:size(rs,2)
                td(i) = pd(i)/(2*pi*f_max(i));
        end
