person_name = 'chung';

consonant_a = strcat(person_name, '_a.wav');
consonant_e = strcat(person_name, '_e.wav');
consonant_u = strcat(person_name, '_u.wav');
consonant_o = strcat(person_name, '_o.wav');
consonant_i = strcat(person_name, '_i.wav');

% load an audio file
[x, fs] = audioread(consonant_a);
x = x(:, 1);                        % get the first channel


n_fft = 1024;

% magnitude = abs(fft(x, n_fft));

w=(1:n_fft)*fs/n_fft;

l_x = length(x);
l_w = 256; % length of window

% Tao ma tran gia tri

n_row = n_fft/2; % fft points
n_col = floor(l_x/l_w);

result = zeros(n_row, n_col); % khoi tao ket qua

win = rectwin(l_w); % tao window hinh chu nhat co do dai l_w

for i=0:n_col-1
    
    x_win = x(1 + l_w.*i : l_w.*i + l_w).*win; % window frame
    
    x_fft = fft(x_win, n_fft); % bien doi fourier frame
    
    result(:, i+1) = x_fft(1:n_row); % tra ve gia tri o cot i+1
end

t = (0:l_w:(n_col-1)*l_w)/fs;
f = (0:n_row-1)*fs/n_fft;

result = abs(result)/l_w;

result = mag2db(result);
figure(1)
surf(t, f, result)
shading interp
axis tight
view(0, 90)
xlabel('Thoi Gian, s')
ylabel('Tan So, Hz')
title('Spectrogram')
hcol = colorbar;
set(hcol, 'FontName', 'Times New Roman', 'FontSize', 14)
ylabel(hcol, 'Cuong Do, dB')




x_fft = abs(fft(x, n_fft)); %

figure(2);
plot(f,x_fft(1:n_fft/2),'k','LineWidth',1);
title('Linear Magnitude Spectrum');
xlabel('Frequency (Hz)')
ylabel('Magnitude');





