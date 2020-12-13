function [result, f, t] = custom_spectrogram(file_name, l_w, n_fft)

% load an audio file
[x, fs] = audioread(file_name);   % load an audio file
x = x(:, 1);                        % get the first channel

% magnitude = abs(fft(x, n_fft));

w=(1:n_fft)*fs/n_fft;

l_x = length(x);
%l_w = 256; % length of window

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

end