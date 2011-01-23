function [amp, pd, td] = phase_delay(rs, bs, fm, df, dt)
%----------------------------------------------------------------------------
% pd:calculate phase (pd) delay between received signal (rs) and base signal (bs) 
% also calculates amp of the 
%----------------------------------------------------------------------------
        %if (size(rs,1) != size(bs,1) & (size(rs,2) != size(bs,2)))
        %        error("input rs and bs should have the same length");
        pd = zeros(size(rs,2),1);
        td = zeros(size(rs,2),1);
        amp = zeros(size(rs,2),1);
        f_max = zeros(size(rs,2),1);
        L = size(rs,1);
        for i=1:1:size(rs,2)
                NFFT = 2^nextpow2(L);
                fr=fft(rs(:,i));
                fb=fft(bs(:,i));
                Fs = 1/dt;
                f = Fs/2*linspace(0,1,NFFT/2+1);
                fr_sel = fr(1:NFFT/2+1);
                fb_sel = fb(1:NFFT/2+1);
                [row,col] = find(abs(fm-f)<df/2);
                [max_fb_val, pos_max] = max(abs(fb_sel(col)));
                max_freq_pos = col(pos_max);
                corresponding_fr_val = fr_sel(max_freq_pos);
                pd(i) = -angle(max_fb_val) + angle(corresponding_fr_val);
                amp(i) = abs(fr_sel(max_freq_pos));
                f_max(i) = f(max_freq_pos);
        end
        pd = unwrap(pd-pd(1));
        for i=1:1:size(rs,2)
                td(i) = pd(i)/f_max(i);
        end
