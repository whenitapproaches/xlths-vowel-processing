function [formants] = find_formants(file_name, t_start, t_end)

    [x, fs] = audioread(file_name); 
    x = x(:, 1);
    
    dt = 1/fs;
    I0 = round(t_start/dt);
    Iend = round(t_end/dt);
    z = x(I0:Iend);

    x1 = z.*rectwin(length(z));

    preemph = [1 0.63];
    x1 = filter(1,preemph,x1);

    A = lpc(x1,8);
    rts = roots(A);

    rts = rts(imag(rts)>=0);
    angz = atan2(imag(rts),real(rts));

    [frqs,indices] = sort(angz.*(fs/(2*pi)));
    bw = -1/2*(fs/(2*pi))*log(abs(rts(indices)));

    nn = 1;
    for kk = 1:length(frqs)
        if (frqs(kk) > 90 && bw(kk) <400)
            formants(nn) = frqs(kk);
            nn = nn+1;
        end
    end
    formants(end) = [];
    
end